import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:people_app/services/api.services.dart';
import 'package:people_app/models/emp_education_user_req.dart';
import 'package:people_app/models/edu_type.dart';
import 'package:people_app/models/degree_diploma.dart';
import 'package:people_app/models/user.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:people_app/datasources/emp_family_data.dart';
//import 'package:people_app/ui/educationscreen.dart';

List<Edu_Type>? _edu_Types;
List<Degree_Diploma>? _degrees;

class EducationDetailScreen extends StatefulWidget{
  final Emp_Education_User_Req emp_education_user_req;
  EducationDetailScreen(this.emp_education_user_req);

  @override
  State<StatefulWidget> createState() => _EducationDetailScreenState(emp_education_user_req);
}

class _EducationDetailScreenState extends State<EducationDetailScreen>{
  Emp_Education_User_Req emp_education_user_req;
  _EducationDetailScreenState(this.emp_education_user_req);

  List<String> _edu_List= [''];
  String educationSelectedValue='';

  List<String> _degree_List= [''];
  String degreeSelectedValue='';

  final FromYearController = TextEditingController();
  final ToYearController = TextEditingController();
  final EduDespController = TextEditingController();
  final EduYearController = TextEditingController();
  final InstituteController = TextEditingController();
  final RemarkController = TextEditingController();
  final YearAchieveController = TextEditingController();
  final LocationController = TextEditingController();

  DateTime DateCreated = DateTime.now();

  double screenHeight = 0;
  double screenWidth = 0;

  Color primary = const Color(0xFF0288D1);

  var textStyle=TextStyle(
    fontFamily: "NexaBold",
    fontSize: 12,
    color: Colors.black,);
  var textStyle2=TextStyle(
    fontFamily: "NexaBold",
    fontSize: 12,
    color: Colors.black,);

  late SharedPreferences sharedPreferences;

