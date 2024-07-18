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
import 'package:people_app/datasources/emp_education_data.dart';

GlobalKey<_EducationScreenMixState> myEducationPageKey = GlobalKey<_EducationScreenMixState>();
//int tran_ID=0;
List<Emp_Education_User_Req> emp_educations = [];
late List<Edu_Type> _edu_Types;
late List<Degree_Diploma> _degrees;

class EducationScreenMix extends StatefulWidget{
  final Emp_Education_User_Req emp_education_user_req;
  const EducationScreenMix({Key? key, required this.emp_education_user_req}) : super(key: key);

  @override
  _EducationScreenMixState createState() => _EducationScreenMixState(emp_education_user_req);
}

class _EducationScreenMixState extends State<EducationScreenMix>{
  Emp_Education_User_Req emp_education_user_req;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  _EducationScreenMixState(this.emp_education_user_req);

  late int tran_ID=0;

  late List<String> _edu_List= [''];
  var educationSelectedValue;

  late List<String> _degree_List= [''];
  var degreeSelectedValue;

  final FromYearController = TextEditingController();
  final ToYearController = TextEditingController();
  final EduDespController = TextEditingController();
  final EduYearController = TextEditingController();
  final InstituteController = TextEditingController();
  final RemarkController = TextEditingController();
  final YearAchieveController = TextEditingController();
  final LocationController = TextEditingController();

  final columns = ['Edu Desp', 'Institute/College', 'From Year', 'To Year', 'Location', 'Edit', 'Delete'];

  DateTime DateCreated = DateTime.now();

  double screenHeight = 0;
  double screenWidth = 0;

  Color primary = const Color(0xFF0288D1);

  var textStyle=TextStyle();
  var textStyle2=TextStyle();

  late SharedPreferences sharedPreferences;

