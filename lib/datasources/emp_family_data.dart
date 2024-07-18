import 'package:flutter/material.dart';
import 'package:people_app/models/emp_family_user_req.dart';
import 'package:people_app/services/api.services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Emp_Family_Data extends DataTableSource {
  List<Emp_Family_User_Req> _emp_family_user_req;
  Emp_Family_Data(this._emp_family_user_req);

  bool get isRowCountApproximate => false;
  int get rowCount => _emp_family_user_req.length;
  int get selectedRowCount => 0;
  double total=0;

  late SharedPreferences sharedPreferences;
  //final columns = ['Name', 'Occupation', 'Age', 'Expire', 'Tax', 'Edit', 'Delete'];
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_emp_family_user_req[index].name.toString())),
      DataCell(Text(_emp_family_user_req[index].occupation.toString())),
      DataCell(Text(_emp_family_user_req[index].age.toString())),
      DataCell(Text(_emp_family_user_req[index].expire.toString())),
      DataCell(Text(_emp_family_user_req[index].tax_Allowance.toString())),

      DataCell(IconButton(
        icon: Icon(Icons.edit),
        onPressed: () async {
          int vId = int.parse(_emp_family_user_req[index].tran_ID.toString());
          print('vId : ' + vId.toString());
          sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setInt('tran_ID_Family', vId);
        },)),
      DataCell(IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {

          int vTranID = _emp_family_user_req[index].tran_ID as int;
          var deleteResponse = await APIServices.deleteEmpFamily(vTranID);

          sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setInt('tran_ID_Family', 0);
        },)),
    ]);
  }

  List<DataRow> getRows(List<Emp_Family_User_Req> users) => users.map((Emp_Family_User_Req _emp_families) {
    final cells = [
      _emp_families.name,
      _emp_families.occupation,
      _emp_families.age,
      _emp_families.expire,
      _emp_families.tax_Allowance,
    ];

    return DataRow(cells: getCells(cells));
  }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();

}