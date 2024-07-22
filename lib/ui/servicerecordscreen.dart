// ignore_for_file: prefer_collection_literals

import 'package:flutter/material.dart';
import 'package:people_app/services/api.services.dart';
import 'package:people_app/models/emp_login.dart';
import 'dart:convert';
import 'package:people_app/models/Service_Log.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:people_app/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:people_app/models/utils.dart';
import 'package:people_app/ui/servicerecorddetailscreen.dart';

class ServiceRecordScreen extends StatefulWidget {
  ServiceRecordScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ServiceRecordScreenState();
}

class _ServiceRecordScreenState extends State<ServiceRecordScreen> {
  List<Service_Log>? service_logs;

  double screenHeight = 0;
  double screenWidth = 0;

  Color primary = const Color(0xFF0288D1);

  String _month = DateFormat('MMMM').format(DateTime.now());
  String _year = DateFormat('yyyy').format(DateTime.now());

  String vTodayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateTime vToday = DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));

  @override
  void initState() {
    super.initState();
    _getRecord();
  }

  void _getRecord() async {
    print('_getRecord');
    print('_month:' + _month);
    print('_year:' + _year);

    try{
      await APIServices.fetchServiceLogByEmpIDMonthYear(User.employeeId,_month,_year).then((response) async{
        Iterable list=json.decode(response.body);
        List<Service_Log>? sList;
        sList = list.map((model)=> Service_Log.fromObject(model)).toList();

        setState(() {
          service_logs = sList!;
        });

      });

    }catch(e){
      //print('fetchServiceLogByEmpIDMonthYear Err');
      ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text('Catch Err: ' + e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: _buildFloatingButton(),
      appBar: AppBar(
        title:Text('Service Record List'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 32),
                  child: Text(
                    _month,
                    style: TextStyle(
                      fontFamily: "NexaBold",
                      fontSize: screenWidth / 18,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 32),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0),
                      child: IconButton(tooltip: 'Reload', icon: Icon(Icons.refresh),onPressed: () async{
                        _getRecord();
                        setState(() {});
                      },)
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(top: 32),
                  child: GestureDetector(
                    onTap: () async {

                      final month = await showMonthYearPicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2022),
                          lastDate: DateTime(2099),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: primary,
                                  secondary: primary,
                                  onSecondary: Colors.white,
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    primary: primary,
                                  ),
                                ),
                                textTheme: const TextTheme(
                                  headline4: TextStyle(
                                    fontFamily: "NexaBold",
                                  ),
                                  overline: TextStyle(
                                    fontFamily: "NexaBold",
                                  ),
                                  button: TextStyle(
                                    fontFamily: "NexaBold",
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          }
                      );

                      if(month != null) {
                        setState(() {
                          _month = DateFormat('MMMM').format(month);
                          _year = DateFormat('yyyy').format(month);
                          _getRecord();
                        });
                      }


                    },
                    child: Text(
                      "Pick a Month",
                      style: TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: screenWidth / 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(padding: EdgeInsets.only(top:15.0,bottom: 15.0)),

            SizedBox(
              height: screenHeight / 1.45,
              child: (service_logs == null) ? Center(child: Text('Empty'),) : _buildServiceList(),
              //child: (service_logs == null) ? Center(child: Text('Empty'),) : Center(child: Text('aaa'),),
            ),
          ],
        ),
      ),

    );
  }

  Widget _buildAppBar(){
    return AppBar(
      title:Text('Service Record'),
    );
  }

  Widget _buildServiceList(){
    print('_buildServiceList');
    print(service_logs?.length);
    return ListView.builder(
      itemCount: service_logs?.length,
      itemBuilder: (context, index){
        print(index);
        print(service_logs![index].targetDate);
        return Card(
          color: Colors.white,
          elevation: 2.0,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:<Widget> [
              Expanded(
                child: Text(
                  DateFormat('yyyy-MM-dd').format(service_logs![index].targetDate as DateTime),
                  style: TextStyle(
                    fontFamily: "NexaBold",
                    fontSize: screenWidth / 26,
                  ),
                ),
              ),

              Expanded(
                child: Text(
                  service_logs![index].product as String,
                  style: TextStyle(
                    fontFamily: "NexaBold",
                    fontSize: screenWidth / 26,
                  ),
                ),
              ),

              Expanded(
                child: Text(
                  service_logs![index].client as String,
                  style: TextStyle(
                    fontFamily: "NexaBold",
                    fontSize: screenWidth / 26,
                  ),
                ),
              ),

              Expanded(
                child: ListTile(
                  trailing: Icon(Icons.arrow_forward_ios),
                  title: Text(service_logs![index].finish as bool == true ? 'F' : 'NF'),
                  onTap: () {
                    navigateToServiceDetail(service_logs![index]);
                  },
                ),
              ),

            ],
          ),

        );
      },
    );
  }

  void navigateToServiceDetail(Service_Log log) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceRecordDetailScreen(log)));
  }

  Widget _buildFloatingButton(){
    return FloatingActionButton(
        tooltip: "Add Service Record",
        child: Icon(Icons.work),
        onPressed: (){
          navigateToServiceDetail(Service_Log.WithId(m_ServiceID:0, m_TeamID:0, m_Product: '', m_Client: '',
            m_Description:'', m_ReqDate:vToday, m_TargetDate:vToday, m_Finish:false, m_Charges:0, m_Income: 0, m_Expense: 0, m_IEType: 0,
            m_Paid:false, m_Remark:'', m_EmpID:User.employeeId, m_editUserID: User.employeeId, m_editDateTime: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()))));
        });
  }

  Widget displayByLevel(){
    var sheet = Icon(Icons.money,color: Colors.lightBlue,);

    return (sheet);
  }

}
