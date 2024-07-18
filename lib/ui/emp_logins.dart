// ignore_for_file: prefer_collection_literals

import 'package:flutter/material.dart';
import 'package:people_app/services/api.services.dart';
import 'package:people_app/models/emp_login.dart';
import 'dart:convert';
import 'package:people_app/ui/AddEmpLogIn.dart';
import 'package:people_app/models/emp_login.dart';
import 'package:intl/intl.dart';

class Emp_Logins extends StatefulWidget {
  Emp_Logins({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Emp_LoginState();
}

class _Emp_LoginState extends State<Emp_Logins> {
  List<Emp_Login>? emp_logins;

  getEmpLogIn(){
    APIServices.fetchEmpLogIn().then((response){
      Iterable list=json.decode(response.body);
      List<Emp_Login>? empList;
      empList = list.map((model)=> Emp_Login.fromObject(model)).toList();
      setState(() {
        emp_logins = empList;
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    getEmpLogIn();
    return Scaffold(
      floatingActionButton: _buildFloatingButton(),
      appBar: AppBar(
        title:Text('EmpLogIn List'),
      ),
      body: (emp_logins == null) ? Center(child: Text('Empty'),) : _buildEmpList(),
    );
  }

  Widget _buildAppBar(){
    return AppBar(
      title:Text('EmpLogIn List'),
    );
  }

  Widget _buildEmpList(){
    return ListView.builder(
      itemCount: emp_logins?.length,
      itemBuilder: (context, index){
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: ListTile(
              leading: displayByLevel(this.emp_logins![index].level_ID),
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text(emp_logins![index].emp_Short + " - " + emp_logins![index].emp_Name),
              onTap: (){
                navigateToEmpLogIn(this.emp_logins![index]);
              },
            ),
          ),
        );
      },
    );
  }

  void navigateToEmpLogIn(Emp_Login emp) async{
    await Navigator.push(context, MaterialPageRoute(builder: (context) => AddEmpLogIn(emp)));
  }

  Widget _buildFloatingButton(){
    return FloatingActionButton(
        child: Icon(Icons.person_add),
        onPressed: (){
        navigateToEmpLogIn(Emp_Login(m_emp_Short: '',m_emp_Name: '',m_password: '',m_level_ID: 1,m_active: 1, m_editUserID: -9, m_editDateTime: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()))));
    });
  }

  Widget displayByLevel(int level){
    var normal = Icon(Icons.person,color: Colors.lightBlue,);
    var leader = Icon(Icons.person,color: Colors.blue,);
    var hr = Icon(Icons.person,color: Colors.lightGreen,);
    var grouphr = Icon(Icons.person,color: Colors.green,);
    var sysadmin = Icon(Icons.person,color: Colors.cyan,);
    var na = Icon(Icons.person,color: Colors.lightBlue,);

    return (level == 1 ? normal : level == 2 ? leader : level == 3 ? hr : level == 4 ? grouphr : level == 5 ? sysadmin : na);
  }

}
