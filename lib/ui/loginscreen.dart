import 'package:people_app/ui/homescreen.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:people_app/services/api.services.dart';
import 'package:people_app/models/emp_login.dart';
import 'dart:convert';
import 'package:people_app/ui/extensions.dart';
import 'package:people_app/ui/emp_logins.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<Emp_Login>? emp_logins;

  TextEditingController idController = TextEditingController();
  TextEditingController passController = TextEditingController();

  double screenHeight = 0;
  double screenWidth = 0;

  //Color primary = const Color(0xffeef444c);
  //Color primary = const '#3792cb'.toColor();
  Color primary = const Color(0xFF0288D1);

  late SharedPreferences sharedPreferences;

  String scanResult = " ";

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible = KeyboardVisibilityProvider.isKeyboardVisible(context);
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildServerIPFloatingButton(),
          SizedBox(width: 16), // Add some space between the two FABs
          _buildQRScanFloatingButton(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop ,

      body: Column(
        children: [
          isKeyboardVisible ? SizedBox(height: screenHeight / 16,) : Container(
            height: screenHeight / 2.5,
            width: screenWidth,
            decoration: BoxDecoration(
              color: primary,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(70),
              ),
            ),
            child: Center(
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: screenWidth / 5,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: screenHeight / 15,
              bottom: screenHeight / 20,
            ),
            child: Text(
              "Login",
              style: TextStyle(
                fontSize: screenWidth / 18,
                fontFamily: "NexaBold",
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(
              horizontal: screenWidth / 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                fieldTitle("User Name"),
                customField("Enter your user name", idController, false),
                fieldTitle("Password"),
                customField("Enter your password", passController, true),
                GestureDetector(
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    String user = idController.text.trim();
                    String password = passController.text.trim();

                    if(user.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("User name is still empty!"),
                      ));
                    } else if(password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Password is still empty!"),
                      ));
                    } else {
/*
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Emp_Logins())
                      );
 */

                    await APIServices.fetchAuthLogIn(user, password).then((response) async{
                      //scaffoldMessenger.showSnackBar(SnackBar(content:Text(response.toString())));
                      if (response == true) {

                        await APIServices.fetchEmpLogInByCode(user).then((response) async {

                          Iterable list=json.decode("[" + response.body + "]");
                          List<Emp_Login>? empList;
                          empList = list.map((model)=> Emp_Login.fromObject(model)).toList();

                          emp_logins = empList;

                          print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');

                          sharedPreferences = await SharedPreferences.getInstance();
                          double? tmpID = emp_logins?.firstWhere((e) => true).emp_ID;
                          print(tmpID.toString());
                          String? tmpUserShort = emp_logins?.firstWhere((e) => true).emp_Short.toString();
                          print(tmpUserShort.toString());
                          String? tmpUserName = emp_logins?.firstWhere((e) => true).emp_Name.toString();
                          print(tmpUserName.toString());
                          String? tmpPassword = emp_logins?.firstWhere((e) => true).password.toString();
                          print(tmpPassword.toString());
                          sharedPreferences.setString('note', '');
                          sharedPreferences.setString('firstName', tmpUserShort.toString());
                          sharedPreferences.setString('lastName', tmpUserName.toString());
                          sharedPreferences.setString('password', tmpPassword.toString());
                          sharedPreferences.setDouble('employeeId', tmpID!).then((_) {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => HomeScreen())
                            );
                          });
                          print('check');
                        });
                        //Navigator.pushReplacementNamed(context, "/home");

                      }
                      else{
                        ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text("Login failed")));
                      }
                    });

                    /*
                      QuerySnapshot snap = await FirebaseFirestore.instance
                          .collection("Employee").where('id', isEqualTo: id).get();

                      try {
                        if(password == snap.docs[0]['password']) {
                          sharedPreferences = await SharedPreferences.getInstance();

                          sharedPreferences.setString('employeeId', id).then((_) {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => Home())
                            );
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Password is not correct!"),
                          ));
                        }
                      } catch(e) {
                        String error = " ";

                        if(e.toString() == "RangeError (index): Invalid value: Valid value range is empty: 0") {
                          setState(() {
                            error = "Employee id does not exist!";
                          });
                        } else {
                          setState(() {
                            error = "Error occurred!";
                          });
                        }

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(error),
                        ));
                      }
                     */
                    }
                  },
                  child: Container(
                    height: 60,
                    width: screenWidth,
                    margin: EdgeInsets.only(top: screenHeight / 40),
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Center(
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                          fontFamily: "NexaBold",
                          fontSize: screenWidth / 26,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget fieldTitle(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: screenWidth / 26,
          fontFamily: "NexaBold",
        ),
      ),
    );
  }

  Widget customField(String hint, TextEditingController controller, bool obscure) {
    return Container(
      width: screenWidth,
      margin: EdgeInsets.only(bottom: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: screenWidth / 6,
            child: Icon(
              obscure == true ? Icons.key : Icons.person,
              color: primary,
              size: screenWidth / 15,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: screenWidth / 12),
              child: TextFormField(
                controller: controller,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: screenHeight / 35,
                  ),
                  border: InputBorder.none,
                  hintText: hint,
                ),
                maxLines: 1,
                obscureText: obscure,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQRScanFloatingButton(){
    return FloatingActionButton(
        child: Icon(Icons.qr_code_scanner),
        onPressed: () async {
          String result = " ";

          try {
            result = await FlutterBarcodeScanner.scanBarcode(
              "#ffffff",
              "Cancel",
              false,
              ScanMode.QR,
            );
          } catch(e) {
            print("error");
            ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text("Error!!")));
            return;
          }

          if (result.contains('http') == false){
            ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text("Invalid URL - QR Code!!")));
            return;
          }

          setState(() {
            scanResult = result;
          });

          sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString('serverIP', scanResult);

        });
  }

  Widget _buildServerIPFloatingButton(){
    return FloatingActionButton(
        child: Icon(Icons.computer),
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (BuildContext context){
              return API_Server_Select();
            },
          );

        });
  }

}

