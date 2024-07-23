import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:people_app/services/api.services.dart';
import 'package:people_app/models/leave_type.dart';
import 'package:people_app/models/leave_request_his.dart';
import 'package:people_app/models/user.dart';
import 'package:people_app/models/param_output.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'file_picker_service.dart';
import 'dart:io';

class LeaveRequestDetailScreen extends StatefulWidget {
  final Leave_Request_His leave_request_his;
  LeaveRequestDetailScreen(this.leave_request_his);

  @override
  State<StatefulWidget> createState() => _LeaveRequestDetailScreen(leave_request_his);
}

class _LeaveRequestDetailScreen extends State<LeaveRequestDetailScreen> {
  final FilePickerService _filePickerService = FilePickerService();
  File? _selectedFile;

  Leave_Request_His leave_request_his;
  _LeaveRequestDetailScreen(this.leave_request_his);

  //final _leaveTypesList = ["Medical Leave","Casual Leave","Annual Leave","Education Leave","J/R Adjust","N/A"];
  //String? _leaveTypeList = "N/A";

  late List<Leave_Type> _leave_Types;
  late List<String> _leaveTypesList= [''];
  var leaveTypeSelectedValue;

  bool chkPass =false;

  final _hLV_StatusList = ["All","In","Out","N/A"];
  String? _hLV_Status = "All";
  var hLVStatusSelectedValue;

  var daysController = TextEditingController();
  var fromDateController = TextEditingController();
  var toDateController = TextEditingController();
  var reasonController = TextEditingController();

  double screenHeight = 0;
  double screenWidth = 0;

