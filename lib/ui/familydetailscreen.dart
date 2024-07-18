import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:people_app/services/api.services.dart';
import 'package:people_app/models/emp_family_user_req.dart';
import 'package:people_app/models/relationship.dart';
import 'package:people_app/models/user.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:people_app/datasources/emp_family_data.dart';

enum _genders { Male, Female }

late List<Relationship> _relations = new List<Relationship>.filled(1, Relationship.WithId(m_relationShip_ID: 0, m_relationShip_Name: '', m_relationShip_Group_ID: 0, m_relationShip_Name_Myn: '', m_editUserID: 0, m_editDateTime: null));
late List<String> _realtion_List= [''];

class FamilyDetailScreen extends StatefulWidget{
  final Emp_Family_User_Req emp_family_user_req;
  FamilyDetailScreen(this.emp_family_user_req);

  @override
  State<StatefulWidget> createState() => _FamilyDetailScreenState(emp_family_user_req);
}

class _FamilyDetailScreenState extends State<FamilyDetailScreen>{
  Emp_Family_User_Req emp_family_user_req;
  _FamilyDetailScreenState(this.emp_family_user_req);

  late String relationSelectedValue='';

  final NameController = TextEditingController();
  final NRCNoController = TextEditingController();
  final EmailController = TextEditingController();
  final EducationController = TextEditingController();
  final OccupationController = TextEditingController();
  final AddressController = TextEditingController();
  late bool expireController = false;
  final RemarkController = TextEditingController();
  late bool taxController = false;
  late bool foreignController = false;
  late bool punishmentController = false;
  final AgeController = TextEditingController();
  final BirthDateController = TextEditingController();

  _genders _sex = _genders.Male;

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
    String getName='';
    _relations.forEach((itemR) {
      if (itemR.relationShip_ID == emp_family_user_req.relationShip_ID){
        setState(() {
          getName = itemR.relationShip_Name;
        });
      }
    });

    print('getName:');
    print (getName);

