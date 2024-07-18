import 'package:flutter/material.dart';
import 'package:people_app/models/leave_balance_tmp.dart';
import 'package:people_app/services/api.services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Leave_Balance_Data extends DataTableSource {
  List<Leave_Balance_Tmp> leave_balance_tmp_s;
  Leave_Balance_Data(this.leave_balance_tmp_s);

  bool get isRowCountApproximate => false;
  int get rowCount => leave_balance_tmp_s.length;
  int get selectedRowCount => 0;
  double total=0;

  late SharedPreferences sharedPreferences;
  //final columns = ['leave_Type_Name', 'total_Leave_Entitlement', 'total_Leave', 'leave_Balance'];
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(leave_balance_tmp_s[index].leave_Type_Name.toString())),
      DataCell(Text(leave_balance_tmp_s[index].total_Leave_Entitlement.toString())),
      DataCell(Text(leave_balance_tmp_s[index].total_Leave.toString())),
      DataCell(Text(leave_balance_tmp_s[index].leave_Balance.toString())),
    ]);
  }

  List<DataRow> getRows(List<Leave_Balance_Tmp> users) => users.map((Leave_Balance_Tmp leave_balance_tmp_s) {
    final cells = [
      leave_balance_tmp_s.leave_Type_Name,
      leave_balance_tmp_s.total_Leave_Entitlement,
      leave_balance_tmp_s.total_Leave,
      leave_balance_tmp_s.leave_Balance,
    ];

    return DataRow(cells: getCells(cells));
  }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();

}