  var textStyle=TextStyle();
  var textStyleDisabled=TextStyle();

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
    await APIServices.fetchLeaveType().then((response)async{
      Iterable list=json.decode(response.body);
      List<Leave_Type>? ltList;
      ltList = list.map((model)=> Leave_Type.fromObject(model)).toList();

      _leave_Types = ltList;

      if (ltList!.isNotEmpty) {
        if (ltList!.length > 0) {
          ltList.forEach((item) {
            setState(() {
              _leaveTypesList.add(item.leave_Type_Name);
            });
          });
        }
        else {
          //print('fetchLeaveType isEmpty');
        }
      }

      _leave_Types.forEach((item) {
        if (item.leave_Type_ID == leave_request_his.leave_Type_ID) {
          leaveTypeSelectedValue = item.leave_Type_Name;
        }
      });
    });
  }

  void _getRecord() async {
    daysController.text=leave_request_his.days.toString();
    fromDateController.text=DateFormat('yyyy-MM-dd').format(leave_request_his.from_Date!);
    toDateController.text=DateFormat('yyyy-MM-dd').format(leave_request_his.to_Date!);
    reasonController.text=leave_request_his.reason.toString();

    hLVStatusSelectedValue = retrieveHLVStatus(leave_request_his.hLV_Status!);
  }

  void _checkAvailable() async {
    try {
      print('_checkAvailable');
      await APIServices.fetchCheckLeaveRequestByEmpIDLeaveTypeDays(User.employeeId,int.parse(leave_request_his.leave_Type_ID.toString()),
          double.parse(leave_request_his.days.toString()),DateFormat('yyyy-MM-dd').format(leave_request_his.from_Date as DateTime),
          DateFormat('yyyy-MM-dd').format(leave_request_his.to_Date as DateTime)).then((response) async {

        print(response.body.toString());
        Iterable list=json.decode(response.body);
        List<Param_Output>? pList;
        pList = list.map((model)=> Param_Output.fromObject(model)).toList();

        if (pList.isNotEmpty) {
          pList!.forEach((e) {
            print('isNotEmpty 2');
            print(e.result.toString());
            if (e.result == 'Pass') {
              setState(() {
                chkPass = true;
              });
            }
            else{
              setState(() {
                chkPass = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(e.result),
                    duration: Duration(seconds: 3),
                  )
              );
            }
          });
        }
        else{
          setState(() {
            chkPass = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('connection Issue!'),
                duration: Duration(seconds: 3),
              )
          );
        }
      });

    } catch(e) {

      setState(() {
        chkPass = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            duration: Duration(seconds: 3),
          )
      );
    }
  }

  void _pickFile() async {
    File? file = await _filePickerService.pickFile();
    setState(() {
      _selectedFile = file;
    });
  }

  void _uploadFile() async {
    if (_selectedFile != null) {
      await _filePickerService.uploadFile(_selectedFile!, 'YOUR_API_ENDPOINT');
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    textStyle=TextStyle(
      fontFamily: "NexaBold",
      fontSize: screenWidth / 18,
      color: Colors.black,
    );

    textStyleDisabled=TextStyle(
      fontFamily: "NexaBold",
      fontSize: screenWidth / 18,
      color: theme.disabledColor,
    );

    return Scaffold(
      appBar: AppBar(
        title:Text('Leave Request'),
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
            ElevatedButton(
              onPressed: _pickFile,
              child: Text('Pick File'),
            ),
            if (_selectedFile != null) ...[
              Text('File selected: ${_selectedFile!.path}'),
              ElevatedButton(
                onPressed: _uploadFile,
                child: Text('Upload File'),
              ),
            ],
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
                    items:_hLV_StatusList.map((String value){
                      return DropdownMenuItem<String>(
                        value:value,
                        child:Text(value),
                      );
                    }).toList(),
                    style: textStyle,
                    //value: retrieveHLVStatus(leave_request_his.hLV_Status!),
                    hint: Text("Leave Day Status"),
                    value: hLVStatusSelectedValue,
                    isDense: true,
                    onChanged: (value){
                      setState(() {
                        hLVStatusSelectedValue = value;
                      });
                      updateHLVStatus(value);
                    },
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: daysController,
                  style: textStyle,
                  //onChanged: (value)=>updateDays(),
                  onChanged: (value){
                    if (isNumeric(value) == false){
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:Text('Invalid Days!'),
                            duration: Duration(seconds: 3),
                          )
                      );
                    }
                    else{
                      if (double.parse(value).round()<=0){
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:Text('Invalid Days!'),
                              duration: Duration(seconds: 3),
                            )
                        );
                      }
                      else{
                        updateDays();
                        _checkAvailable();
                      }
                    }

                  },
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
                      labelText: "Day(s)",
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
                controller: fromDateController,
                style: textStyle,
                //onChanged: (value)=>updateFromDate(),
                onChanged: (value){
                  //updateFromDate();
                  _checkAvailable();
                },
                decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: "Start Date",
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
                      fromDateController.text = formattedDate; //set output date to TextField value.
                    });
                    updateFromDate();
                  }else{
                    print("Date is not selected");
                  }
                },
              ),
            ),
            Expanded(
              child: TextField(
                controller: toDateController,
                style: textStyleDisabled,
                enabled: false,
                //onChanged: (value)=>updateToDate(),
                onChanged: (value){
                  //updateToDate();
                  _checkAvailable();
                },
                decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: "End Date",
                    labelStyle: textStyleDisabled,
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
                      toDateController.text = formattedDate; //set output date to TextField value.
                    });
                    updateToDate();
                  }else{
                    print("Date is not selected");
                  }
                },
              ),
            ),
          ],
        ),

        Padding(padding: EdgeInsets.only(top:15.0,bottom: 15.0)),

        ListTile(
          title: DropdownButton<String>(
            isExpanded: true,
            items:_leaveTypesList.map((String value){
              return DropdownMenuItem<String>(
                value:value,
                child:Text(value),
              );
            }).toList(),
            style: textStyle,
            //value: retrieveLeaveType(leave_request_his.leave_Type_ID!),
            hint: Text("Leave Type"),
            value: leaveTypeSelectedValue,
            isDense: true,
            //onChanged: (value) => updateLeaveType(value),
            onChanged: (value){
              setState(() {
                leaveTypeSelectedValue = value;
              });
              updateLeaveType(value);
              _checkAvailable();
            },
          ),
        ),

        Padding(padding: EdgeInsets.only(top:15.0,bottom: 15.0)),

        TextField(
          controller: reasonController,
          style: textStyle,
          onChanged: (value)=>updateReason(),
          decoration: InputDecoration(
              labelText: "Reason",
              labelStyle: textStyle,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
              )
          ),
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
              onPressed: (chkPass == false) ? null : (){
                saveLeaveRequestHis();
              },
              child: updateSaveText(),
            ),

            ElevatedButton (
              /*
              padding: EdgeInsets.all(8.0),
              textColor: Colors.blueAccent,
              */
              onPressed: (chkPass == false) ? null : (){
                deleteLeaveRequestHis(leave_request_his.req_ID);
              },
              child: Text("Delete"),
            ),
          ],
        )

      ], ),
    );
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  String retrieveHLVStatus(int value){
    return value == 0 ? _hLV_StatusList[0]: _hLV_StatusList[value - 1];
  }

  void updateHLVStatus(String? value){
    switch (value){
      case "All":
        leave_request_his.hLV_Status=0;
        break;
      case "In":
        leave_request_his.hLV_Status=1;
        break;
      case "Out":
        leave_request_his.hLV_Status=2;
        break;
      case "N/A":
        leave_request_his.hLV_Status=0;
        break;
      default:
        leave_request_his.hLV_Status=0;
        break;
    }
  }

  void updateDays(){
    setState(() {
      leave_request_his.days = double.parse(daysController.text);
      int tDays = (double.parse(daysController.text).round())-1;
      if (fromDateController.text != ""){
        leave_request_his.to_Date = DateTime.parse(fromDateController.text).add(Duration(days: tDays));
        toDateController.text = DateFormat('yyyy-MM-dd').format(leave_request_his.to_Date as DateTime);
      }
    });
  }

  void updateFromDate(){
    setState(() {
      leave_request_his.from_Date = DateTime.parse(fromDateController.text);
      if (daysController.text != ""){
        int tDays = (double.parse(daysController.text).round())-1;
        leave_request_his.to_Date = DateTime.parse(fromDateController.text).add(Duration(days: tDays));
        toDateController.text = DateFormat('yyyy-MM-dd').format(leave_request_his.to_Date as DateTime);
      }
    });
  }

  void updateToDate(){
    leave_request_his.to_Date = DateTime.parse(toDateController.text);
  }
