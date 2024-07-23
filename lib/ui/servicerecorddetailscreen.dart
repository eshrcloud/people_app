import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:people_app/services/api.services.dart';
import 'package:people_app/models/Service_Log.dart';
import 'package:people_app/models/Team.dart';
import 'package:people_app/models/ie_type.dart';
import 'package:people_app/models/emp_login.dart';
import 'package:people_app/models/Service_Assign.dart';
import 'package:people_app/models/user.dart';
import 'package:people_app/models/param_output.dart';
import 'dart:convert';

class ServiceRecordDetailScreen extends StatefulWidget {
  final Service_Log service_log;
  ServiceRecordDetailScreen(this.service_log);

  @override
  State<StatefulWidget> createState() => _ServiceRecordDetailScreenState(service_log);
}

class _ServiceRecordDetailScreenState extends State<ServiceRecordDetailScreen> {
  Service_Log service_log;
  _ServiceRecordDetailScreenState(this.service_log);

  late List<Team> _team_List;
  late List<Emp_Login> _emp_Login_List;
  late List<IE_Type> _IEType_List;

  late List<String> _teamList= [''];
  late List<String> _empList= [];
  late List<String> _IETypeList= [''];
  List<String> _selectedItems = [];
  var teamSelectedValue;
  var ietypeSelectedValue;

  var productController = TextEditingController();
  var clientController = TextEditingController();
  var descriptionController = TextEditingController();
  var reqDateController = TextEditingController();
  var targetDateController = TextEditingController();
  bool finishController = false;
  var incomeController = TextEditingController();
  var expenseController = TextEditingController();
  bool paidController = false;
  var remarkController = TextEditingController();

  double screenHeight = 0;
  double screenWidth = 0;

  var textStyle=TextStyle();
  final connectionIssueSnackBar = SnackBar(content: Text("404, Connection Issue !"));

