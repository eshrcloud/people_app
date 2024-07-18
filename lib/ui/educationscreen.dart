// ignore_for_file: prefer_collection_literals

import 'package:flutter/material.dart';
import 'package:people_app/services/api.services.dart';
import 'dart:convert';
import 'package:people_app/models/emp_education_user_req.dart';
import 'package:people_app/models/edu_type.dart';
import 'package:people_app/models/degree_diploma.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:people_app/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:people_app/models/utils.dart';
import 'package:people_app/ui/educationdetailscreen.dart';

class EducationScreen extends StatefulWidget {
  EducationScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  List<Emp_Education_User_Req>? emp_education_user_reqs;
  List<Edu_Type>? _edu_Types;
  late List<String> _edu_List= [''];

  List<Degree_Diploma>? _degrees;
  late List<String> _degree_List= [''];

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
    _getRowSource();
    _getRecord();
  }

  void _getRowSource() async {
    await APIServices.fetchEduType().then((response) async{
      Iterable list=json.decode(response.body);
      List<Edu_Type>? eList;
      eList = list.map((model)=> Edu_Type.fromObject(model)).toList();

      _edu_Types = eList;

      if (eList!.isNotEmpty) {
        if (eList!.length > 0) {
          eList.forEach((item) {
            setState(() {
              _edu_List.remove(item.edu_Type_Desp);
              _edu_List.add(item.edu_Type_Desp);
            });
          });
        }
        else {
          //print('fetchRelation isEmpty');
        }
      }
    });

    await APIServices.fetchDegree().then((response) async{
      Iterable list=json.decode(response.body);
      List<Degree_Diploma>? dList;
      dList = list.map((model)=> Degree_Diploma.fromObject(model)).toList();

      _degrees = dList;

      if (dList!.isNotEmpty) {
        if (dList!.length > 0) {
          dList.forEach((item) {
            setState(() {
              _degree_List.remove(item.degree_Name);
              _degree_List.add(item.degree_Name);
            });
          });
        }
        else {
          //print('fetchRelation isEmpty');
        }
      }
    });
  }

  void _getRecord() async {
    print('_getRecord');
    try{
      await APIServices.fetchEmpEducation(User.employeeId).then((response) async{

        if (response.body.toString()=="[]") {
          if (emp_education_user_reqs!= null) {
            if (emp_education_user_reqs!.length > 0) {
              emp_education_user_reqs!.removeRange(
                  0, emp_education_user_reqs!.length);
            }
          }
          return;
        }

        Iterable list=json.decode(response.body);
        List<Emp_Education_User_Req>? sList;
        if (list.length > 0) {
          sList = list.map((model) => Emp_Education_User_Req.fromObject(model))
              .toList();

          setState(() {
            emp_education_user_reqs = sList!;
          });
        }
      });

    }catch(e){
      //print('fetchEmpFamily Err');
      ScaffoldMessenger.of(context)
        ..showSnackBar(SnackBar(content: Text('Catch Err: ' + e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: _buildFloatingButton(),
      appBar: AppBar(
        title:Text('Education List'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0),
                      child: IconButton(
                        tooltip: 'Sync Data',
                        icon: Icon(Icons.sync),
                        onPressed: () async{
                          await APIServices.fetchUserReq(User.employeeId).then((response) async{  });
                          _getRecord();
                        },)
                  ),
                ),

                Expanded(
                  //alignment: Alignment.center,
                  //margin: const EdgeInsets.only(top: 32),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0),
                      child: IconButton(tooltip: 'Reload', icon: Icon(Icons.refresh),onPressed: () async{
                        _getRecord();
                        setState(() {});
                      },)
                  ),

                ),

              ],
            ),

            Padding(padding: EdgeInsets.only(top:15.0,bottom: 15.0)),

            SizedBox(
              height: screenHeight / 1.45,
              child: (emp_education_user_reqs == null) ? Center(child: Text('Empty'),) : _buildEducationList(),
            ),
          ],
        ),
      ),

    );
  }

  Widget _buildAppBar(){
    return AppBar(
      title:Text('Family'),
    );
  }

  Widget _buildEducationList(){
    print('_buildEducationList');
    print(emp_education_user_reqs?.length);
    return ListView.builder(
      itemCount: emp_education_user_reqs?.length,
      itemBuilder: (context, index){
        print(index);
        print(emp_education_user_reqs![index].tran_ID);
        return Card(
          color: Colors.white,
          elevation: 2.0,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:<Widget> [

              Expanded(
                child: Text(
                  emp_education_user_reqs![index].edu_Desp.toString(),
                  style: TextStyle(
                    fontFamily: "NexaBold",
                    fontSize: screenWidth / 26,
                  ),
                ),
              ),

              Expanded(
                child: Text(
                  emp_education_user_reqs![index].institute_College.toString(),
                  style: TextStyle(
                    fontFamily: "NexaBold",
                    fontSize: screenWidth / 26,
                  ),
                ),
              ),

              Expanded(
                child: Text(
                  retrieveDegree(emp_education_user_reqs![index].degree_ID),
                  style: TextStyle(
                    fontFamily: "NexaBold",
                    fontSize: screenWidth / 26,
                  ),
                ),
              ),

              Expanded(
                child: Text(
                  retrieveEduType(emp_education_user_reqs![index].edu_Type_ID),
                  style: TextStyle(
                    fontFamily: "NexaBold",
                    fontSize: screenWidth / 26,
                  ),
                ),
              ),

              Expanded(
                child: ListTile(
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    navigateToEducationDetail(emp_education_user_reqs![index]);
                  },
                ),
              ),

            ],
          ),

        );
      },
    );
  }

  String retrieveEduType(int? value){
    String vReturn='';
    if (_edu_Types == null) return '';
    _edu_Types!.forEach((item) {
      if (item.edu_Type_ID == value){
        vReturn = item.edu_Type_Desp;
      }
    });
    return vReturn;
  }

  String retrieveDegree(int? value){
    String vReturn='';
    if (_degrees == null) return '';
    _degrees!.forEach((item) {
      if (item.degree_ID == value){
        vReturn = item.degree_Name;
      }
    });
    return vReturn;
  }

  void navigateToEducationDetail(Emp_Education_User_Req log) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => EducationDetailScreen(log)));
    //_getRecord();
  }

  Widget _buildFloatingButton(){
    return FloatingActionButton(
        tooltip: "Add Education",
        child: Icon(Icons.school),
        onPressed: (){
          navigateToEducationDetail(Emp_Education_User_Req.WithId(m_autoID: 0, m_req_ID: 0, m_tran_ID: 0, m_emp_ID: double.parse(User.employeeId.toString()),
              m_fromYear: null, m_toYear: null, m_edu_Type_ID: null, m_edu_Desp: '', m_degree_ID: null, m_edu_Year: null, m_institute_College: '',
              m_remark: '', m_year_Achieve: null, m_location: '', m_new_Flag: true, m_req_Date: vToday, m_editUserID: User.employeeId, m_editDateTime: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()))));
        });
  }

  Widget displayByLevel(){
    var sheet = Icon(Icons.money,color: Colors.lightBlue,);

    return (sheet);
  }

}