  String vTodayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateTime vToday = DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));

  @override
  void initState() {
    super.initState();
    _getRowSource();
    _getRecord();
  }

  void _getRowSource() async {
    await APIServices.fetchEduType().then((response)async{
      Iterable list=json.decode(response.body);
      List<Edu_Type>? etList;
      etList = list.map((model)=> Edu_Type.fromObject(model)).toList();

      _edu_Types = etList;

      if (_edu_List.length > 0) {
        _edu_List.removeRange(0, _edu_List.length - 1);
      }

      if (etList!.isNotEmpty) {
        if (etList!.length > 0) {
          etList.forEach((item) {
            if (_edu_List.contains(item.edu_Type_Desp) == false) {
              setState(() {
                _edu_List.add(item.edu_Type_Desp);
              });
            }
          });
        }
        else {
          //print('fetchRelation isEmpty');
        }
      }
    });

    await APIServices.fetchDegree().then((response)async{
      Iterable list=json.decode(response.body);
      List<Degree_Diploma>? dList;
      dList = list.map((model)=> Degree_Diploma.fromObject(model)).toList();

      //dList.sortBy((dList) => dList.degree_Name);
      dList.sort((a, b) => a.degree_Name.compareTo(b.degree_Name));

      _degrees = dList;

      if (_degree_List.length > 0) {
        _degree_List.removeRange(0, _degree_List.length - 1);
      }
      if (dList!.isNotEmpty) {
        if (dList!.length > 0) {
          dList.forEach((item) {
            if (_degree_List.contains(item.degree_Name) == false) {
              setState(() {
                _degree_List.add(item.degree_Name);
              });
            }
          });
        }
        else {
          //print('fetchRelation isEmpty');
        }
      }
    });
  }

  void _getRecord() async {
    setState(() {
      FromYearController.text = emp_education_user_req.fromYear != null ? emp_education_user_req.fromYear!.toString() : '';
      ToYearController.text = emp_education_user_req.toYear != null ?emp_education_user_req.toYear!.toString() : '';
      EduDespController.text = emp_education_user_req.edu_Desp != null ?emp_education_user_req.edu_Desp! : '';
      EduYearController.text = emp_education_user_req.edu_Year != null ?emp_education_user_req.edu_Year!.toString() : '';
      InstituteController.text = emp_education_user_req.institute_College != null ?emp_education_user_req.institute_College! : '';
      RemarkController.text = emp_education_user_req.remark != null ?emp_education_user_req.remark! : '';
      YearAchieveController.text = emp_education_user_req.year_Achieve != null ?emp_education_user_req.year_Achieve!.toString() : '';
      LocationController.text = emp_education_user_req.location != null ?emp_education_user_req.location! : '';

      if (_edu_Types != null) {
        _edu_Types!.forEach((itemT) {
          if (itemT.edu_Type_ID == emp_education_user_req.edu_Type_ID) {
            educationSelectedValue = itemT.edu_Type_Desp;
          }
        });
      }

      if (_degrees != null) {
        _degrees!.forEach((itemD) {
          if (itemD.degree_ID == emp_education_user_req.degree_ID) {
            degreeSelectedValue = itemD.degree_Name;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    textStyle=TextStyle(
      fontFamily: "NexaBold",
      //fontFamily: "Georgia",
      fontSize: screenWidth / 28,
    );
    textStyle2=TextStyle(
      fontFamily: "NexaBold",
      //fontFamily: "Georgia",
      fontSize: screenWidth / 28,
      color: Colors.black,
    );

    print('Scaffold!');

    return Scaffold(
      appBar: AppBar(
        title: Text('Education Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: EduDespController,
                      style: textStyle,
                      decoration: InputDecoration(
                          labelText: "Education Description",
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)
                          )
                      ),
                      onChanged: (String? value) {
                        if (value == null || value.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:Text("Please input education description!"),
                                duration: Duration(seconds: 3),
                              )
                          );
                        }
                        else{
                          setState(() {
                            emp_education_user_req.edu_Desp = value;
                          });
                        }
                      },
                    ),

                    Padding(padding: EdgeInsets.only(top:2.0,bottom: 2.0)),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(

                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: FromYearController,
                                style: textStyle,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                                  TextInputFormatter.withFunction((oldValue, newValue) {
                                    try {
                                      final text = newValue.text;
                                      if (text.isNotEmpty) double.parse(text);
                                      return newValue;
                                    } catch (e) {}
                                    return oldValue;
                                  })
                                ],
                                decoration: InputDecoration(
                                    labelText: "From Year",
                                    labelStyle: textStyle,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0)
                                    )
                                ),
                                onChanged: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content:Text("Please input 'From Year'!"),
                                          duration: Duration(seconds: 3),
                                        )
                                    );
                                  }
                                  else{
                                    setState(() {
                                      emp_education_user_req.fromYear = int.parse(value);
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ),

                        Expanded(

                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: ToYearController,
                                style: textStyle,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                                  TextInputFormatter.withFunction((oldValue, newValue) {
                                    try {
                                      final text = newValue.text;
                                      if (text.isNotEmpty) double.parse(text);
                                      return newValue;
                                    } catch (e) {}
                                    return oldValue;
                                  })
                                ],
                                decoration: InputDecoration(
                                    labelText: "To Year",
                                    labelStyle: textStyle,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0)
                                    )
                                ),
                                onChanged: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content:Text("Please input 'To Year'!"),
                                          duration: Duration(seconds: 3),
                                        )
                                    );
                                  }
                                  else{
                                    setState(() {
                                      emp_education_user_req.toYear = int.parse(value);
                                    });
                                  }
                                },
                              ),
                            ],
                          ),

                        ),
                      ],
                    ),

                    Padding(padding: EdgeInsets.only(top:2.0,bottom: 2.0)),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ListTile(
                            title: DropdownButton<String>(
                              isExpanded: true,
                              items:_edu_List != null ? _edu_List.map((String value){
                                return DropdownMenuItem<String>(
                                  value:value,
                                  child:Text(value),
                                );
                              }).toList() : null,
                              style: textStyle2,
                              //value: emp_education_user_req != null ? retrieveEduType(emp_education_user_req.edu_Type_ID) : '',
                              hint: Text("Education Type"),
                              value: educationSelectedValue,
                              onChanged: (String? value) {

                                    if (value == null || value.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:Text("Please input education type!"),
                                        duration: Duration(seconds: 3),
                                      )
                                  );
                                }
                                else{
                                  updateEduType(value);
                                }

                              },
                            ),
                          ),

                        ),
                        Expanded(
                          child: ListTile(
                            title: DropdownButton<String>(
                              isExpanded: true,
                              items: _degree_List != null ? _degree_List.map((String value){
                                return DropdownMenuItem<String>(
                                  value:value,
                                  child:Text(value),
                                );
                              }).toList() : null,
                              style: textStyle2,
                              hint: Text("Degree / Diploma"),
                              value: degreeSelectedValue,
                              //value: emp_education_user_req != null ? retrieveDegree(emp_education_user_req.degree_ID) : '',
                              onChanged: (String? value) {

                                if (value == null || value.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            "Please input degree/diploma!"),
                                        duration: Duration(seconds: 3),
                                      )
                                  );
                                }
                                else {
                                  updateDegree(value);
                                }

                              },
                            ),
                          ),

                        ),
                      ],
                    ),

                    Padding(padding: EdgeInsets.only(top:2.0,bottom: 2.0)),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: EduYearController,
                            style: textStyle,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                              TextInputFormatter.withFunction((oldValue, newValue) {
                                try {
                                  final text = newValue.text;
                                  if (text.isNotEmpty) double.parse(text);
                                  return newValue;
                                } catch (e) {}
                                return oldValue;
                              })
                            ],
                            decoration: InputDecoration(
                                labelText: "Education Year",
                                labelStyle: textStyle,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0)
                                )
                            ),
                            onChanged: (String? value) {
                              /*
                              if (value == null || value.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:Text("Please input education year!"),
                                      duration: Duration(seconds: 3),
                                    )
                                );
                              }
                               */
                              setState(() {
                                emp_education_user_req.edu_Year = int.parse(value!);
                              });
                            },
                          ),
                        ),

                        Expanded(
                          child: TextFormField(
                            controller: YearAchieveController,
                            style: textStyle,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                              TextInputFormatter.withFunction((oldValue, newValue) {
                                try {
                                  final text = newValue.text;
                                  if (text.isNotEmpty) double.parse(text);
                                  return newValue;
                                } catch (e) {}
                                return oldValue;
                              })
                            ],
                            decoration: InputDecoration(
                                labelText: "Year Achieved",
                                labelStyle: textStyle,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0)
                                )
                            ),
                            onChanged: (String? value) {
                              /*
                              if (value == null || value.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:Text("Please input year achieved!"),
                                      duration: Duration(seconds: 3),
                                    )
                                );
                              }
                               */
                              setState(() {
                                emp_education_user_req.year_Achieve = int.parse(value!);
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    Padding(padding: EdgeInsets.only(top:2.0,bottom: 2.0)),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: InstituteController,
                            style: textStyle,
                            decoration: InputDecoration(
                                labelText: "Institute / College",
                                labelStyle: textStyle,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0)
                                )
                            ),
                            onChanged: (String? value) {
                              if (value == null || value.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:Text("Please input Institute / College!"),
                                      duration: Duration(seconds: 3),
                                    )
                                );
                              }
                              else{
                                setState(() {
                                  emp_education_user_req.institute_College = value;
                                });
                              }
                            },
                          ),
                        ),

                        Expanded(
                          child: TextFormField(
                            controller: LocationController,
                            style: textStyle,
                            decoration: InputDecoration(
                                labelText: "Location",
                                labelStyle: textStyle,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0)
                                )
                            ),
                            onChanged: (String? value) {
                              if (value == null || value.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:Text("Please input year achieved!"),
                                      duration: Duration(seconds: 3),
                                    )
                                );
                              }
                              else{
                                setState(() {
                                  emp_education_user_req.location = value;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),

                    Padding(padding: EdgeInsets.only(top:2.0,bottom: 2.0)),

                    TextFormField(
                      controller: RemarkController,
                      style: textStyle,
                      decoration: InputDecoration(
                          labelText: "Remark",
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)
                          )
                      ),
                      onChanged: (String? value) {
                        /*
                        if (value == null || value.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:Text("Please input address!"),
                                duration: Duration(seconds: 3),
                              )
                          );
                        }
                        return null;
                         */
                        setState(() {
                          emp_education_user_req.remark = value;
                        });
                      },
                    ),

                    Padding(padding: EdgeInsets.only(top:2.0,bottom: 2.0)),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        /*
                        ElevatedButton(
                          onPressed: () {
                            saveEducation();
                          },
                          child: updateSaveText(),
                        ),
                         */
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                print('validated!');
                                String response = '';

                                int res=0;
                                saveEducation();

                                setState(() {});
                                if (res > 0) {
                                  response = "Succesfully Inserted!";

                                  //Clear Text
                                  FromYearController.text = '';
                                  ToYearController.text = '';
                                  EduDespController.text = '';
                                  EduYearController.text = '';
                                  InstituteController.text = '';
                                  RemarkController.text = '';
                                  YearAchieveController.text = '';
                                  LocationController.text = '';

                                } else {
                                  response =
                                      "Something went wrong! Response Code:" +
                                          res.toString();
                                }
                              },
                              child:Icon(Icons.save),
                            ),
                          ),
                        ),
