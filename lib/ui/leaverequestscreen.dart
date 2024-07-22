import 'package:people_app/models/leave_request_his.dart';
import 'package:people_app/models/user.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:people_app/services/api.services.dart';
import 'package:people_app/models/leave_request_his.dart';
import 'package:people_app/models/leave_type.dart';
import 'package:people_app/ui/leaverequestdetailscreen.dart';
import 'dart:convert';

class LeaveRequestScreen extends StatefulWidget {
  const LeaveRequestScreen({Key? key}) : super(key: key);

  @override
  _LeaveRequestScreenState createState() => _LeaveRequestScreenState();
}

class _LeaveRequestScreenState extends State<LeaveRequestScreen> {
  List<Leave_Request_His>? leave_request_his_s;

  late List<Leave_Type> _leave_Types;

  double screenHeight = 0;
  double screenWidth = 0;

  Color primary = const Color(0xFF0288D1);

  String _month = DateFormat('MMMM').format(DateTime.now());
  String _year = DateFormat('yyyy').format(DateTime.now());

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
    });
  }

  void _getRecord() async {
    //print('_getRecord');
    try{
      await APIServices.fetchLeaveRequestByEmpIDMonthYear(User.employeeId,_month,_year).then((response) async{
        Iterable list=json.decode(response.body);
        List<Leave_Request_His>? leaveList;
        leaveList = list.map((model)=> Leave_Request_His.fromObject(model)).toList();

        //ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text('fetchLeaveRequestByEmpIDMonthYear Pass!')));

        setState(() {
          //print('start fetchAttdCheckByEmpIDLogDate');
          //print(attdList!.length);
          if (leaveList!.isNotEmpty) {
            if (leaveList!.length > 0) {
              //print('isNotEmpty 1');
              leave_request_his_s = leaveList!;
            }
            else {
              //print('fetchAttdCheckByEmpIDLogDate isEmpty');
            }
          }
          else{
            leave_request_his_s = [];
          }
        });

      });

    }catch(e){
      //print('fetchAttdCheckByEmpIDLogDate Err');
      ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text('Catch Err: ' + e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: _buildFloatingButton(),
      appBar: AppBar(
        title:Text('My Leave Request'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 32),
                  child: Text(
                    _month,
                    style: TextStyle(
                      fontFamily: "NexaBold",
                      fontSize: screenWidth / 18,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 32),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0),
                      child: IconButton(tooltip: 'Reload', icon: Icon(Icons.refresh),onPressed: () async{
                        _getRecord();
                        setState(() {});
                      },)
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(top: 32),
                  child: GestureDetector(
                    onTap: () async {

                      final month = await showMonthYearPicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2099),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: primary,
                                secondary: primary,
                                onSecondary: Colors.white,
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  primary: primary,
                                ),
                              ),
                              textTheme: const TextTheme(
                                headline4: TextStyle(
                                  fontFamily: "NexaBold",
                                ),
                                overline: TextStyle(
                                  fontFamily: "NexaBold",
                                ),
                                button: TextStyle(
                                  fontFamily: "NexaBold",
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        }
                      );

                      if(month != null) {
                        setState(() {
                          _month = DateFormat('MMMM').format(month);
                          _year = DateFormat('yyyy').format(month);
                        });
                      }


                    },
                    child: Text(
                      "Pick a Month",
                      style: TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: screenWidth / 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(padding: EdgeInsets.only(top:15.0,bottom: 15.0)),

            SizedBox(
              height: screenHeight / 1.45,
              child: _buildLeaveList(),
              /*
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Employee")
                    .doc(User.id)
                    .collection("Record")
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if(snapshot.hasData) {
                    final snap = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: snap.length,
                      itemBuilder: (context, index) {
                        return DateFormat('MMMM').format(snap[index]['date'].toDate()) == _month ? Container(
                          margin: EdgeInsets.only(top: index > 0 ? 12 : 0, left: 6, right: 6),
                          height: 150,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset: Offset(2, 2),
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(),
                                  decoration: BoxDecoration(
                                    color: primary,
                                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      DateFormat('EE\ndd').format(snap[index]['date'].toDate()),
                                      style: TextStyle(
                                        fontFamily: "NexaBold",
                                        fontSize: screenWidth / 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Check In",
                                      style: TextStyle(
                                        fontFamily: "NexaRegular",
                                        fontSize: screenWidth / 20,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    Text(
                                      snap[index]['checkIn'],
                                      style: TextStyle(
                                        fontFamily: "NexaBold",
                                        fontSize: screenWidth / 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Check Out",
                                      style: TextStyle(
                                        fontFamily: "NexaRegular",
                                        fontSize: screenWidth / 20,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    Text(
                                      snap[index]['checkOut'],
                                      style: TextStyle(
                                        fontFamily: "NexaBold",
                                        fontSize: screenWidth / 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ) : const SizedBox();
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              */
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaveList(){
    return ListView.builder(
      itemCount: leave_request_his_s != null ? leave_request_his_s?.length : 0,
      itemBuilder: (context, index) {
        print('_buildLeaveList');

        if (leave_request_his_s![index].request_Date != null ){
          return DateFormat('MMMM').format(leave_request_his_s![index].request_Date!) == _month ? Container(
            margin: EdgeInsets.only(top: index > 0 ? 12 : 0, left: 6, right: 6),
            height: 150,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(2, 2),
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(),
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      child: Text(
                        //leave_request_his_s![index].request_Date != null ? DateFormat('EE\ndd').format(leave_request_his_s![index].request_Date!) : '',
                        retrieveLeaveType(leave_request_his_s![index].leave_Type_ID) + '\n' + '(' + leave_request_his_s![index].days.toString() + ')',
                        style: TextStyle(
                          fontFamily: "NexaBold",
                          fontSize: screenWidth / 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "From",
                        style: TextStyle(
                          fontFamily: "NexaRegular",
                          fontSize: screenWidth / 22,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        leave_request_his_s![index].from_Date != null ? DateFormat('dd-MM-yy').format(leave_request_his_s![index].from_Date!) : '',
                        style: TextStyle(
                          fontFamily: "NexaBold",
                          fontSize: screenWidth / 22,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "To",
                        style: TextStyle(
                          fontFamily: "NexaRegular",
                          fontSize: screenWidth / 22,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        leave_request_his_s![index].to_Date != null ? DateFormat('dd-MM-yy').format(leave_request_his_s![index].to_Date!) : '',
                        style: TextStyle(
                          fontFamily: "NexaBold",
                          fontSize: screenWidth / 22,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ElevatedButton(
                        child: Icon(Icons.edit),
                        onPressed: () async {
                          navigateToLeaveRequest(leave_request_his_s![index]);
                        },
                      ),

                      ElevatedButton(
                        child: Icon(Icons.delete),
                        onPressed: () async {
                          //deleteAttdCheck(attd_checkinouts![index].tran_ID);

                          print('delete 1');
                          print(leave_request_his_s![index].req_ID.toString());
                          var dResponse = await APIServices.deleteLeaveRequestHis(
                              leave_request_his_s![index].req_ID);
                          print('delete 2');
                          print(dResponse);
                          if (dResponse == true) {
                            //Navigator.pop(context, true);
                            _getRecord();
                            setState(() {

                            });
                          }
                          else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('connection Issue!'),
                                  duration: Duration(seconds: 3),
                                )
                            );
                          }

                          //setState(() { });

                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ) : const SizedBox();
        }
        else{
          return const SizedBox();
        }
      },
    );
  }

  String retrieveLeaveType(int? value){
    String vReturn='';
    _leave_Types.forEach((item) {
      if (item.leave_Type_ID == value){
        vReturn = item.leave_Type_Code;
      }
    });
    return vReturn;
  }

  Widget _buildFloatingButton(){
    return FloatingActionButton(
        tooltip: "Add Leave Request",
        child: Icon(Icons.airplane_ticket_outlined),
        onPressed: (){
          //navigateToEmpLogIn(Emp_Login(m_emp_Short: '',m_emp_Name: '',m_password: '',m_level_ID: 1));
          navigateToLeaveRequest(Leave_Request_His.WithId(m_req_ID: 0,m_emp_ID: User.employeeId,m_card_ID: 0,m_post_ID: 0,m_dept_ID:0,
              m_request_Date:DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now())),m_leave_Type_ID:0,
              m_from_Date:DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now())),m_to_Date:DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now())),m_days:1,m_hLV_Status:0,
              m_reason:'',m_status:0,m_approve_Emp_ID:0,m_approve_Date:DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now())),m_remark:'',m_attach_Type: '', m_editUserID: User.employeeId, m_editDateTime: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()))));
        });
  }

  void navigateToLeaveRequest(Leave_Request_His his) async{
    await Navigator.push(context, MaterialPageRoute(builder: (context) => LeaveRequestDetailScreen(his)));
  }

}