/*
  String retrieveLeaveType(int value){
    return value == 0 ? _leaveTypesList[0]: _leaveTypesList[value - 1];
  }

  void updateLeaveType(String? value){
    switch (value){
      case "Medical Leave":
        leave_request_his.leave_Type_ID=1;
        break;
      case "Casual Leave":
        leave_request_his.leave_Type_ID=2;
        break;
      case "Annual Leave":
        leave_request_his.leave_Type_ID=5;
        break;
      case "Education Leave":
        leave_request_his.leave_Type_ID=6;
        break;
      case "J/R Adjust":
        leave_request_his.leave_Type_ID=8;
        break;
      case "N/A":
        leave_request_his.leave_Type_ID=0;
        break;
      default:
        leave_request_his.leave_Type_ID=0;
        break;
    }
  }
*/
  String retrieveLeaveType(int? value){
    String vReturn='';
    _leave_Types.forEach((item) {
      if (item.leave_Type_ID == value){
        vReturn = item.leave_Type_Name;
      }
    });
    return vReturn;
  }

  void updateLeaveType(String? value){
    _leave_Types.forEach((item) {
      if (item.leave_Type_Name == value){
        setState(() {
          leaveTypeSelectedValue = value;
          leave_request_his.leave_Type_ID = item.leave_Type_ID;
        });
      }
    });
  }

  void updateReason(){
    setState(() {
      leave_request_his.reason = reasonController.text;
    });
  }

  void saveLeaveRequestHis() async{
    var saveResponse = await APIServices.postLeaveRequestHis(leave_request_his);
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

  Widget updateSaveText(){
    return leave_request_his.req_ID == 0 ? Text("Save"):Text("Update");
  }

  void deleteLeaveRequestHis(double id) async{
    var deleteResponse = await APIServices.deleteLeaveRequestHis(id);
    print(deleteResponse);
    Navigator.pop(context,true);
    //deleteResponse == true ? Navigator.pop(context,true):Scaffold.of(context).showSnackBar(connectionIssueSnackBar);
  }

}