  String vTodayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateTime vToday = DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));
  String _year = DateFormat('yyyy').format(DateTime.now());

  @override
  setState(fn){
    if (mounted) {
      super.setState(fn);
    } else {
      debugPrint('Not mounted');
    }
  }

  update() => setState((){});

  @override
  void initState() {
    super.initState();
    _getRecordList();
    _getRowSource();
    _getCredentials();
    _getRecord();
  }

  void _getRecordList() async {
    try{
      await APIServices.fetchEmpEducation(User.employeeId).then((response)async{
        Iterable list=json.decode(response.body);
        List<Emp_Education_User_Req>? eList;
        eList = list.map((model)=> Emp_Education_User_Req.fromObject(model)).toList();

        setState(() {
          if (eList!.isNotEmpty) {
            if (eList!.length > 0) {
              emp_educations = eList!;
            }
            else {
              //print('fetchEmpFamily isEmpty');
            }
          }
        });

      });

    }catch(e){
      //print('fetchEmpFamily Err');
    }
  }

  void _getRowSource() async {
    await APIServices.fetchEduType().then((response)async{
      Iterable list=json.decode(response.body);
      List<Edu_Type>? etList;
      etList = list.map((model)=> Edu_Type.fromObject(model)).toList();

      _edu_Types = etList;

      if (etList!.isNotEmpty) {
        if (etList!.length > 0) {
          etList.forEach((item) {
            setState(() {
              _edu_List.add(item.edu_Type_Desp);
            });
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

      if (dList!.isNotEmpty) {
        if (dList!.length > 0) {
          dList.forEach((item) {
            setState(() {
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

  void _getCredentials() async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      if(sharedPreferences.getInt('tran_ID_Education') != null) {
        setState(() {
          tran_ID = sharedPreferences.getInt('tran_ID_Education')!;
        });
      }
    } catch(e) {
      return;
    }
  }

  void _getRecord() async {
    try {
      print('tran_ID : ' + tran_ID.toString());
      if (tran_ID != 0) {
        emp_educations.forEach((item) {
          if (item.tran_ID == tran_ID){
            setState(() {
              emp_education_user_req = item;

              FromYearController.text = emp_education_user_req.fromYear != null ? emp_education_user_req.fromYear!.toString() : '';
              ToYearController.text = emp_education_user_req.toYear != null ?emp_education_user_req.toYear!.toString() : '';
              EduDespController.text = emp_education_user_req.edu_Desp != null ?emp_education_user_req.edu_Desp! : '';
              EduYearController.text = emp_education_user_req.edu_Year != null ?emp_education_user_req.edu_Year!.toString() : '';
              InstituteController.text = emp_education_user_req.institute_College != null ?emp_education_user_req.institute_College! : '';
              RemarkController.text = emp_education_user_req.remark != null ?emp_education_user_req.remark! : '';
              YearAchieveController.text = emp_education_user_req.year_Achieve != null ?emp_education_user_req.year_Achieve!.toString() : '';
              LocationController.text = emp_education_user_req.location != null ?emp_education_user_req.location! : '';

              _edu_Types.forEach((itemT) {
                if (itemT.edu_Type_ID == item.edu_Type_ID){
                  educationSelectedValue = itemT.edu_Type_Desp;
                }
              });

              _degrees.forEach((itemD) {
                if (itemD.degree_ID == item.degree_ID){
                  degreeSelectedValue = itemD.degree_Name;
                }
              });
            });
          }
        });
      }
      else{
        emp_education_user_req = Emp_Education_User_Req(m_req_ID: 0, m_tran_ID: 0, m_emp_ID: double.parse(User.employeeId.toString()), m_fromYear: int.parse(_year), m_toYear: int.parse(_year),
            m_edu_Type_ID: null, m_edu_Desp: '', m_degree_ID: null, m_edu_Year: int.parse(_year),
            m_institute_College: '', m_remark: '', m_year_Achieve: int.parse(_year), m_location: '', m_new_Flag: true, m_req_Date: vToday, m_editUserID: User.employeeId, m_editDateTime: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now())));
      }
    } catch(e) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (emp_educations.length == 0) {
      emp_educations.add(emp_education_user_req);
    }
    DataTableSource _data = Emp_Education_Data(emp_educations);

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
                key: _formKey,
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
                              items:_edu_List.map((String value){
                                return DropdownMenuItem<String>(
                                  value:value,
                                  child:Text(value),
                                );
                              }).toList(),
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
                              items:_degree_List.map((String value){
                                return DropdownMenuItem<String>(
                                  value:value,
                                  child:Text(value),
                                );
                              }).toList(),
                              style: textStyle2,
                              hint: Text("Degree / Diploma"),
                              value: degreeSelectedValue,
                              //value: emp_education_user_req != null ? retrieveDegree(emp_education_user_req.degree_ID) : '',
                              onChanged: (String? value) {
                                print('value : ' + value.toString());
                                setState(() {
                                  degreeSelectedValue = value;
                                });
                                if (value == null || value.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:Text("Please input degree/diploma!"),
                                        duration: Duration(seconds: 3),
                                      )
                                  );
                                }
                                else{
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
                                if (_formKey.currentState!.validate()) {
                                  print('validated!');
                                  String response = '';

                                  int res=0;
                                  saveEducation();

                                  setState(() {
                                    tran_ID = 0;
                                  });

                                  _getRecordList();

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
                                }
                              },
                              child:Icon(Icons.save),
                            ),
                          ),
                        ),

                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0.0),
                              child: IconButton(icon: Icon(Icons.school),onPressed: () async{
                                tran_ID = 0;
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

                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0.0),
                              child: IconButton(icon: Icon(Icons.refresh),onPressed: () async{
                                _getCredentials();

                                _getRecordList();

                                if (tran_ID != 0){
                                  _getRecord();
                                }
                                else {
                                  //Clear Text
                                  FromYearController.text = '';
                                  ToYearController.text = '';
                                  EduDespController.text = '';
                                  EduYearController.text = '';
                                  InstituteController.text = '';
                                  RemarkController.text = '';
                                  YearAchieveController.text = '';
                                  LocationController.text = '';
                                }

                                setState(() {});
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

            Column(
              children: [

                SizedBox(
                  height: 5,
                ),

                PaginatedDataTable(
                  columns: getColumns(columns),
                  source: _data,
                  columnSpacing: 60,
                  horizontalMargin: 5,
                  rowsPerPage: 5,
                  showCheckboxColumn: false,
                ),

              ],
            ),

          ],

        ),
      ),
    );
  }

  String retrieveEduType(int? value){
    String vReturn='';
    _edu_Types.forEach((item) {
      if (item.edu_Type_ID == value){
        vReturn = item.edu_Type_Desp;
      }
    });
    return vReturn;
  }

  void updateEduType(String? value){
    _edu_Types.forEach((item) {
      if (item.edu_Type_Desp == value){
        setState(() {
          educationSelectedValue = value;
          emp_education_user_req.edu_Type_ID = item.edu_Type_ID;
        });
      }
    });
  }

  String retrieveDegree(int? value){
    String vReturn='';
    _degrees.forEach((item) {
      if (item.degree_ID == value){
        vReturn = item.degree_Name;
      }
    });
    return vReturn;
  }

  void updateDegree(String? value){
    _degrees.forEach((item) {
      if (item.degree_Name == value){
        setState(() {
          emp_education_user_req.degree_ID = item.degree_ID;
        });
      }
    });
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
    label: Text(column),
  ))
      .toList();

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

}

class Emp_Education_Data extends DataTableSource {
  List<Emp_Education_User_Req> _emp_education_user_req;
  Emp_Education_Data(this._emp_education_user_req);

  bool get isRowCountApproximate => false;
  int get rowCount => _emp_education_user_req.length;
  int get selectedRowCount => 0;
  double total=0;

  late SharedPreferences sharedPreferences;
  //final columns = ['Edu Desp', 'Institute/College', 'From Year', 'To Year', 'Location', 'Edit', 'Delete'];
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_emp_education_user_req[index].edu_Desp.toString())),
      DataCell(Text(_emp_education_user_req[index].institute_College.toString())),
      DataCell(Text(_emp_education_user_req[index].fromYear.toString())),
      DataCell(Text(_emp_education_user_req[index].toYear.toString())),
      DataCell(Text(_emp_education_user_req[index].location.toString())),

      DataCell(IconButton(
        icon: Icon(Icons.edit),
        onPressed: () async {
          int vId = int.parse(_emp_education_user_req[index].tran_ID.toString());
          print('vId : ' + vId.toString());
          //tran_ID = vId;

          sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setInt('tran_ID_Education', vId);

          Emp_Education_User_Req emp_education_user_req = _emp_education_user_req[index];
          _EducationScreenMixState(emp_education_user_req).update();
          _EducationScreenMixState(emp_education_user_req)._getRecord();

        },)),
      DataCell(IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {

          int vId = int.parse(_emp_education_user_req[index].tran_ID.toString());
          var deleteResponse = await APIServices.deleteEmpEducation(vId);

          //tran_ID = vId;

          sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setInt('tran_ID_Education', vId);

          myEducationPageKey.currentState!._getRecord();
        },)),
    ]);
  }

  List<DataRow> getRows(List<Emp_Education_User_Req> users) => users.map((Emp_Education_User_Req _emp_educations) {
    final cells = [
      _emp_educations.edu_Desp,
      _emp_educations.institute_College,
      _emp_educations.fromYear,
      _emp_educations.toYear,
      _emp_educations.location,
    ];

    return DataRow(cells: getCells(cells));
  }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();

}
