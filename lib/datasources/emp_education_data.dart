import 'package:flutter/material.dart';
import 'package:people_app/models/emp_education_user_req.dart';
import 'package:people_app/services/api.services.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setInt('tran_ID_Education', vId);
        },)),
      DataCell(IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {

          int vTranID = _emp_education_user_req[index].tran_ID as int;
          var deleteResponse = await APIServices.deleteEmpEducation(vTranID);

          sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setInt('tran_ID_Education', 0);
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