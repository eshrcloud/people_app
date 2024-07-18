import 'package:flutter/services.dart';
//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:people_app/services/api.services.dart';
import 'package:people_app/models/employee_user_req.dart';
import 'package:people_app/models/user.dart';

class PersonalScreen extends StatefulWidget {
  final Employee_User_Req employee_user_req;
  PersonalScreen(this.employee_user_req);

  @override
  State<StatefulWidget> createState() => _PersonalScreenState(employee_user_req);
}

class _PersonalScreenState extends State<PersonalScreen> {
  Employee_User_Req employee_user_req;

  _PersonalScreenState(this.employee_user_req);

  //bool lifeChecked = false;
  bool DriveChecked = false;
  var NameController = TextEditingController();
  var ShortController = TextEditingController();
  var BirthDateController = TextEditingController();
  var AgeController = TextEditingController();
  var NRCController = TextEditingController();
  var AddressController = TextEditingController();
  var PerAddressController = TextEditingController();
  var PhoneController = TextEditingController();
  var EmailController = TextEditingController();
  var NoOfChildController = TextEditingController();
  var NoOfParentsController = TextEditingController();

  var DriveLicenseController = TextEditingController();
  var LifeInsuranceController = TextEditingController();
  late bool DriveExperienceController = false;
  //late bool LifeInsuranceController = false;
  var PassportNoController = TextEditingController();
  var PPExpireDateController = TextEditingController();
  var LabourNoController = TextEditingController();
  var SSBNoController = TextEditingController();
  late bool RelocationController = false;
  var PreferenceController = TextEditingController();
  var BankAccController = TextEditingController();
  var SavingAccController = TextEditingController();