    setState(() {
      relationSelectedValue = getName;
      NameController.text = emp_family_user_req.name != null ? emp_family_user_req.name! : '';
      NRCNoController.text = emp_family_user_req.nRC_NO != null ?emp_family_user_req.nRC_NO! : '';
      EmailController.text = emp_family_user_req.email != null ?emp_family_user_req.email! : '';
      EducationController.text = emp_family_user_req.education != null ?emp_family_user_req.education! : '';
      OccupationController.text = emp_family_user_req.occupation != null ?emp_family_user_req.occupation! : '';
      AddressController.text = emp_family_user_req.address != null ?emp_family_user_req.address! : '';
      expireController = emp_family_user_req.expire != null ?emp_family_user_req.expire! : false;
      RemarkController.text = emp_family_user_req.remark != null ?emp_family_user_req.remark! : '';
      taxController = emp_family_user_req.tax_Allowance != null ?emp_family_user_req.tax_Allowance! : false;
      foreignController = emp_family_user_req.foreign_Stay != null ? (emp_family_user_req.foreign_Stay != 0) ? true:false : false;
      punishmentController = emp_family_user_req.punishment != null ? (emp_family_user_req.punishment != 0) ? true:false : false;
      AgeController.text = emp_family_user_req.birth_Date != null ? emp_family_user_req.age! : '';
      BirthDateController.text = emp_family_user_req.birth_Date != null ? DateFormat('yyyy-MM-dd').format(emp_family_user_req.birth_Date as DateTime) : vTodayStr;

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
        title: Text('Family Profile'),
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
                      controller: NameController,
                      style: textStyle,
                      decoration: InputDecoration(
                          labelText: "Name",
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)
                          )
                      ),
                      onChanged: (String? value) {
                        if (value == null || value.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:Text("Please input name!"),
                                duration: Duration(seconds: 3),
                              )
                          );
                        }
                        else{
                          setState(() {
                            emp_family_user_req.name = value;
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
                              ListTile(
                                title: const Text('Male'),
                                leading: Radio(
                                  value: _genders.Male,
                                  groupValue: _sex,
                                  onChanged: (_genders? value) {
                                    setState(() {
                                      _sex = value!;
                                    });
                                  },
                                ),
                              ),

                              ListTile(
                                title: const Text('Female'),
                                leading: Radio(
                                  value: _genders.Female,
                                  groupValue: _sex,
                                  onChanged: (_genders? value){
                                    setState(() {
                                      _sex = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        Expanded(

                          child: ListTile(
                            title: DropdownButton<String>(
                              isExpanded: true,
                              items:_realtion_List.map((String value){
                                return DropdownMenuItem<String>(
                                  value:value,
                                  child:Text(value),
                                );
                              }).toList(),
                              style: textStyle2,
                              hint: Text("Relationship"),
                              value: relationSelectedValue,
                              //value: (_realtion_List.contains(relationSelectedValue)) ? relationSelectedValue : null,
                              //value: emp_family_user_req != null ? retrieveRelationship(emp_family_user_req.relationShip_ID) : '',
                              onChanged: (String? value) {

                                print('value : ' + value.toString());
                                setState(() {
                                  relationSelectedValue = value!;
                                });

                                if (value == null || value.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:Text("Please input relationship!"),
                                        duration: Duration(seconds: 3),
                                      )
                                  );
                                }
                                else{
                                  updateRelationship(value);
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
                            controller: BirthDateController,
                            style: textStyle,
                            decoration: InputDecoration(
                                icon: Icon(Icons.calendar_today),
                                labelText: "Birth Date",
                                labelStyle: textStyle,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0)
                                )
                            ),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context, initialDate: DateTime.now(),
                                  firstDate: DateTime(1920), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2101)
                              );

                              if(pickedDate != null ){
                                print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                //you can implement different kind of Date Format here according to your requirement

                                setState(() {
                                  BirthDateController.text = formattedDate; //set output date to TextField value.
                                });
                                updateBirthDate();
                              }else{
                                print("Date is not selected");
                              }
                            },
                            onChanged: (String? value) {
                              /*
                              if (value == null || value.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:Text("Please input birth date!"),
                                      duration: Duration(seconds: 3),
                                    )
                                );
                              }
                               */
                              setState(() {
                                emp_family_user_req.birth_Date = DateTime.parse(value!);
                              });
                            },
                          ),
                        ),

                        Expanded(
                          child: TextFormField(
                            controller: AgeController,
                            style: textStyle,
                            decoration: InputDecoration(
                                labelText: "Age",
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
                                      content:Text("Please input age!"),
                                      duration: Duration(seconds: 3),
                                    )
                                );
                              }
                               */
                              setState(() {
                                emp_family_user_req.age = value;
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
                            controller: NRCNoController,
                            style: textStyle,
                            decoration: InputDecoration(
                                labelText: "NRC No.",
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
                                      content:Text("Please input occupation!"),
                                      duration: Duration(seconds: 3),
                                    )
                                );
                              }
                               */
                              emp_family_user_req.nRC_NO = value;
                            },
                          ),
                        ),

                        Expanded(
                          child: TextFormField(
                            controller: EmailController,
                            style: textStyle,
                            decoration: InputDecoration(
                                labelText: "Email",
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
                                      content:Text("Please input remark!"),
                                      duration: Duration(seconds: 3),
                                    )
                                );
                              }
                               */
                              setState(() {
                                emp_family_user_req.email = value;
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
                            controller: EducationController,
                            style: textStyle,
                            decoration: InputDecoration(
                                labelText: "Education",
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
                                      content:Text("Please input occupation!"),
                                      duration: Duration(seconds: 3),
                                    )
                                );
                              }
                               */
                              emp_family_user_req.education = value;
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
                            controller: OccupationController,
                            style: textStyle,
                            decoration: InputDecoration(
                                labelText: "Occupation",
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
                                      content:Text("Please input occupation!"),
                                      duration: Duration(seconds: 3),
                                    )
                                );
                              }
                               */
                              emp_family_user_req.occupation = value;
                            },
                          ),
                        ),

                        Expanded(
                          child: TextFormField(
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
                                      content:Text("Please input remark!"),
                                      duration: Duration(seconds: 3),
                                    )
                                );
                              }
                               */
                              setState(() {
                                emp_family_user_req.remark = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    Padding(padding: EdgeInsets.only(top:2.0,bottom: 2.0)),

                    TextFormField(
                      controller: AddressController,
                      style: textStyle,
                      decoration: InputDecoration(
                          labelText: "Address",
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
                         */
                        setState(() {
                          emp_family_user_req.address = value;
                        });
                      },
                    ),

                    Padding(padding: EdgeInsets.only(top:2.0,bottom: 2.0)),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: CheckboxListTile(
                              title: Text("Expire"),
                              value: expireController,
                              onChanged: (bool? value) {
                                setState(() {
                                  expireController = value!;
                                  emp_family_user_req.expire = value!;
                                });
                              },
                              controlAffinity: ListTileControlAffinity
                                  .leading, //  <-- leading Checkbox
                            )
                        ),
                        Expanded(
                            child: CheckboxListTile(
                              title: Text("Tax"),
                              value: taxController,
                              onChanged: (bool? value) {
                                setState(() {
                                  taxController = value!;
                                  emp_family_user_req.tax_Allowance = value!;
                                });
                              },
                              controlAffinity: ListTileControlAffinity
                                  .leading, //  <-- leading Checkbox
                            )
                        ),
                      ],
                    ),

                    Padding(padding: EdgeInsets.only(top:2.0,bottom: 2.0)),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: CheckboxListTile(
                              title: Text("Foreign Stay"),
                              value: foreignController,
                              onChanged: (bool? value) {
                                setState(() {
                                  foreignController = value!;
                                  emp_family_user_req.foreign_Stay = value! == true ? 1 : 0;
                                });
                              },
                              controlAffinity: ListTileControlAffinity
                                  .leading, //  <-- leading Checkbox
                            )
                        ),
                        Expanded(
                            child: CheckboxListTile(
                              title: Text("Punishment"),
                              value: punishmentController,
                              onChanged: (bool? value) {
                                setState(() {
                                  punishmentController = value!;
                                  emp_family_user_req.punishment = value! == true ? 1 : 0;
                                });
                              },
                              controlAffinity: ListTileControlAffinity
                                  .leading, //  <-- leading Checkbox
                            )
                        ),
                      ],
                    ),

                    Padding(padding: EdgeInsets.only(top: 15.0, bottom: 15.0)),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        /*
                        ElevatedButton(
                          onPressed: () {
                            saveFamily();
                          },
                          child: updateSaveText(),
                        ),
                         */
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                //if (myFamilyPageKey.currentState!.validate()) {
                                  print('validated!');
                                  String response = '';

                                  int res=0;
                                  saveFamily();

                                  setState(() {});
                                  if (res > 0) {
                                    response = "Succesfully Inserted!";

                                    //Clear Text
                                    NameController.text = '';
                                    NRCNoController.text = '';
                                    EmailController.text = '';
                                    EducationController.text = '';
                                    OccupationController.text = '';
                                    AddressController.text = '';
                                    expireController = false;
                                    RemarkController.text = '';
                                    taxController = false;
                                    foreignController = false;
                                    punishmentController = false;
                                    AgeController.text = '';
                                    BirthDateController.text = '';

                                  } else {
                                    response =
                                        "Something went wrong! Response Code:" +
                                            res.toString();
                                  }
                                //}
                              },
                              child:Icon(Icons.save),
                            ),
                          ),
                        ),

                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0.0),
                              child: IconButton(tooltip: 'Delete', icon: Icon(Icons.delete),onPressed: () async{
                                deleteFamily(emp_family_user_req.autoID!);
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

  String retrieveRelationship(int? value){
    String vReturn='';
    _relations.forEach((item) {
      if (item.relationShip_ID == value){
        vReturn = item.relationShip_Name;
      }
    });
    return vReturn;
  }

  void updateRelationship(String? value){
    print('updateRelationship');
    _relations.forEach((item) {
      if (item.relationShip_Name == value){
        print(value);
        print(item.relationShip_ID);
        setState(() {
          emp_family_user_req.relationShip_ID = item.relationShip_ID;
        });
      }
    });
  }

  void updateBirthDate(){
    setState(() {
      emp_family_user_req.birth_Date = DateTime.parse(BirthDateController.text);
    });
  }

  void saveFamily() async{
    print('saveFamily');
    var saveResponse = await APIServices.postEmpFamily(emp_family_user_req);
    print(saveResponse);
    if (saveResponse == true) {
      await APIServices.postEmpFamilyCustom(User.employeeId).then((response) async{  });
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
    return emp_family_user_req.req_ID == 0 ? Text("Save") : Text("Update");
  }

  void deleteFamily(int id) async{
    print('deleteFamily : ' + id.toString());
    var deleteResponse = await APIServices.deleteEmpFamily(id);
    print(deleteResponse);
    Navigator.pop(context,true);
    //deleteResponse == true ? Navigator.pop(context,true):Scaffold.of(context).showSnackBar(connectionIssueSnackBar);
  }

}