class API_Server_Select extends StatefulWidget {
  const API_Server_Select({Key? key}) : super(key: key);

  @override
  State<API_Server_Select> createState() => _API_Server_Select();
}

class _API_Server_Select extends State<API_Server_Select> {
  late SharedPreferences sharedPreferences;
  var serverIPController = TextEditingController();

  double screenHeight = 0;
  double screenWidth = 0;

  var textStyle=TextStyle();

  @override
  void initState() {
    super.initState();
    _getCredentials();
  }

  void _getCredentials() async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      if(sharedPreferences.getString('serverIP') != null) {
        setState(() {
          serverIPController.text = sharedPreferences.getString('serverIP')!;
        });
      }
    } catch(e) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    textStyle=TextStyle(
      fontFamily: "NexaBold",
      fontSize: screenWidth / 18,
      color: Colors.black,
    );

    return AlertDialog(
      title: const Text('API Server URL'),
      content: SingleChildScrollView(
        child: TextField(
          controller: serverIPController,
          style: textStyle,
          onChanged: (value)=>updateserverIP(),
          decoration: InputDecoration(
              labelText: "Fill API URL",
              labelStyle: textStyle,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
              )
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _cancel,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Save'),
        ),
      ],
    );
  }

  Future<void> updateserverIP() async {
    /*
    if (serverIPController.text.contains('http') == false){
      ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text("Invalid API Server URL!!")));
      return;
    }
     */
  }

  void _cancel(){
    Navigator.pop(context);
  }

  Future<void> _submit() async {
    if (serverIPController.text.contains('http') == false){
      ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text("Invalid API Server URL!!")));
      return;
    }

    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('serverIP', serverIPController.text);

    setState(() {

    });

    Navigator.pop(context);
  }
}
