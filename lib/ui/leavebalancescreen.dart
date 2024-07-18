import 'package:people_app/models/user.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:people_app/services/api.services.dart';
import 'package:people_app/models/leave_balance_tmp.dart';
import 'package:people_app/models/leave_request_his.dart';
import 'package:people_app/ui/leaverequestdetailscreen.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:people_app/models/utils.dart';
import 'package:people_app/ui/leavebar.dart';
import 'package:people_app/datasources/leave_balance_data.dart';

class LeaveBalanceScreen extends StatefulWidget {
  const LeaveBalanceScreen({Key? key}) : super(key: key);

  @override
  _LeaveBalanceScreenState createState() => _LeaveBalanceScreenState();
}

class _LeaveBalanceScreenState extends State<LeaveBalanceScreen> {
  List<Leave_Balance_Tmp>? leave_balance_tmp_s;

  double screenHeight = 0;
  double screenWidth = 0;

  Color primary = const Color(0xFF0288D1);

  String _month = DateFormat('MMMM').format(DateTime.now());
  String _year = DateFormat('yyyy').format(DateTime.now());

  final columns = ['Leave Type', 'Entitle', 'Taken', 'Balance'];

  List<String> _yearList = [
    DateFormat('yyyy').format(DateTime.now()),
    (int.parse(DateFormat('yyyy').format(DateTime.now())) - 1).toString(),
    (int.parse(DateFormat('yyyy').format(DateTime.now())) - 2).toString(),
    (int.parse(DateFormat('yyyy').format(DateTime.now())) - 3).toString(),
    (int.parse(DateFormat('yyyy').format(DateTime.now())) - 4).toString(),
    (int.parse(DateFormat('yyyy').format(DateTime.now())) - 5).toString()
  ];
  int index=0;

  @override
  void initState() {
    super.initState();
    _getRecord();
  }

  void _getRecord() async {
    //print('_getRecord');
    try{
      await APIServices.fetchLeaveBalanceByEmpIDYear(User.employeeId, int.parse(_year)).then((response) async{

        //ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text('fetchLeaveBalanceByEmpIDYear Pass!')));

        await APIServices.fetchLeaveBalanceTmpByEmpID(User.employeeId).then((response) async{
          Iterable list=json.decode(response.body);
          List<Leave_Balance_Tmp>? leaveList;
          leaveList = list.map((model)=> Leave_Balance_Tmp.fromObject(model)).toList();

          //ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text('fetchLeaveBalanceTmpByEmpID Pass!')));

          setState(() {
            //print('start fetchAttdCheckByEmpIDLogDate');
            //print(attdList!.length);
            if (leaveList!.isNotEmpty) {
              if (leaveList!.length > 0) {
                //print('isNotEmpty 1');
                leave_balance_tmp_s = leaveList!;
              }
              else {
                //print('fetchLeaveBalanceByEmpIDYear isEmpty');
              }
            }
          });

        });
      });

    }catch(e){
      //print('fetchLeaveBalanceByEmpIDYear Err');
      ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text('Catch Err: ' + e.toString())));
    }
  }

  List<Map<String,Object>> get groupedTransactionValues{
    if (leave_balance_tmp_s != null){
      return List.generate(leave_balance_tmp_s!.length, (index) {
        return {"leave_Type": leave_balance_tmp_s![index].leave_Type_Name != null ? leave_balance_tmp_s![index].leave_Type_Name : "Default",
          "total": leave_balance_tmp_s![index].total_Leave_Entitlement != null ? leave_balance_tmp_s![index].total_Leave_Entitlement.toString() : "0.0",
          "taken": leave_balance_tmp_s![index].total_Leave != null ? leave_balance_tmp_s![index].total_Leave.toString() : "0.0",
          "balance": leave_balance_tmp_s![index].leave_Balance != null ? leave_balance_tmp_s![index].leave_Balance.toString() : "0.0",
        };
      });
    }
    else{
      return List.generate(1, (index) {
        return {"leave_Type": "Default",
        "total": "0.0",
        "taken": "0.0",
        "balance": "0.0",
        };
      });
    }
  }

  double get totalSpending{
    return groupedTransactionValues!.fold(0.0, (sum, item){
      return sum + double.parse(item['balance'] as String);
      //return double.parse(item['taken'].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    List<Leave_Balance_Tmp> defaultList = [Leave_Balance_Tmp(m_emp_ID: double.parse(User.employeeId.toString()), m_leave_Type_ID: 0, m_year: int.parse(_year), m_entitlement: 0, m_user_ID: int.parse(User.employeeId.toString()), m_leave_Type_Name: '', m_total_Leave: 0, m_total_Leave_Entitlement: 0, m_leave_Balance: 0)];

    DataTableSource _data = Leave_Balance_Data(leave_balance_tmp_s != null ? leave_balance_tmp_s! : defaultList);

    return Scaffold(
      floatingActionButton: _buildFloatingButton(),
      appBar: AppBar(
        title:Text('My Leave Balance'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 0),
                  child: _buildCustomPicker(),
                ),
              ],
            ),

            Padding(padding: EdgeInsets.only(top:15.0,bottom: 15.0)),

            SizedBox(
              height: screenHeight / 3.8,
              child: _buildLeaveList(),
            ),

            Column(
              children: [

                SizedBox(
                  height: 5,
                ),

                PaginatedDataTable(
                  columns: getColumns(columns),
                  source: _data,
                  columnSpacing: 30,
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

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
    label: Text(column),
  ))
      .toList();

  Widget _buildCustomPicker() => SizedBox(
    height: 200,
    child: CupertinoPicker(
      itemExtent: 64,
      diameterRatio: 0.7,
      looping: true,
      //onSelectedItemChanged: (index) => setState(() => this.index = index),
      onSelectedItemChanged: (index){
        setState(() {
          this.index = index;
          _month = '-9';
          _year = _yearList[index].toString();
        });
        _getRecord();
      },
      // selectionOverlay: Container(),
      selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
        background: Colors.blue.withOpacity(0.12),
      ),
      children: Utils.modelBuilder<String>(
        _yearList,
            (index, value) {
          final isSelected = this.index == index;
          final color = isSelected ? Colors.blue : Colors.black;

          return Center(
            child: Text(
              value,
              style: TextStyle(color: color, fontSize: 24),
            ),
          );
        },
      ),
    ),
  );

  Widget _buildLeaveList(){
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues!.map((data) {
            return Flexible(
              fit: FlexFit.loose,
              /*
              child: LeaveBar(data['leave_Type'].toString(),
                  double.parse(data['total'].toString()),
                  double.parse(data['taken'].toString()),
                  totalSpending==0.0?0.0:(data['total'] as double)/ 1),
               */
              child: LeaveBar(data['leave_Type'].toString(),
                double.parse(data['total'].toString()),
                double.parse(data['taken'].toString()),
                data['total'].toString() == "0.0" || data['total'].toString() == "0" || data['total'].toString() == "" ? 0.0 : double.parse(data['balance'].toString())/double.parse(data['total'].toString())
              ),
            );
          }).toList(),
        ),
      ),
    );
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
              m_reason:'',m_status:0,m_approve_Emp_ID:0,m_approve_Date:DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now())),m_remark:'', m_editUserID: User.employeeId, m_editDateTime: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()))));
        });
  }

  void navigateToLeaveRequest(Leave_Request_His his) async{
    await Navigator.push(context, MaterialPageRoute(builder: (context) => LeaveRequestDetailScreen(his)));
  }

}
