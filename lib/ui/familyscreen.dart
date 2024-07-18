// ignore_for_file: prefer_collection_literals

import 'package:flutter/material.dart';
import 'package:people_app/services/api.services.dart';
import 'package:people_app/models/emp_login.dart';
import 'dart:convert';
import 'package:people_app/models/emp_family_user_req.dart';
import 'package:people_app/models/relationship.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:people_app/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:people_app/models/utils.dart';
import 'package:people_app/ui/familydetailscreen.dart';

class FamilyScreen extends StatefulWidget {
  FamilyScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FamilyScreenState();
}

class _FamilyScreenState extends State<FamilyScreen> {
  List<Emp_Family_User_Req>? emp_family_user_reqs;
  List<Relationship>? _relations;
  late List<String> _realtion_List= [''];

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
    await APIServices.fetchRelation().then((response) async{
      Iterable list=json.decode(response.body);
      List<Relationship>? rList;
      rList = list.map((model)=> Relationship.fromObject(model)).toList();

      _relations = rList;

      if (rList!.isNotEmpty) {
        if (rList!.length > 0) {
          rList.forEach((item) {
            setState(() {
              _realtion_List.remove(item.relationShip_Name);
              _realtion_List.add(item.relationShip_Name);
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
      await APIServices.fetchEmpFamily(User.employeeId).then((response) async{

        if (response.body.toString()=="[]") {
          if (emp_family_user_reqs!= null) {
            if (emp_family_user_reqs!.length > 0) {
              emp_family_user_reqs!.removeRange(
                  0, emp_family_user_reqs!.length);
            }
          }
          return;
        }

        Iterable list=json.decode(response.body);
        List<Emp_Family_User_Req>? sList;
        sList = list.map((model)=> Emp_Family_User_Req.fromObject(model)).toList();

        setState(() {
          emp_family_user_reqs = sList!;
        });

      });

    }catch(e){
      //print('fetchEmpFamily Err');
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
        title:Text('Family List'),
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
                      child: IconButton(tooltip: 'Sync Data',icon: Icon(Icons.sync),onPressed: () async{
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
                      child: IconButton(tooltip: 'Reload',icon: Icon(Icons.refresh),onPressed: () async{
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
              child: (emp_family_user_reqs == null) ? Center(child: Text('Empty'),) : _buildFamilyList(),
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

  Widget _buildFamilyList(){
    print('_buildFamilyList');
    print(emp_family_user_reqs?.length);
    return ListView.builder(
      itemCount: emp_family_user_reqs?.length,
      itemBuilder: (context, index){
        print(index);
        print(emp_family_user_reqs![index].name);
        return Card(
          color: Colors.white,
          elevation: 2.0,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:<Widget> [
              Expanded(
                child: Text(
                  emp_family_user_reqs![index].name.toString(),
                  style: TextStyle(
                    fontFamily: "NexaBold",
                    fontSize: screenWidth / 26,
                  ),
                ),
              ),

              Expanded(
                child: Text(
                  retrieveRelationship(emp_family_user_reqs![index].relationShip_ID),
                  style: TextStyle(
                    fontFamily: "NexaBold",
                    fontSize: screenWidth / 26,
                  ),
                ),
              ),

              Expanded(
                child: Text(
                  emp_family_user_reqs![index].age.toString(),
                  style: TextStyle(
                    fontFamily: "NexaBold",
                    fontSize: screenWidth / 26,
                  ),
                ),
              ),

              Expanded(
                child: ListTile(
                  trailing: Icon(Icons.arrow_forward_ios),
                  title: Text(emp_family_user_reqs![index].expire as bool == true ? 'E' : 'NE'),
                  onTap: () {
                    navigateToFamilyDetail(emp_family_user_reqs![index]);
                  },
                ),
              ),

            ],
          ),

        );
      },
    );
  }

  String retrieveRelationship(int? value){
    String vReturn='';
    if (_relations == null) return '';
    _relations!.forEach((item) {
      if (item.relationShip_ID == value){
        vReturn = item.relationShip_Name;
      }
    });
    return vReturn;
  }

  void navigateToFamilyDetail(Emp_Family_User_Req log) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => FamilyDetailScreen(log)));
    //_getRecord();
  }

  Widget _buildFloatingButton(){
    return FloatingActionButton(
        tooltip: "Add Family",
        child: Icon(Icons.person_add),
        onPressed: (){
          navigateToFamilyDetail(Emp_Family_User_Req.WithId(m_autoID: 0, m_req_ID: 0, m_tran_ID: 0, m_emp_ID: double.parse(User.employeeId.toString()),
              m_name: '', m_sex: 1, m_relationShip_ID: 1, m_nRC_NO: '', m_email: '', m_education: '', m_occupation: '', m_address: '', m_expire: false, m_remark: '',
              m_tax_Allowance: false, m_foreign_Stay: 0, m_punishment: 0, m_age: '', m_birth_Date: vToday, m_new_Flag: true, m_req_Date: vToday, m_editUserID: User.employeeId, m_editDateTime: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()))));
        });
  }

  Widget displayByLevel(){
    var sheet = Icon(Icons.money,color: Colors.lightBlue,);

    return (sheet);
  }

}