  String vTodayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateTime vToday = DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));

  @override
  void initState() {
    super.initState();
    _getRowSource();
    _getRecord();
  }

  void _getRowSource() async {
    await APIServices.fetchTeam().then((response) async{
      Iterable list=json.decode(response.body);
      List<Team>? tList;
      tList = list.map((model)=> Team.fromObject(model)).toList();

      setState(() {
        _team_List = tList!;
      });

      if (tList!.isNotEmpty) {
        if (tList!.length > 0) {
          tList.forEach((item) {
            setState(() {
              _teamList.add(item.team_Name);
              /*
              if (tList!.contains(item.TeamName) == false) {
                _teamList.add(item.TeamName);
              }
               */
            });
          });
        }
        else {
          //print('fetchAttdCheckByEmpIDLogDate isEmpty');
        }
      }

      _team_List.forEach((item) {
        if (item.team_ID == service_log.teamID) {
          teamSelectedValue = item.team_Name;
        }
      });

    });

    await APIServices.fetchIEType().then((response) async{
      Iterable list=json.decode(response.body);
      List<IE_Type>? ieList;
      ieList = list.map((model)=> IE_Type.fromObject(model)).toList();

      setState(() {
        _IEType_List = ieList!;
      });

      if (ieList!.isNotEmpty) {
        if (ieList!.length > 0) {
          ieList.forEach((item) {
            setState(() {
              _IETypeList.add(item.Name);
              /*
              if (ieList!.contains(item.Name) == false) {
                _IETypeList.add(item.Name);
              }
               */
            });
          });
        }
        else {
          //print('fetchAttdCheckByEmpIDLogDate isEmpty');
        }
      }

      _IEType_List.forEach((item) {
        if (item.IEType == service_log.ieType) {
          ietypeSelectedValue = item.Name;
        }
      });

    });

    await APIServices.fetchServiceEmpLogIn().then((response) async{
      Iterable list=json.decode(response.body);
      List<Emp_Login>? eList;
      eList = list.map((model)=> Emp_Login.fromObject(model)).toList();

      _emp_Login_List = eList;

      if (eList!.isNotEmpty) {
        if (eList!.length > 0) {
          eList.forEach((item) {
            if (item.emp_Name != null && item.emp_Name != '' && item.emp_Name != ' ') {
              setState(() {
                _empList.add(item.emp_Name);
              });
            }
          });
        }
        else {
          //print('fetchEmpLogIn isEmpty');
        }
      }
    });

  }

  void _showMultiSelect() async{
    //final List<String> items = ['A','B','C'];
    final List<String> items = _empList;
    final List<String>? results = await showDialog(
        context: context,
        builder: (BuildContext context){
          return MultiSelect(items: items);
        },
    );

    if (results != null){
      setState(() {
        _selectedItems = results;
      });
    }
  }

  void _getRecord() async {
    setState(() async {

      await APIServices.fetchServiceAssignEmpLogIn(service_log.serviceID).then((response) async{
        Iterable list=json.decode(response.body);
        List<Emp_Login>? eList;
        eList = list.map((model)=> Emp_Login.fromObject(model)).toList();

        print('Selected Items');
        if (eList!.isNotEmpty) {
          if (eList!.length > 0) {
            eList.forEach((item) {
              if (item.emp_Name != null && item.emp_Name != '' && item.emp_Name != ' ') {
                print(item.emp_Name);
                setState(() {
                  _selectedItems.add(item.emp_Name);
                });
              }
            });
          }
          else {
            //print('fetchEmpLogIn isEmpty');
          }
        }
      });

      //print('Product-' + service_log.product.toString());
      productController.text=service_log.product.toString();
      //print('Client-' + service_log.client.toString());
      clientController.text=service_log.client.toString();
      //print('Description-' + service_log.description.toString());
      descriptionController.text=service_log.description.toString();
      //print('ReqDate-' + service_log.reqDate.toString());
      reqDateController.text= DateFormat('yyyy-MM-dd').format(service_log.reqDate as DateTime);
      //print('TargetDate-' + service_log.targetDate.toString());
      targetDateController.text=DateFormat('yyyy-MM-dd').format(service_log.targetDate as DateTime);
      //print('Finish-' + service_log.finish.toString());
      finishController = service_log.finish!;
      //print('Charges-' + service_log.charges.toString());
      incomeController.text=service_log.income.toString();
      expenseController.text=service_log.expense.toString();
      //print('Paid-' + service_log.paid.toString());
      paidController = service_log.paid!;
      //print('Remark-' + service_log.remark.toString());
      remarkController.text=service_log.remark.toString();
/*
      _team_List.forEach((item) {
        if (item.team_ID == service_log.teamID) {
          teamSelectedValue = item.team_Name;
        }
      });
      
      _IEType_List.forEach((item) {
        if (item.ietype == service_log.ietype) {
          ietypeSelectedValue = item.Name;
        }
      });
 */
    });
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

    return Scaffold(
      appBar: AppBar(
        title:Text('Service Record Detail'),
      ),
      body: _buildForm(),
    );
  }

  Widget _buildForm(){

    return Padding(
      padding: EdgeInsets.only(top: 35.0, left: 10.0, right: 10.0),
      child: ListView( children: <Widget>[

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: ListTile(
                  title: DropdownButton<String>(
                    isExpanded: true,
                    style: textStyle,
                    items: _teamList.map((String value){
                      return DropdownMenuItem<String>(
                        value:value,
                        child:Text(value),
                      );
                    }).toList(),
                    hint: Text("Team"),
                    value: teamSelectedValue,
                    //value: retrieveTeam(service_log.teamID!),
                    isDense: true,
                    onChanged: (value){
                      setState(() {
                        teamSelectedValue = value;
                      });
                      updateTeam(value);
                    },
                  ),
                ),
            ),

            Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    Expanded(
                        child: CheckboxListTile(
                          title: Text("Finish"),
                          value: finishController,
                          onChanged: (value)=>updateFinish(value),
                          controlAffinity: ListTileControlAffinity
                              .leading, //  <-- leading Checkbox
                        )
                    ),
                    Expanded(
                      child:ElevatedButton (
                        onPressed: _showMultiSelect,
                        child: const Text("Add Member"),
                      ),
                    ),
                  ],
                )
            ),
          ],
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Wrap(
              children: _selectedItems
                  .map((e) => Chip(label: Text(e),))
                  .toList(),
            )
          ],
        ),

        Padding(padding: EdgeInsets.only(top:15.0,bottom: 15.0)),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                controller: productController,
                style: textStyle,
                onChanged: (value)=>updateProduct(),
                decoration: InputDecoration(
                    labelText: "Product",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
              ),
            ),
            Expanded(
              child: TextField(
                controller: clientController,
                style: textStyle,
                onChanged: (value)=>updateClient(),
                decoration: InputDecoration(
                    labelText: "Client",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
              ),
            ),
          ],
        ),

        Padding(padding: EdgeInsets.only(top:15.0,bottom: 15.0)),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                controller: descriptionController,
                style: textStyle,
                onChanged: (value)=>updateDescription(),
                decoration: InputDecoration(
                    labelText: "Description",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
              ),
            ),
          ],
        ),

        Padding(padding: EdgeInsets.only(top:15.0,bottom: 15.0)),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                controller: reqDateController,
                style: textStyle,
                onChanged: (value)=>updateReqDate(),
                decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: "Request Date",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context, initialDate: DateTime.now(),
                      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101)
                  );

                  if(pickedDate != null ){
                    print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(formattedDate); //formatted date output using intl package =>  2021-03-16
                    //you can implement different kind of Date Format here according to your requirement

                    setState(() {
                      reqDateController.text = formattedDate; //set output date to TextField value.
                    });
                    updateReqDate();
                  }else{
                    print("Date is not selected");
                  }
                },
              ),
            ),
            Expanded(
              child: TextField(
                controller: targetDateController,
                style: textStyle,
                onChanged: (value)=>updateTargetDate(),
                decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: "Target Date",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context, initialDate: DateTime.now(),
                      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101)
                  );

                  if(pickedDate != null ){
                    print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(formattedDate); //formatted date output using intl package =>  2021-03-16
                    //you can implement different kind of Date Format here according to your requirement

                    setState(() {
                      targetDateController.text = formattedDate; //set output date to TextField value.
                    });
                    updateTargetDate();
                  }else{
                    print("Date is not selected");
                  }
                },
              ),
            ),
          ],
        ),

        Padding(padding: EdgeInsets.only(top:15.0,bottom: 15.0)),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: ListTile(
                  title: DropdownButton<String>(
                    isExpanded: true,
                    style: textStyle,
                    items: _IEType_List.map((String value){
                      return DropdownMenuItem<String>(
                        value:value,
                        child:Text(value),
                      );
                    }).toList(),
                    hint: Text("IE Type"),
                    value: ietypeSelectedValue,
                    //value: retrieveTeam(service_log.ietype!),
                    isDense: true,
                    onChanged: (value){
                      setState(() {
                        ietypeSelectedValue = value;
                      });
                      updateIEType(value);
                    },
                  ),
                ),
            ),

            Expanded(
                child: TextField(
                controller: remarkController,
                style: textStyle,
                onChanged: (value)=>updateRemark(),
                decoration: InputDecoration(
                    labelText: "Remark",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
              ),
            ),
          ],
        ),

        Padding(padding: EdgeInsets.only(top:15.0,bottom: 15.0)),
