// ignore_for_file: prefer_collection_literals

import 'package:flutter/material.dart';
import 'package:people_app/services/api.services.dart';
import 'package:people_app/models/emp_login.dart';
import 'dart:convert';
import 'package:people_app/ui/payslipdetailscreen.dart';
import 'package:people_app/models/paysheet.dart';
import 'package:people_app/models/payslip_detail.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:people_app/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:people_app/models/utils.dart';
import 'package:people_app/models/years.dart';

class PaysheetScreen extends StatefulWidget {
  PaysheetScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PaysheetScreenState();
}

class _PaysheetScreenState extends State<PaysheetScreen> {
  List<PaySheet>? paysheets;

  double screenHeight = 0;
  double screenWidth = 0;

  Color primary = const Color(0xFF0288D1);

  //String _month = DateFormat('MMMM').format(DateTime.now());
  String _month = '-9';
  String _year = DateFormat('yyyy').format(DateTime.now());

  List<String> _yearList = [
    DateFormat('yyyy').format(DateTime.now()),
    (int.parse(DateFormat('yyyy').format(DateTime.now())) - 1).toString(),
    (int.parse(DateFormat('yyyy').format(DateTime.now())) - 2).toString(),
  ];

  //late List<String> _yearList=[DateFormat('yyyy').format(DateTime.now())];
  int index=0;

  @override
  void initState() {
    super.initState();
    _getRecord();
  }

  void _getRecord() async {
    print('_getRecord');
    print('_month:' + _month);
    print('_year:' + _year);

    try{
      await APIServices.fetchPaySheetYearByEmpID(User.employeeId).then((response) async{
        Iterable list=json.decode(response.body);
        List<Years>? yList;
        yList = list.map((model)=> Years.fromObject(model)).toList();

        //ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text('fetchPaySheetYearByEmpID Pass!')));

        if (yList!.isNotEmpty) {
          if (yList!.length > 0) {
            yList.forEach((item) {
              if (item.yearVal != null && item.yearVal != '' && item.yearVal != ' ') {
                if (_yearList.contains(item.yearVal) == false) {
                  setState(() {
                    _yearList.add(item.yearVal);
                  });
                }
              }
            });
          }
          else {
            //print('fetchEmpLogIn isEmpty');
          }
        }
      });

      await APIServices.fetchPaySheetByEmpIDMonthYear(User.employeeId,_month,_year).then((response) async{
        Iterable list=json.decode(response.body);
        List<PaySheet>? payList;
        payList = list.map((model)=> PaySheet.fromObject(model)).toList();

        //ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text('fetchPaySheetByEmpIDMonthYear Pass!')));

        setState(() {
          //print('start fetchAttdCheckByEmpIDLogDate');
          //print(attdList!.length);
          if (payList!.isNotEmpty) {
            if (payList!.length > 0) {
              //print('isNotEmpty 1');
              paysheets = payList!;
            }
            else {
              //print('fetchAttdCheckByEmpIDLogDate isEmpty');
            }
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
      appBar: AppBar(
        title:Text('Paysheet List'),
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
              height: screenHeight / 1.45,
              child: (paysheets == null) ? Center(child: Text('Empty'),) : _buildPayList(),
            ),
          ],
        ),
      ),

    );
  }

  Widget _buildAppBar(){
    return AppBar(
      title:Text('Paysheet List'),
    );
  }

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

  Widget _buildPayList(){
    return ListView.builder(
      itemCount: paysheets?.length,
      itemBuilder: (context, index){
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: ListTile(
              leading: displayByLevel(),
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text(paysheets![index].sheet_Name),
              onTap: (){
                navigateToPaySlip(this.paysheets![index]);
              },
            ),
          ),
        );
      },
    );
  }

  void navigateToPaySlip(PaySheet pay) async{
    try {
      print ('@@@@@@@@@@@@@@ 1');
      print(pay.sheet_ID);
      print(User.employeeId);
      await APIServices.fetchPaySlipDetailBySheetIDEmpID(
          pay.sheet_ID, User.employeeId).then((response) async {
        Iterable list = json.decode(response.body);
        List<PaySlip_Detail> payList;
        payList =
            list.map((model) => PaySlip_Detail.fromObject(model)).toList();

        await Navigator.push(context, MaterialPageRoute(
            builder: (context) => PayslipDetailScreen(payList)));
      });
    }
    catch(e){
      ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text('Catch Err: ' + e.toString())));
    }
  }

  Widget displayByLevel(){
    var sheet = Icon(Icons.money,color: Colors.lightBlue,);

    return (sheet);
  }

}
