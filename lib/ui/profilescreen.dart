import 'package:shared_preferences/shared_preferences.dart';
import 'package:people_app/models/emp_login.dart';
import 'package:people_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:people_app/ui/userscreen.dart';
import 'package:people_app/ui/personalscreen.dart';
//import 'package:people_app/ui/familyscreenmix.dart';
//import 'package:people_app/ui/educationscreenmix.dart';
import 'package:people_app/ui/familyscreen.dart';
import 'package:people_app/ui/educationscreen.dart';
import 'package:people_app/ui/loginscreen.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:people_app/services/api.services.dart';
import 'dart:convert';
import 'package:people_app/models/employee_user_req.dart';
import 'package:people_app/models/emp_family_user_req.dart';
import 'package:people_app/models/emp_education_user_req.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/home/profile';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  double screenHeight = 0;
  double screenWidth = 0;

  //Color primary = const Color(0xffeef444c);
  Color primary = const Color(0xFF0288D1);

  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    _getRecord();
  }

  void _getRecord() async {
    try{
      await APIServices.fetchUserReq(User.employeeId).then((response) async{  });

    }catch(e){
      //print('fetchServiceLogByEmpIDMonthYear Err');
    }
  }

  String vTodayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateTime vToday = DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 32),
              child: Text(
                "Profile",
                style: TextStyle(
                  fontFamily: "NexaBold",
                  fontSize: screenWidth / 18,
                ),
              ),
            ),
            SizedBox(
              height: screenHeight / 1.45,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Card(
                      color: Colors.white,
                      elevation: 2.0,
                      child: ListTile(
                        title: ListTile(
                          leading: Icon(Icons.person,),
                          trailing: Icon(Icons.arrow_forward_ios),
                          title: Text('Personal Profile'),
                          onTap: () {
                            navigateToPersonal();
                          },
                        ),
                      ),
                    );
                  }
                  else if (index == 1) {
                    return Card(
                      color: Colors.white,
                      elevation: 2.0,
                      child: ListTile(
                        title: ListTile(
                          leading: Icon(Icons.people_outline_outlined,),
                          trailing: Icon(Icons.arrow_forward_ios),
                          title: Text('Family Profile'),
                          onTap: () {
                            navigateToFamily();
                          },
                        ),
                      ),
                    );
                  }
                  else if (index == 2) {
                    return Card(
                      color: Colors.white,
                      elevation: 2.0,
                      child: ListTile(
                        title: ListTile(
                          leading: Icon(Icons.school,),
                          trailing: Icon(Icons.arrow_forward_ios),
                          title: Text('Education Profile'),
                          onTap: () {
                            navigateToEducation();
                          },
                        ),
                      ),
                    );
                  }
                  else if (index == 3) {
                    return Card(
                      color: Colors.white,
                      elevation: 2.0,
                      child: ListTile(
                        title: ListTile(
                          leading: Icon(Icons.settings,),
                          trailing: Icon(Icons.arrow_forward_ios),
                          title: Text('User Setting'),
                          onTap: () {
                            navigateToUser();
                          },
                        ),
                      ),
                    );
                  }
                  else if (index == 4) {
                    return Card(
                      color: Colors.white,
                      elevation: 2.0,
                      child: ListTile(
                        title: ListTile(
                          leading: Icon(Icons.logout,),
                          trailing: Icon(Icons.arrow_forward_ios),
                          title: Text('Log Out'),
                          onTap: () {
                            navigateToLogIn();
                          },
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToPersonal() async {
    try {
      Employee_User_Req emp;
      await APIServices.fetchEmployeeUserReq(User.employeeId).then((response) async {

        //ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text('fetchEmployeeUserReq 1')));

        Iterable list = json.decode('[' + response.body + ']');

        //ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text('fetchEmployeeUserReq 2')));

        List<Employee_User_Req>? empList;
        empList = list.map((model) => Employee_User_Req.fromObject(model)).toList();

        //ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text('fetchEmployeeUserReq 3')));

        if (empList.isNotEmpty) {
          empList!.forEach((e) async {
            emp = e;
            await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PersonalScreen(emp)));
          });
        }
      });
    }
    catch(e){
      ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text('Catch Err: ' + e.toString())));
    }
  }

  void navigateToFamily() async {
    try {
      await Navigator.push(context, MaterialPageRoute(builder: (context) => FamilyScreen()));
      /*
      await APIServices.fetchEmpFamily(User.employeeId).then((response) async {
        Iterable list = json.decode(response.body);
        List<Emp_Family_User_Req>? eList;
        eList =
            list.map((model) => Emp_Family_User_Req.fromObject(model)).toList();

        //ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text('fetchEmpFamily Pass!')));

        int tmpId = 0;
        if (eList!.isNotEmpty) {
          if (eList!.length > 0) {
            //ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text('fetchEmpFamily Pass 1!')));
            Emp_Family_User_Req emp_family_user_req = eList.first;

            //ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text('fetchEmpFamily Pass 2!')));
            print('navigateToFamily');
            //print(emp_family_user_req.tran_ID);

            //ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text('emp_family_user_req.tran_ID : ' + emp_family_user_req.tran_ID.toString())));

            tmpId = emp_family_user_req.tran_ID!.toInt();

            //ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text('emp_family_user_req.tran_ID : ' + tmpId.toString())));

            sharedPreferences = await SharedPreferences.getInstance();
            sharedPreferences.setInt('tran_id', tmpId);

            //ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text('fetchEmpFamily Pass 3!')));
            await Navigator.push(context, MaterialPageRoute(
                builder: (context) =>
                    FamilyScreenMix(
                      emp_family_user_req: emp_family_user_req,)));
          }
          else {
            Emp_Family_User_Req emp_family_user_req = new Emp_Family_User_Req(
                m_req_ID: 0,
                m_tran_ID: 0,
                m_emp_ID: double.parse(User.employeeId.toString()),
                m_name: '',
                m_sex: 1,
                m_relationShip_ID: 1,
                m_occupation: '',
                m_address: '',
                m_expire: false,
                m_remark: '',
                m_tax_Allowance: false,
                m_foreign_Stay: 0,
                m_punishment: 0,
                m_age: null,
                m_birth_Date: null,
                m_new_Flag: true,
                m_req_Date: vToday);
            await Navigator.push(context, MaterialPageRoute(
                builder: (context) =>
                    FamilyScreenMix(
                      emp_family_user_req: emp_family_user_req,)));
          }
        }
        else {
          Emp_Family_User_Req emp_family_user_req = new Emp_Family_User_Req(
              m_req_ID: 0,
              m_tran_ID: 0,
              m_emp_ID: double.parse(User.employeeId.toString()),
              m_name: '',
              m_sex: 1,
              m_relationShip_ID: 1,
              m_occupation: '',
              m_address: '',
              m_expire: false,
              m_remark: '',
              m_tax_Allowance: false,
              m_foreign_Stay: 0,
              m_punishment: 0,
              m_age: null,
              m_birth_Date: null,
              m_new_Flag: true,
              m_req_Date: vToday);
          await Navigator.push(context, MaterialPageRoute(
              builder: (context) =>
                  FamilyScreenMix(
                    emp_family_user_req: emp_family_user_req,)));
        }
      });
      */
    }
    catch(e){
      ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text('Catch Err: ' + e.toString())));
    }
  }

  void navigateToEducation() async {
    try {
      await Navigator.push(context, MaterialPageRoute(builder: (context) => EducationScreen()));
      /*
      await APIServices.fetchEmpEducation(User.employeeId).then((
          response) async {
        Iterable list = json.decode(response.body);
        List<Emp_Education_User_Req>? eList;
        eList = list.map((model) => Emp_Education_User_Req.fromObject(model))
            .toList();

        int tmpId = 0;

        if (eList!.isNotEmpty) {
          if (eList!.length > 0) {
            Emp_Education_User_Req emp_education_user_req = eList.first;

            tmpId = emp_education_user_req.tran_ID!.toInt();

            sharedPreferences = await SharedPreferences.getInstance();
            sharedPreferences.setInt('tran_id',tmpId);

            await Navigator.push(context, MaterialPageRoute(
                builder: (context) => EducationScreenMix(
                  emp_education_user_req: emp_education_user_req,)));
          }
          else {
            Emp_Education_User_Req emp_education_user_req = new Emp_Education_User_Req(
                m_req_ID: 0,
                m_tran_ID: 0,
                m_emp_ID: double.parse(User.employeeId.toString()),
                m_fromYear: null,
                m_toYear: null,
                m_edu_Type_ID: null,
                m_edu_Desp: '',
                m_degree_ID: null,
                m_edu_Year: null,
                m_institute_College: '',
                m_remark: '',
                m_year_Achieve: null,
                m_location: '',
                m_new_Flag: true,
                m_req_Date: vToday);
            await Navigator.push(
                context, MaterialPageRoute(builder: (context) =>
                EducationScreenMix(
                    emp_education_user_req: emp_education_user_req)));
          }
        }
        else {
          Emp_Education_User_Req emp_education_user_req = new Emp_Education_User_Req(
              m_req_ID: 0,
              m_tran_ID: 0,
              m_emp_ID: double.parse(User.employeeId.toString()),
              m_fromYear: null,
              m_toYear: null,
              m_edu_Type_ID: null,
              m_edu_Desp: '',
              m_degree_ID: null,
              m_edu_Year: null,
              m_institute_College: '',
              m_remark: '',
              m_year_Achieve: null,
              m_location: '',
              m_new_Flag: true,
              m_req_Date: vToday);
          await Navigator.push(
              context, MaterialPageRoute(builder: (context) =>
              EducationScreenMix(
                  emp_education_user_req: emp_education_user_req)));
        }
      });
       */
    }
    catch(e){
      ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text('Catch Err: ' + e.toString())));
    }
  }

  void navigateToUser() async {
    Emp_Login emp_login = new Emp_Login.WithId(m_emp_ID:User.employeeId,m_emp_Short: User.firstName, m_emp_Name: User.lastName, m_password: User.password, m_level_ID: 0, m_active: 1, m_editUserID: User.employeeId, m_editDateTime: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now())));
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserScreen(emp_login)));
  }

  void navigateToLogIn() async {
    Navigator.of(context).popUntil((route) => route.isFirst);

    String serverIP = '';
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString('serverIP') != null) {
      serverIP = sharedPreferences.getString('serverIP')!;
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();

    //sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('serverIP', serverIP);

    setState(() {

    });

    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));

    Navigator.of(context).pushReplacementNamed('/');

    showSuccess("User was successfully logout!");
  }

  void showSuccess(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success!"),
          content: Text(message),
          actions: <Widget>[
            new TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}