/*
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                'Finish :',
                style: TextStyle(
                  fontFamily: "NexaBold",
                  fontSize: screenWidth / 18,
                ),
              ),
            ),
            Expanded(
              child: Checkbox(
                value: finishController,
                onChanged: (value)=>updateFinish(value),
                /*
              onChanged: (value) {
                setState(() {
                  this.finishController = value as bool;
                });
              },
               */
              ),
            ),

            Expanded(
              child: TextField(
                controller: chargesController,
                style: textStyle,
                onChanged: (value)=>updateCharges(),
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
                    labelText: "Charges",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
              ),
            ),

            Expanded(
              child: Text(
                'Paid :',
                style: TextStyle(
                  fontFamily: "NexaBold",
                  fontSize: screenWidth / 18,
                ),
              ),
            ),
            Expanded(
              child: Checkbox(
                value: paidController,
                onChanged: (value)=>updatePaid(value),
                /*
              onChanged: (value) {
                setState(() {
                  this.paidController = value as bool;
                });
              },
               */
              ),
            ),

          ],
        ),
*/
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    Expanded(
                        child: TextField(
                          controller: incomeController,
                          style: textStyle,
                          onChanged: (value)=>updateIncome(),
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
                              labelText: "Income",
                              labelStyle: textStyle,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)
                              )
                          ),
                        )
                    ),
                    Expanded(
                        child: TextField(
                          controller: expenseController,
                          style: textStyle,
                          onChanged: (value)=>updateExpense(),
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
                              labelText: "Charges",
                              labelStyle: textStyle,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)
                              )
                          ),
                        )
                      ),
                  ],
                )
            ),
            
            Expanded(
                child: CheckboxListTile(
                  title: Text("Paid"),
                  value: paidController,
                  onChanged: (value)=>updatePaid(value),
                  controlAffinity: ListTileControlAffinity
                      .leading, //  <-- leading Checkbox
                )
            ),
          ],
        ),

        Padding(padding: EdgeInsets.only(top:15.0,bottom: 15.0)),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ElevatedButton (
              /*
              padding: EdgeInsets.all(8.0),
              textColor: Colors.blueAccent,
               */
              onPressed: (){
                saveServiceLog();
              },
              child: updateSaveText(),
            ),

            ElevatedButton (
              /*
              padding: EdgeInsets.all(8.0),
              textColor: Colors.blueAccent,
              */
              onPressed: (){
                deleteServiceLog(service_log.serviceID);
              },
              child: Text("Delete"),
            ),
          ],
        )

      ], ),
    );
  }

  String retrieveTeam(int value){
    return value == 0 ? _teamList[0]: _teamList[value - 1];
  }

  void updateTeam(String? value){
    _team_List.forEach((item) {
      if (item.team_Name == value){
        setState(() {
          service_log.teamID = item.team_ID;
        });
      }
    });

    /*
    switch (value){
      case "iCare Team":
        service_log.TeamID=1;
        break;
      case "People Team":
        service_log.TeamID=2;
        break;
      default:
        service_log.TeamID=0;
        break;
    }
     */
  }

  String retrieveIEType(int value){
    return value == 0 ? _IETypeList[0]: _IETypeList[value - 1];
  }

  void updateIEType(String? value){
    _IEType_List.forEach((item) {
      if (item.Name == value){
        setState(() {
          service_log.ieType = item.IEType;
        });
      }
    });
  }

  void updateProduct(){
    setState(() {
      service_log.product = productController.text;
    });
  }

  void updateClient(){
    setState(() {
      service_log.client = clientController.text;
    });
  }

  void updateDescription(){
    setState(() {
      service_log.description = descriptionController.text;
    });
  }

  void updateReqDate(){
    setState(() {
      service_log.reqDate = DateTime.parse(reqDateController.text);
    });
  }

  void updateTargetDate(){
    setState(() {
      service_log.targetDate = DateTime.parse(targetDateController.text);
    });
  }

  void updateRemark(){
    setState(() {
      service_log.remark = remarkController.text;
    });
  }

  void updateFinish(value){
    setState(() {
      finishController = value;
      service_log.finish = value;
    });
  }

  void updateIncome(){
    setState(() {
      service_log.income = double.parse(incomeController.text);
    });
  }

  void updateExpense(){
    setState(() {
      service_log.expense = double.parse(expenseController.text);
    });
  }

  void updatePaid(value){
    setState(() {
      paidController = value;
      service_log.paid = value;
    });
  }

  void saveServiceLog() async{
    var saveResponse = await APIServices.postServiceLog(service_log);
    print('saveServiceLog!');
    print(saveResponse);

    if (saveResponse == false) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:Text('postServiceLog: connection Issue!'),
            duration: Duration(seconds: 3),
          )
      );
    }

    double gServiceID=0, gEmpID=0;

    var assign_SaveResponse = true;

    if (service_log.serviceID != 0) {
      print('service_log.serviceID != 0');
      gServiceID = service_log.serviceID;
      print(gServiceID);

      await APIServices.deleteServiceAssign(gServiceID);

      Service_Assign saObj;

      _selectedItems.forEach((element) async{
        _emp_Login_List.forEach((item) async{
          if (item.emp_Name == element){
            gEmpID = item.emp_ID;
            //if (gEmpID != User.employeeId) {
            print(item.emp_Name);
            saObj = new Service_Assign(m_ServiceID: gServiceID, m_EmpID: gEmpID, m_editUserID: User.employeeId, m_editDateTime: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now())));
            assign_SaveResponse = await APIServices.postServiceAssign(
                saObj);
            //}
          }
        });
      });

      //print(assign_SaveResponse);

      if (assign_SaveResponse == false) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:Text('Service_Assign: connection Issue!'),
              duration: Duration(seconds: 3),
            )
        );
      }
    }
    else {
      print('service_log.serviceID == 0');
      APIServices.fetchServiceLogByEmpIDProductClientDespTarget(
          User.employeeId, service_log.product as String,
          service_log.client as String,
          service_log.description as String,
          DateFormat('yyyy-MM-dd').format(service_log.targetDate as DateTime))
          .then((response) {
        Iterable list = json.decode('[' + response.body + ']');
        List<Service_Log>? sList;
        sList =
            list.map((model) => Service_Log.fromObject(model)).toList();

        if (sList!.isNotEmpty) {
          if (sList!.length > 0) {
            sList.forEach((item) async {
              gServiceID = item.serviceID;
              print(gServiceID);

              await APIServices.deleteServiceAssign(gServiceID);

              Service_Assign saObj;

              _selectedItems.forEach((element) async{
                _emp_Login_List.forEach((item) async{
                  if (item.emp_Name == element){
                    gEmpID = item.emp_ID;
                    //if (gEmpID != User.employeeId) {
                    print(item.emp_Name);
                    saObj = new Service_Assign(m_ServiceID: gServiceID, m_EmpID: gEmpID, m_editUserID: User.employeeId, m_editDateTime: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now())));
                    assign_SaveResponse = await APIServices.postServiceAssign(
                        saObj);
                    //}
                  }
                });
              });

              //print(assign_SaveResponse);

              if (assign_SaveResponse == false) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:Text('connection Issue!'),
                      duration: Duration(seconds: 3),
                    )
                );
              }

            });
          }
          else {
            //print('fetchEmpFamily isEmpty');
          }
        }
      });
    }

    Navigator.pop(context, true);
  }

  Widget updateSaveText(){
    return service_log.serviceID == 0 ? Text("Save"):Text("Update");
  }

  void deleteServiceLog(double id) async{
    var deleteResponse = await APIServices.deleteServiceLog(id);
    print(deleteResponse);
    Navigator.pop(context,true);
    //deleteResponse == true ? Navigator.pop(context,true):Scaffold.of(context).showSnackBar(connectionIssueSnackBar);
  }

}

class MultiSelect extends StatefulWidget {
  final List<String> items;
  const MultiSelect({Key? key, required this.items}) : super(key: key);

  @override
  State<MultiSelect> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  final List<String> _selectedItems = [];

  void _itemChange(String itemValue, bool isSelected){
    setState(() {
      if (isSelected){
        _selectedItems.add(itemValue);
      }else{
        _selectedItems.remove(itemValue);
      }
    });
  }

  void _cancel(){
    Navigator.pop(context);
  }

  void _submit(){
    Navigator.pop(context, _selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Member'),
      content: SingleChildScrollView(
        child:ListBody(
          children: widget.items
            .map((item) => CheckboxListTile(
              value: _selectedItems.contains(item),
              title: Text(item),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (isChecked) => _itemChange(item, isChecked!),
            ))
          .toList(),
        ),
      ),
      actions: [
        TextButton(
            onPressed: _cancel,
            child: const Text('Cancel'),
        ),
        ElevatedButton(
            onPressed: _submit,
            child: const Text('Submit'),
        ),
      ],
    );
  }
}
}