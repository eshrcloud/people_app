
import 'package:flutter/material.dart';
import 'package:people_app/services/api.services.dart';
import 'package:people_app/models/emp_login.dart';

class UserScreen extends StatefulWidget {
  final Emp_Login emp_login;
  UserScreen(this.emp_login);

  @override
  State<StatefulWidget> createState() => _UserScreenState(emp_login);
}

class _UserScreenState extends State<UserScreen> {
  Emp_Login emp_login;
  _UserScreenState(this.emp_login);
  late String curPwd;
  bool chkPass = false;
  var emp_ShortController = TextEditingController();
  var emp_NameController = TextEditingController();
  var currentController = TextEditingController();
  var passwordController = TextEditingController();
  final _levelsDropDownList = ["Normal","Leader","HR","Group HR","Sys Admin","N/A"];
  String? _levelDropDownList = "N/A";
  var textStyle=TextStyle();
  final connectionIssueSnackBar = SnackBar(content: Text("404, Connection Issue !"));

  @override
  void initState() {
    super.initState();
    _getRecord();
  }

  void _getRecord() async {
    try {
      emp_ShortController.text=emp_login.emp_Short;
      emp_NameController.text=emp_login.emp_Name;
      curPwd = emp_login.password;
      //passwordController.text=emp_login.password;
    } catch(e) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {

    textStyle=Theme.of(context).textTheme.caption!;

    return Scaffold(
      appBar: AppBar(
        title:Text('User Setting'),
      ),
      body: _buildForm(),
    );
  }

  Widget _buildForm(){
    return Padding(
      padding: EdgeInsets.only(top: 35.0, left: 10.0, right: 10.0),
      child: ListView( children: <Widget>[
        TextField(
          controller: emp_ShortController,
          style: TextStyle(
            fontFamily: "NexaBold",
            fontSize: 14,
            color: Colors.black,
          ),
          onChanged: (value)=>updateshortName(),
          decoration: InputDecoration(
              labelText: "Short",
              labelStyle: TextStyle(
                fontFamily: "NexaBold",
                fontSize: 14,
                color: Colors.black,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
              )
          ),
        ),
        
        Padding(padding: EdgeInsets.only(top:15.0,bottom: 15.0)),
        
        TextField(
          controller: emp_NameController,
          style: TextStyle(
            fontFamily: "NexaBold",
            fontSize: 14,
            color: Colors.black,
          ),
          onChanged: (value)=>updateName(),
          decoration: InputDecoration(
              labelText: "Name",
              labelStyle: TextStyle(
                fontFamily: "NexaBold",
                fontSize: 14,
                color: Colors.black,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
              )
          ),
        ),

        Padding(padding: EdgeInsets.only(top:15.0,bottom: 15.0)),

        TextField(
          controller: currentController,
          style: TextStyle(
            fontFamily: "NexaBold",
            fontSize: 14,
            color: Colors.black,
          ),
          obscureText: true,
          onSubmitted: (value)=>checkCurrentPassword(),
          /*onSubmitted: (String value) {
            if (curPwd != currentController.text){
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:Text('Password does not match!'),
                    duration: Duration(seconds: 3),
                  )
              );
              setState(() {
                chkPass = false;
              });
              //ScaffoldMessenger.of(context).reload();
            }
            else{
              setState(() {
                chkPass = true;
              });
            }
          },
           */
          decoration: InputDecoration(
              labelText: "Current Password",
              labelStyle: TextStyle(
                fontFamily: "NexaBold",
                fontSize: 14,
                color: Colors.black,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
              )
          ),
        ),

        Padding(padding: EdgeInsets.only(top:15.0,bottom: 15.0)),

        TextField(
          controller: passwordController,
          style: textStyle,
          obscureText: true,
          enabled: chkPass,
          onChanged: (value)=>updatePassword(),
          decoration: InputDecoration(
              labelText: "Password",
              labelStyle: TextStyle(
                fontFamily: "NexaBold",
                fontSize: 14,
                color: Colors.black,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
              )
          ),
        ),

        Padding(padding: EdgeInsets.only(top:15.0,bottom: 15.0)),
/*
        ListTile(
          title: DropdownButton<String>(
            items:_levelsDropDownList.map((String value){
              return DropdownMenuItem<String>(
                value:value,
                child:Text(value),
              );
            }).toList(),
            style: textStyle,
            value: retrieveLevel(emp_login.level_ID),
            onChanged: (value) => updateLevel(value),
          ),
        ),

 */

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ElevatedButton (

               /*
              padding: EdgeInsets.all(8.0),
              textColor: Colors.blueAccent,
               */
              onPressed: (chkPass == false) ? null : (){  saveEmpLogIn();
              },
              child: updateSaveText(),
            ),
/*
            ElevatedButton (
              /*
              padding: EdgeInsets.all(8.0),
              textColor: Colors.blueAccent,
              */
              onPressed: (){
                deleteEmpLogIn(emp_login.emp_ID);
              },
              child: Text("Delete"),
            ),
 */
          ],
        )

      ], ),
    );
  }

  String retrieveLevel(int value){
    return _levelsDropDownList[value - 1];
  }

  void updateLevel(String? value){
    switch (value){
      case "Normal":
        emp_login.level_ID=1;
        break;
      case "Leader":
        emp_login.level_ID=2;
        break;
      case "HR":
        emp_login.level_ID=3;
        break;
      case "Group HR":
        emp_login.level_ID=4;
        break;
      case "Sys Admin":
        emp_login.level_ID=5;
        break;
      case "N/A":
        emp_login.level_ID=1;
        break;
      default:
        emp_login.level_ID=1;
        break;
    }
  }

  void updateshortName(){
    emp_login.emp_Short = emp_ShortController.text;
  }

  void updateName(){
    emp_login.emp_Name = emp_NameController.text;
  }

  void checkCurrentPassword(){
    if (curPwd != currentController.text){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:Text('Password does not match!'),
            duration: Duration(seconds: 3),
          )
      );
      setState(() {
        chkPass = false;
      });
    }
    else{
      setState(() {
        chkPass = true;
      });
    }


  }

  void updatePassword(){
    if (chkPass) {
      emp_login.password = passwordController.text;
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:Text('Password does not match!'),
            duration: Duration(seconds: 3),
          )
      );
    }
  }

  void saveEmpLogIn() async{
    var saveResponse = await APIServices.postEmpLogIn(emp_login);
    print(saveResponse);
    if (saveResponse == true) {
      Navigator.pop(context, true);
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:Text('connection Issue!'),
            duration: Duration(seconds: 3),
          )
      );
    }
  }

  void deleteEmpLogIn(double id) async{
    var deleteResponse = await APIServices.deleteEmpLogIn(id);
    print(deleteResponse);
    Navigator.pop(context,true);
    //deleteResponse == true ? Navigator.pop(context,true):Scaffold.of(context).showSnackBar(connectionIssueSnackBar);
  }

  Widget updateSaveText(){
    return emp_login.emp_ID == null ? Text("Save"):Text("Update");
  }

}