/*
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0.0),
                              child: IconButton(icon: Icon(Icons.school),onPressed: () async{

                                //Clear Text
                                FromYearController.text = '';
                                ToYearController.text = '';
                                EduDespController.text = '';
                                EduYearController.text = '';
                                InstituteController.text = '';
                                RemarkController.text = '';
                                YearAchieveController.text = '';
                                LocationController.text = '';

                                setState(() {});
                              },)
                          ),
                        ),
 */

                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0.0),
                              child: IconButton(tooltip: 'Delete', icon: Icon(Icons.delete),onPressed: () async{
                                deleteEducation(emp_education_user_req.autoID!);
                              },)
                          ),
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

                  ],
                )),

          ],

        ),
      ),
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

  void updateEduType(String? value){
    _edu_Types!.forEach((item) {
      if (item.edu_Type_Desp == value){
        setState(() {
          educationSelectedValue = value!;
          emp_education_user_req.edu_Type_ID = item.edu_Type_ID;
        });
      }
    });
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

  void updateDegree(String? value){
    _degrees!.forEach((item) {
      if (item.degree_Name == value){
        setState(() {
          degreeSelectedValue = value!;
          emp_education_user_req.degree_ID = item.degree_ID;
        });
      }
    });
  }

  void saveEducation() async{
    var saveResponse = await APIServices.postEmpEducation(emp_education_user_req);
    print(saveResponse);
    if (saveResponse == true) {
      await APIServices.postEmpEducationCustom(User.employeeId).then((response) async{  });
      await APIServices.fetchUserReq(User.employeeId).then((response) async{  });

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

  Widget updateSaveText() {
    return emp_education_user_req.req_ID == 0 ? Text("Save") : Text("Update");
  }

  void deleteEducation(int id) async{
    var deleteResponse = await APIServices.deleteEmpEducation(id);
    print(deleteResponse);
    Navigator.pop(context,true);
    //await Navigator.push(context, MaterialPageRoute(builder: (context) => EducationScreen()));
    //deleteResponse == true ? Navigator.pop(context,true):Scaffold.of(context).showSnackBar(connectionIssueSnackBar);
  }

}
