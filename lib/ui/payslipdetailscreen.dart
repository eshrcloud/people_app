// ignore_for_file: prefer_collection_literals

import 'package:flutter/material.dart';
import 'package:people_app/services/api.services.dart';
import 'package:people_app/models/emp_login.dart';
import 'dart:convert';
import 'package:people_app/ui/AddEmpLogIn.dart';
import 'package:people_app/models/payslip_detail.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:people_app/models/user.dart';

class PayslipDetailScreen extends StatefulWidget {
  final List<PaySlip_Detail> payslip_details;
  PayslipDetailScreen(this.payslip_details);

  @override
  State<StatefulWidget> createState() => _PayslipDetailScreenState(payslip_details);
}

class _PayslipDetailScreenState extends State<PayslipDetailScreen> {
  List<PaySlip_Detail> payslip_details;
  _PayslipDetailScreenState(this.payslip_details);

  double screenHeight = 0;
  double screenWidth = 0;

  Color primary = const Color(0xFF0288D1);

  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String Function(Match) mathFunc = (Match match) => '${match[1]},';

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title:Text('Payslip Detail'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 32),
                  child: Text(
                    payslip_details == null ? '' : payslip_details![0].sheet_Name.toString(),
                    style: TextStyle(
                      fontFamily: "NexaBold",
                      fontSize: screenWidth / 18,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),

            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:<Widget> [
                  Expanded(
                    child: Text(
                      'Salary Currency',
                      style: TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: screenWidth / 18,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  Expanded(
                    child: Text(
                      ' - ',
                      style: TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: screenWidth / 18,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  Expanded(
                    child: Text(
                      payslip_details == null ? '' : payslip_details![0].salary_Currency_Name.toString(),
                      style: TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: screenWidth / 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //Padding(padding: EdgeInsets.only(top:15.0,bottom: 15.0)),

            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:<Widget> [
                  Expanded(
                    child: Text(
                      'Basic Pay',
                      style: TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: screenWidth / 18,
                      ),
                    ),
                  ),

                  Expanded(
                    child: Text(
                      ' - ',
                      style: TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: screenWidth / 18,
                      ),
                    ),
                  ),

                  Expanded(
                    child: Text(
                      payslip_details == null ? '' : payslip_details![0].basic_Pay.toString().replaceAllMapped(reg, mathFunc),
                      style: TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: screenWidth / 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:<Widget> [
                  Expanded(
                    child: Text(
                      'Award',
                      style: TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: screenWidth / 18,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  Expanded(
                    child: Text(
                      ' - ',
                      style: TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: screenWidth / 18,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  Expanded(
                    child: Text(
                      payslip_details == null ? '' : payslip_details![0].award_Amt.toString().replaceAllMapped(reg, mathFunc),
                      style: TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: screenWidth / 18,
                        color: Colors.black,
                      ),
                    ),
                  ),

                ],
              ),
            ),

            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:<Widget> [
                  Expanded(
                    child: Text(
                      'Deduct',
                      style: TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: screenWidth / 18,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  Expanded(
                    child: Text(
                      ' - ',
                      style: TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: screenWidth / 18,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  Expanded(
                    child: Text(
                      payslip_details == null ? '' : payslip_details![0].deduct_Amt.toString().replaceAllMapped(reg, mathFunc),
                      style: TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: screenWidth / 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:<Widget> [
                  Expanded(
                    child: Text(
                      'Net Amount',
                      style: TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: screenWidth / 18,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  Expanded(
                    child: Text(
                      ' - ',
                      style: TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: screenWidth / 18,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  Expanded(
                    child: Text(
                      payslip_details == null ? '' : payslip_details![0].net_Amt.toString().replaceAllMapped(reg, mathFunc),
                      style: TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: screenWidth / 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Stack(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 32),
                  child: Text('Rule Detail:',
                    style: TextStyle(
                      fontFamily: "NexaBold",
                      fontSize: screenWidth / 28,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: screenHeight / 1.45,
              child: (payslip_details == null) ? Center(child: Text('Empty'),) : _buildPayList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(){
    return AppBar(
      title:Text('Payslip Detail'),
    );
  }

  Widget _buildPayList(){
    return ListView.builder(
      itemCount: payslip_details?.length,
      itemBuilder: (context, index){
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: ListTile(
              leading: displayByLevel(payslip_details![index].rType_ID.toString()),
              title: Text(
                  payslip_details![index].rType_ID.toString() == '1' ? ( payslip_details![index].remark.toString() == '' ? payslip_details![index].rule_Name.toString() + ' - ' + payslip_details![index].aD_Amt.toString().replaceAllMapped(reg, mathFunc) : payslip_details![index].rule_Name.toString() + ' - ' + payslip_details![index].aD_Amt.toString().replaceAllMapped(reg, mathFunc) + ' (' + payslip_details![index].remark.toString() + ')' ) : ( payslip_details![index].remark.toString() == '' ? payslip_details![index].rule_Name.toString() + ' - (' + payslip_details![index].aD_Amt.toString().replaceAllMapped(reg, mathFunc) + ')' : payslip_details![index].rule_Name.toString() + ' - (' + payslip_details![index].aD_Amt.toString().replaceAllMapped(reg, mathFunc) + ')' + ' (' + payslip_details![index].remark.toString() + ')' ),
                style:TextStyle(
                  color: Colors.black,
                ),
              ),
              //title: Text(payslip_details![index].rule_Name.toString() + ' - ' + payslip_details![index].rType_ID.toString() == '1' ? payslip_details![index].aD_Amt.toString() : '(' + payslip_details![index].aD_Amt.toString() + ')'),
            ),
          ),
        );
      },
    );
  }

  Widget displayByLevel(String type){
    var award = Icon(Icons.add_box,color: Colors.green,);
    var deduct = Icon(Icons.indeterminate_check_box_rounded,color: Colors.red,);

    return (type == '1' ? award : deduct);
  }

}