  String vTodayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateTime vToday = DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));

  var textStyle = TextStyle();
  final connectionIssueSnackBar = SnackBar(
      content: Text("404, Connection Issue !"));

  @override
  void initState() {
    super.initState();
    _getRecord();
  }

  void _getRecord() {
    try {
      NameController.text = employee_user_req.emp_Name != null ? employee_user_req.emp_Name! : '';
      ShortController.text = employee_user_req.short_Name != null ? employee_user_req.short_Name! : '';
      BirthDateController.text = employee_user_req.birth_Date != null ? DateFormat('yyyy-MM-dd').format(employee_user_req.birth_Date as DateTime) : vTodayStr;
      AgeController.text = employee_user_req.age != null ? employee_user_req.age! : '';
      NRCController.text = employee_user_req.nrC_NO != null ? employee_user_req.nrC_NO! : '';
      AddressController.text = employee_user_req.address != null ? employee_user_req.address! : '';
      PerAddressController.text = employee_user_req.permanent_Address != null ? employee_user_req.permanent_Address! : '';
      PhoneController.text = employee_user_req.phone != null ? employee_user_req.phone! : '';
      EmailController.text = employee_user_req.email != null ? employee_user_req.email! : '';
      NoOfChildController.text = employee_user_req.noOfChildren != null ? employee_user_req.noOfChildren.toString() : '';
      NoOfParentsController.text = employee_user_req.noOfParents != null ? employee_user_req.noOfParents.toString() : '';
      //LifeInsuranceController = employee_user_req.life_Insurance != null ? (employee_user_req.life_Insurance != 0) ? true:false : false;
      LifeInsuranceController.text = employee_user_req.life_Insurance != null ? employee_user_req.life_Insurance.toString() : '';
      DriveExperienceController = employee_user_req.driving_Experience != null ? (employee_user_req.driving_Experience != 0) ? true:false : false;
      DriveLicenseController.text = employee_user_req.driving_License != null ? employee_user_req.driving_License.toString() : '';
      //bool DriveExperienceController = employee_user_req.driving_Experience != null ? employee_user_req.driving_Experience as bool : false;
      //bool LifeInsuranceController = employee_user_req.life_Insurance != null ? employee_user_req.life_Insurance as bool : false;
      PassportNoController.text = employee_user_req.pP_No != null ? employee_user_req.pP_No! : '';
      PPExpireDateController.text = employee_user_req.pP_Expiry_Date != null ? DateFormat('yyyy-MM-dd').format(employee_user_req.pP_Expiry_Date as DateTime) : vTodayStr;
      LabourNoController.text = employee_user_req.labourNo != null ? employee_user_req.labourNo! : '';
      SSBNoController.text = employee_user_req.sSB_No != null ? employee_user_req.sSB_No! : '';
      RelocationController = employee_user_req.relocation != null ? (employee_user_req.relocation != 0) ? true:false : false;
      PreferenceController.text = employee_user_req.preference != null ? employee_user_req.preference! : '';
      BankAccController.text = employee_user_req.bank_Acct_No != null ? employee_user_req.bank_Acct_No! : '';
      SavingAccController.text = employee_user_req.saving_Acct_No != null ? employee_user_req.saving_Acct_No! : '';
    } catch(e) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {

    textStyle = Theme
        .of(context)
        .textTheme
        .caption!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Profile'),
      ),
      body: _buildForm(),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: EdgeInsets.only(top: 35.0, left: 10.0, right: 10.0),


      child: ListView(children: <Widget>[

        Padding(padding: EdgeInsets.only(top: 15.0, bottom: 15.0)),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: TextField(
                  controller: NameController,
                  //style: textStyle,
                  onChanged: (value) => updateName(),

                  decoration: InputDecoration(
                      labelText: "Name",
                      labelStyle: TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: 12,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                )
            ),

            Expanded(
              child: TextField(
                controller: ShortController,
                //style: textStyle,
                onChanged: (value) => updateShortName(),

                decoration: InputDecoration(
                    labelText: "Short Name",
                    labelStyle: TextStyle(
                      fontFamily: "NexaBold",
                      fontSize: 12,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
              ),
            ),
          ],
        ),

        Padding(padding: EdgeInsets.only(top: 15.0, bottom: 15.0)),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: TextField(
                  controller: BirthDateController,
                  //style: textStyle,
                  onChanged: (value) => updateBirth_Date(),

                  decoration: InputDecoration(
                      icon: Icon(Icons.calendar_today),
                      labelText: "Birth Date",
                      labelStyle: TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: 12,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      ),
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
                    }else{
                      print("Date is not selected");
                    }
                  },
                )
            ),

            Expanded(
              child: TextField(
                controller: AgeController,
                //style: textStyle,
                onChanged: (value) => updateAge(),
                /*
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
                 */
                decoration: InputDecoration(
                    labelText: "Age",
                    labelStyle: TextStyle(
                      fontFamily: "NexaBold",
                      fontSize: 12,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
              ),
            ),
          ],
        ),

        Padding(padding: EdgeInsets.only(top: 15.0, bottom: 15.0)),

        // NRC, Life Insurance
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: TextField(
                  controller: NRCController,
                  //style: textStyle,
                  onChanged: (value) => updateNRC_NO(),

                  decoration: InputDecoration(
                      labelText: "NRC",
                      labelStyle: TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: 12,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                )
            ),

            Expanded(
                child: TextField(
                  controller: LifeInsuranceController,
                  //style: textStyle,
                  onChanged: (value) => updateLife_Insurance(),

                  decoration: InputDecoration(
                      labelText: "Life Insurance",
                      labelStyle: TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: 12,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                )
            ),
          ],
        ),

        Padding(padding: EdgeInsets.only(top: 15.0, bottom: 15.0)),

        // Phone, Email
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: TextField(
                  controller: PhoneController,
                  //style: textStyle,
                  onChanged: (value) => updatePhone(),

                  decoration: InputDecoration(
                      labelText: "Phone",
                      labelStyle: TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: 12,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                )
            ),

            Expanded(
              child: TextField(
                controller: EmailController,
                //style: textStyle,
                onChanged: (value) => updateemail(),

                decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(
                      fontFamily: "NexaBold",
                      fontSize: 12,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
              ),
            ),
          ],
        ),

        Padding(padding: EdgeInsets.only(top: 15.0, bottom: 15.0)),

        // Address
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: TextField(
                  controller: AddressController,
                  //style: textStyle,
                  onChanged: (value) => updateAddress(),

                  decoration: InputDecoration(
                      labelText: "Address",
                      labelStyle: TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: 12,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                )
            ),
          ],
        ),

        Padding(padding: EdgeInsets.only(top: 15.0, bottom: 15.0)),

        // Permanent Address
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                controller: PerAddressController,
                //style: textStyle,
                onChanged: (value) => updatePermanent_Address(),

                decoration: InputDecoration(
                    labelText: "Permanent Address",
                    labelStyle: TextStyle(
                      fontFamily: "NexaBold",
                      fontSize: 12,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
              ),
            ),
          ],
        ),

        Padding(padding: EdgeInsets.only(top: 15.0, bottom: 15.0)),

        // No. Of Parents, No. Of Children
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                controller: NoOfChildController,
                //style: textStyle,
                onChanged: (value) => updateNoOfChildren(),

                decoration: InputDecoration(
                    labelText: "Number of Children",
                    labelStyle: TextStyle(
                      fontFamily: "NexaBold",
                      fontSize: 12,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
              ),
            ),

            Expanded(
              child: TextField(
                controller: NoOfParentsController,
                //style: textStyle,
                onChanged: (value) => updateNoOfParents(),

                decoration: InputDecoration(
                    labelText: "Number of Parents",
                    labelStyle: TextStyle(
                      fontFamily: "NexaBold",
                      fontSize: 12,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
              ),
            ),
          ],
        ),

        Padding(padding: EdgeInsets.only(top: 15.0, bottom: 15.0)),

        // Driving Exp, License
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(

                child: CheckboxListTile(
                  title: Text("Driving Experience"),
                  value: DriveExperienceController,
                  onChanged: (bool? value) {
                    DriveExperienceController = value!;
                    updateDriving_Experience();
                  },
                  controlAffinity: ListTileControlAffinity
                      .leading, //  <-- leading Checkbox
                )
            ),
            Expanded(
                child: TextField(
                  controller: DriveLicenseController,
                  //style: textStyle,
                  onChanged: (value) => updateDriving_License(),

                  decoration: InputDecoration(
                      labelText: "Driving License",
                      labelStyle: TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: 12,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                )
            ),
          ],
        ),

        Padding(padding: EdgeInsets.only(top: 15.0, bottom: 15.0)),

        // Passport No., Expire Date
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: TextField(
                  controller: PassportNoController,
                  //style: textStyle,
                  onChanged: (value) => updatePP_No(),

                  decoration: InputDecoration(
                      labelText: "Passport Number",
                      labelStyle: TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: 12,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                )
            ),

            Expanded(
              child: TextField(
                controller: PPExpireDateController,
                //style: textStyle,
                onChanged: (value) => updatePP_Expiry_Date(),

                decoration: InputDecoration(
                    labelText: "Passport Expired Date",
                    labelStyle: TextStyle(
                      fontFamily: "NexaBold",
                      fontSize: 12,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
              ),
            ),
          ],
        ),

        Padding(padding: EdgeInsets.only(top: 15.0, bottom: 15.0)),

        // Bank Acc, Saving Acc
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: TextField(
                  controller: BankAccController,
                  //style: textStyle,
                  onChanged: (value) => updateBank_Acct_No(),

                  decoration: InputDecoration(
                      labelText: "Bank Account",
                      labelStyle: TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: 12,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                )
            ),

            Expanded(
              child: TextField(
                controller: SavingAccController,
                //style: textStyle,
                onChanged: (value) => updateSaving_Acct_No(),

                decoration: InputDecoration(
                    labelText: "Saving Account",
                    labelStyle: TextStyle(
                      fontFamily: "NexaBold",
                      fontSize: 12,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
              ),
            ),
          ],
        ),

        Padding(padding: EdgeInsets.only(top: 15.0, bottom: 15.0)),

        // Labour No., SSB No.
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: TextField(
                  controller: LabourNoController,
                  //style: textStyle,
                  onChanged: (value) => updateLabourNo(),

                  decoration: InputDecoration(
                      labelText: "Labour Number",
                      labelStyle: TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: 12,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                )
            ),

            Expanded(
                child: TextField(
                  controller: SSBNoController,
                  //style: textStyle,
                  onChanged: (value) => updateSSBNo(),

                  decoration: InputDecoration(
                      labelText: "SSB Number",
                      labelStyle: TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: 12,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                )
            ),
/*
            Expanded(
                child: CheckboxListTile(
                  title: Text("Life Insurance"),
                  value: LifeInsuranceController,
                  onChanged: (bool? value) {
                    setState(() {
                      LifeInsuranceController = value!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity
                      .leading, //  <-- leading Checkbox
                )
            ),
 */
          ],
        ),

        Padding(padding: EdgeInsets.only(top: 15.0, bottom: 15.0)),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(

                child: CheckboxListTile(
                  title: Text("Relocation"),
                  value: RelocationController,
                  onChanged: (bool? value) {
                    RelocationController = value!;
                    updateRelocation();
                  },
                  controlAffinity: ListTileControlAffinity
                      .leading, //  <-- leading Checkbox
                )
            ),
            Expanded(
                child: TextField(
                  controller: PreferenceController,
                  //style: textStyle,
                  onChanged: (value) => updatePreference(),

                  decoration: InputDecoration(
                      labelText: "Preference",
                      labelStyle: TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: 12,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                )
            ),
          ],
        ),


        Padding(padding: EdgeInsets.only(top: 15.0, bottom: 15.0)),


        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            ElevatedButton(

              onPressed: () {
                savePersonal();
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

      ],),
    );
  }


  void updateName() {
    setState(() {
      employee_user_req.emp_Name = NameController.text;
    });
  }

  void updateShortName() {
    setState(() {
      employee_user_req.short_Name = ShortController.text;
    });
  }

  void updateBirth_Date() {
    setState(() {
      employee_user_req.birth_Date = BirthDateController.text as DateTime?;
    });
  }

  void updateAge() {
    setState(() {
      employee_user_req.age = AgeController.text;
    });
  }

  void updateAddress() {
    setState(() {
      employee_user_req.address = AddressController.text;
    });
  }

  void updatePermanent_Address() {
    setState(() {
      employee_user_req.permanent_Address = PerAddressController.text;
    });
  }

  void updatePhone() {
    setState(() {
      employee_user_req.phone = PhoneController.text;
    });
  }

  void updateemail() {
    setState(() {
      employee_user_req.email = EmailController.text;
    });
  }

  void updateNRC_NO() {
    setState(() {
      employee_user_req.nrC_NO = NRCController.text;
    });
  }

  void updateNoOfChildren() {
    setState(() {
      employee_user_req.noOfChildren = int.parse(NoOfChildController.text);
    });
  }

  void updateNoOfParents() {
    setState(() {
      employee_user_req.noOfParents = int.parse(NoOfParentsController.text);
    });
  }

  void updateDriving_Experience() {
    setState(() {
      if (DriveExperienceController == true) {
        employee_user_req.driving_Experience = 1;
      }
      else {
        employee_user_req.driving_Experience = 0;
      }
    });
  }

  void updateDriving_License() {
    setState(() {
      employee_user_req.driving_License = int.parse(DriveLicenseController.text);
    });
  }

  void updatePP_No() {
    setState(() {
      employee_user_req.pP_No = PassportNoController.text;
    });
  }

  void updatePP_Expiry_Date() {
    setState(() {
      employee_user_req.pP_Expiry_Date = DateTime.parse(PPExpireDateController.text);
    });
  }

  void updateBank_Acct_No() {
    setState(() {
      employee_user_req.bank_Acct_No = BankAccController.text;
    });
  }

  void updateSaving_Acct_No() {
    setState(() {
      employee_user_req.saving_Acct_No = SavingAccController.text;
    });
  }

  void updateLabourNo() {
    setState(() {
      employee_user_req.labourNo = LabourNoController.text;
    });
  }

  void updateSSBNo() {
    setState(() {
      employee_user_req.sSB_No = SSBNoController.text;
    });
  }

  void updateLife_Insurance() {
    setState(() {
      employee_user_req.life_Insurance = LifeInsuranceController.text != null && LifeInsuranceController.text != '' ? double.parse(LifeInsuranceController.text) : null;
    });
  }

  void updateRelocation() {
    setState(() {
      if (RelocationController == true) {
        employee_user_req.relocation = 1;
      }
      else {
        employee_user_req.relocation = 0;
      }
    });
  }

  void updatePreference() {
    setState(() {
      employee_user_req.preference = PreferenceController.text;
    });
  }

  void savePersonal() async{
    print('Save Personal');
    print(employee_user_req.emp_ID.toString());
    var saveResponse = await APIServices.postEmployeeUserReq(employee_user_req);
    print(saveResponse);
    if (saveResponse == true) {

      await APIServices.fetchUserReq(User.employeeId).then((response) async{  });

      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:Text('save complete.'),
            duration: Duration(seconds: 3),
          )
      );
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

  void deletePersonal(double id) async {
    var deleteResponse = await APIServices.deleteEmployeeUserReq(id);
    print(deleteResponse);

    await APIServices.fetchUserReq(User.employeeId).then((response) async{  });

    Navigator.pop(context, true);
    //deleteResponse == true ? Navigator.pop(context,true):Scaffold.of(context).showSnackBar(connectionIssueSnackBar);
  }

  Widget updateSaveText() {
    return employee_user_req.req_ID == 0 ? Text("Save") : Text("Update");
  }
}



