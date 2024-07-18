import 'dart:convert' as convert;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:people_app/models/emp_login.dart';
import 'package:people_app/models/loginrequest.dart';
import 'package:people_app/models/attd_checkinout.dart';
import 'package:people_app/models/leave_balance_tmp.dart';
import 'package:people_app/models/leave_request_his.dart';
import 'package:people_app/models/leave_type.dart';
import 'package:people_app/models/paysheet.dart';
import 'package:people_app/models/payslip.dart';
import 'package:people_app/models/payslip_detail.dart';
import 'package:people_app/models/Service_Assign.dart';
import 'package:people_app/models/Service_Log.dart';
import 'package:people_app/models/Team.dart';
import 'package:people_app/models/emp_photo.dart';
import 'package:people_app/models/employee_user_req.dart';
import 'package:people_app/models/emp_education_user_req.dart';
import 'package:people_app/models/emp_family_user_req.dart';
import 'package:people_app/models/degree_diploma.dart';
import 'package:people_app/models/edu_type.dart';
import 'package:people_app/models/relationship.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APIServices{
  static String authLogInUrl = '/api/auth';

  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  static Future fetchOfficeCode() async{
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.240:99';
    String officeCodeUrl = '/api/Office_Code';

    return await http.get(Uri.parse(serverIP + officeCodeUrl),headers: header);
  }

  static Future fetchServiceEmpLogIn() async{
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.240:99';

    return await http.get(Uri.parse(serverIP + '/api/Service_Emp'),headers: header);
  }

  static Future fetchServiceAssignEmpLogIn(double ServiceID) async{
    print('fetchServiceAssignEmpLogIn:' + ServiceID.toString());
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';

    return await http.get(Uri.parse(serverIP + '/api/Service_Assign_Emp?serviceID=' + ServiceID.toString()),headers: header);
  }

  static Future fetchEmpLogIn() async{
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String empLogInUrl = '/api/Emp_Login';

    return await http.get(Uri.parse(serverIP + empLogInUrl),headers: header);
  }

  static Future fetchEmpLogInByCode(String code) async{
    //print(empLogInByCodeUrl+code);
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String empLogInByCodeUrl = '/api/Emp_Login_bycode';

    return await http.get(Uri.parse(serverIP + empLogInByCodeUrl + '/' + code),headers: header);
  }

  static Future fetchEmpLogInByID(double id) async{
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String empLogInUrl = '/api/Emp_Login';

    return await http.get(Uri.parse(serverIP + empLogInUrl + '/' + id.toString()),headers: header);
  }

  static Future<bool> postEmpLogIn(Emp_Login emp_login) async{
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String empLogInUrl = '/api/Emp_Login';

    var myEmp = emp_login.toMap();
    var EmpBody = json.encode(myEmp);

    var res = await http.post(Uri.parse(serverIP + empLogInUrl),headers: header,body: EmpBody);

    return Future.value(res.statusCode==200?true:false);
  }

  static Future<bool> deleteEmpLogIn(double id) async{
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String empLogInUrl = '/api/Emp_Login';

    var res = await http.delete(Uri.parse(serverIP + empLogInUrl + '?Id=' + id.toString()),headers: header);

    return Future.value(res.statusCode==200?true:false);
  }

  static Future<bool> fetchAuthLogIn(String userName, String password) async{
    //var res = await http.delete(authLogInUrl + userName + '/' + password,headers: header);
    //print('check start:');
    //print('userName');
    //print(userName);
    //print('password');
    //print(password);

    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';

    /*
    final res = await http.post(Uri.parse('http://103.47.185.237:99/api/auth'),
        body: LoginRequest(userName: userName, password: password).toJson());
    */
    final res = await http.post( Uri.parse(serverIP + '/api/auth?userName=' + userName + '&password=' + password),headers: header);

    var decoded = false;

    if(res.statusCode == 200) {
      decoded = json.decode(res.body);
      //print(decoded);
      print(res.body.toString());
      //decoded = true;
    }

    return Future.value(decoded);
  }

  static Future getSystemDailyAttdQR() async{
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';

    return await http.get(Uri.parse(serverIP + '/api/GetSystemDailyAttdQR'),headers: header);
  }

  static Future fetchAttdCheck() async{
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String attdUrl = '/api/Attd_CheckInOut';

    return await http.get(Uri.parse(serverIP + attdUrl),headers: header);
  }

  static Future fetchAttdCheckByEmpIDLogDate(double EmpID, String LogDate) async{
    print('*****fetchAttdCheckByEmpIDLogDate*****');
    print(EmpID);
    print('logDate');
    print(LogDate);

    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';

    return await http.post(Uri.parse(serverIP + '/api/AttdCheck?empID='+EmpID.toString()+'&logDate='+LogDate),headers: header);
  }

  static Future fetchAttdCheckByEmpIDLogDateIO(double EmpID, String LogDate, String InTime, String OutTime) async{
    /*
    print(EmpID);
    print('logDate');
    print(LogDate);
     */
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';

    return await http.get(Uri.parse(serverIP + '/api/Attd_CheckInOut_ByEmpIDDateIO?empID='+EmpID.toString()+'&logDate='+LogDate+'&inTime='+InTime+'&outTime='+OutTime),headers: header);
  }

  static Future fetchAttdCheckByEmpIDMonthYear(double EmpID, String Month, String Year) async{
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';

    return await http.get(Uri.parse(serverIP + '/api/AttdCheckCustom?empID='+EmpID.toString()+'&month='+Month+'&year=' + Year),headers: header);
  }

  static Future fetchAttdCheckCustomTest() async{
    print('fetchAttdCheckCustomTest');

    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';

    return await http.get(Uri.parse(serverIP + '/api/AttdCheckCustomTest'),headers: header);
  }

  static Future<bool> postAttdCheck(Attd_CheckInOut obj) async{
    /*
    var postdata = {
        "id": "6DFA5E06-3B1C-4507-B831-2D84B4137011",
        "subject": "Test",
        "message": "Test",
        "recipients": ["6CA682DD-BC13-40FB-BB31-1971553DE8F6", "763661B9-0378-4F81-8A98-6B5962752D4A"]
    },
    res = await http.post(
        Uri.parse(AuthService().baseUrl + uri),
        body: jsonEncode(postdata),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          'Authorization': 'Bearer ' + value["token"],
        },
    );
     */
    print('postAttdCheck');
    var myObj = obj.toMap();
    print('before 1');
    var ObjBody = json.encode(myObj);
    print('before 2');
    print(ObjBody);

    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String attdUrl = '/api/Attd_CheckInOut';
    print(attdUrl);

    var res = await http.post(Uri.parse(serverIP + attdUrl),headers: header,body: ObjBody);
    //print('after');
    return Future.value(res.statusCode==200?true:false);
  }

  static Future<bool> deleteAttdCheck(double id) async{
    print('attd_checkInOut start deleting!');
    print('id-' + id.toString());
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String attdUrl = '/api/Attd_CheckInOut';

    var res = await http.delete(Uri.parse(serverIP + attdUrl + '?id=' + id.toString()),headers: header);
    return Future.value(res.statusCode==200?true:false);
  }

  static Future postAttdCheckProc(double EmpID, String LogDate) async{
    print('postAttdCheckProc start');
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';

    return await http.post(Uri.parse(serverIP + '/api/Attd_CheckInOut_Proc?EmpID='+EmpID.toString()+'&LogDate=' + LogDate),headers: header);
  }

  static Future<bool> deleteAttdCheckProc(double id) async{
    //print('deleteAttdCheckProc start deleting!');
    //print('id-' + id.toString());
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String attdUrl = '/api/Attd_CheckInOut_Delete_Proc';

    var res = await http.delete(Uri.parse(serverIP + attdUrl + '?id=' + id.toString()),headers: header);
    return Future.value(res.statusCode==200?true:false);
  }

  static Future fetchCheckLeaveRequestByEmpIDLeaveTypeDays(double EmpID, int LeaveType, double Days, String FromDate, String ToDate) async{
    //print('chk fetchCheckLeaveRequestByEmpIDLeaveTypeDays');
    //print('http://103.47.185.237:99/api/Leave_Request_Check?empID='+EmpID.toString()+'&leaveType='+LeaveType.toString() + '&days=' + Days.toString() + '&fromDate=' + FromDate + '&toDate=' + ToDate);

    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';

    return await http.get(Uri.parse(serverIP + '/api/Leave_Request_Check?empID='+EmpID.toString()+'&leaveType='+LeaveType.toString() + '&days=' + Days.toString() + '&fromDate=' + FromDate + '&toDate=' + ToDate),headers: header);
  }

  static Future fetchLeaveRequestByEmpIDMonthYear(double EmpID, String Month, String Year) async{
/*
    print(EmpID);
    print('Month-' + Month);
    print('Year-' + Year);
*/
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';

    return await http.post(Uri.parse(serverIP + '/api/Leave_Request_Custom?empID='+EmpID.toString()+'&month='+Month+'&year=' + Year),headers: header);
  }

  static Future fetchLeaveRequestHis() async{
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String leaveRequestUrl = '/api/Leave_Request_His';

    return await http.get(Uri.parse(serverIP + leaveRequestUrl),headers: header);
  }

  static Future<bool> postLeaveRequestHis(Leave_Request_His obj) async{
    var myObj = obj.toMap();
    var ObjBody = json.encode(myObj);
    //print('postLeaveRequestHis');
    //print(ObjBody.toString());

    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String leaveRequestUrl = '/api/Leave_Request_His';

    print(serverIP + leaveRequestUrl);
    print(ObjBody.toString());

    var res = await http.post(Uri.parse(serverIP + leaveRequestUrl),headers: header,body: ObjBody);

    return Future.value(res.statusCode==200?true:false);
  }

  static Future<bool> deleteLeaveRequestHis(double id) async{
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String leaveRequestUrl = '/api/Leave_Request_His';

    var res = await http.delete(Uri.parse(serverIP + leaveRequestUrl + '?id=' + id.toString()),headers: header);

    return Future.value(res.statusCode==200?true:false);
  }

  static Future fetchLeaveType() async{
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String leaveTypeUrl = '/api/Leave_Type';

    return await http.get(Uri.parse(serverIP + leaveTypeUrl),headers: header);
  }

  static Future fetchLeaveBalanceByEmpIDYear(double EmpID, int Year) async{
/*
    print('fetchLeaveBalanceByEmpIDYear');
    print(EmpID.toString());
    print(Year.toString());

    final res = await http.post(Uri.parse('http://103.47.185.237:99/api/Leave_Balance_Custom?empID='+EmpID.toString()+'&year='+Year.toString()));

    String retStr = 'fail';

    //print(res.body.toString());

    if(res.statusCode == 200) {
      retStr = json.decode(res.body);
    }

    print(retStr);
    print('-------------------------------------');

    return retStr;
*/
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';

    return await http.get(Uri.parse(serverIP + '/api/Leave_Balance_Custom?empID='+EmpID.toString()+'&year='+Year.toString()),headers: header);
  }

  static Future fetchLeaveBalanceByEmpID(double EmpID) async{
/*
    print(EmpID);
    print('Month-' + Month);
    print('Year-' + Year);
*/
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';

    return await http.post(Uri.parse(serverIP + '/api/Leave_Balance_Custom?empID='+EmpID.toString()),headers: header);
  }

  static Future fetchLeaveBalanceTmp() async{
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String leaveBalanceUrl = '/api/Leave_Balance_Tmp';

    return await http.get(Uri.parse(serverIP + leaveBalanceUrl),headers: header);
  }

  static Future fetchLeaveBalanceTmpByEmpID(double Id) async{
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String leaveBalanceUrl = '/api/Leave_Balance_Tmp';

    return await http.get(Uri.parse(serverIP + leaveBalanceUrl + "/" + Id.toString()),headers: header);
  }

  static Future fetchPaySheet() async{
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String paySheetUrl = '/api/PaySheet';

    return await http.get(Uri.parse(serverIP + paySheetUrl),headers: header);
  }

  static Future fetchPaySheetYearByEmpID(double EmpID) async{
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';

    return await http.get(Uri.parse(serverIP + '/api/PaySheetYearByEmpID?EmpID=' + EmpID.toString()),headers: header);
  }

  static Future fetchPaySheetByEmpIDMonthYear(double EmpID, String Month, String Year) async{
    print('fetchPaySheetByEmpIDMonthYear');
    print('EmpID-' + EmpID.toString());
    print('Month-' + Month);
    print('Year-' + Year);

    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';

    return await http.post(Uri.parse(serverIP + '/api/PaySheetByEmpIDMonthYear?empID='+EmpID.toString()+'&month='+Month+'&year=' + Year),headers: header);
  }

  static Future fetchPaySlipDetailBySheetIDEmpID(double SheetID, double EmpID) async{
/*
    print('SheetID-' + SheetID);
    print('EmpID-' + EmpID);
*/
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';

    return await http.post(Uri.parse(serverIP + '/api/PaySlipDetailBySheetIDEmpID?sheetID='+SheetID.toString()+'&empID='+EmpID.toString()),headers: header);
  }

  static Future fetchPaySlip() async{
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String paySlipUrl = '/api/PaySlip';

    return await http.get(Uri.parse(serverIP + paySlipUrl),headers: header);
  }

  static Future fetchPaySlipDetail() async{
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String paySlipDetailUrl = '/api/PaySlipDetail';

    return await http.get(Uri.parse(serverIP + paySlipDetailUrl),headers: header);
  }

  static Future fetchServiceAssign() async{
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String serviceAssignUrl = '/api/Service_Assign';

    return await http.get(Uri.parse(serverIP + serviceAssignUrl),headers: header);
  }

  static Future<bool> postServiceAssign(Service_Assign obj) async{
    print('postServiceAssign!!');
    var myObj = obj.toMap();
    var ObjBody = json.encode(myObj);
    print(ObjBody);

    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String serviceAssignUrl = '/api/Service_Assign';

    var res = await http.post(Uri.parse(serverIP + serviceAssignUrl),headers: header,body: ObjBody);

    return Future.value(res.statusCode==200?true:false);
  }

  static Future<bool>

  deleteServiceAssign(double id) async{
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String serviceAssignUrl = '/api/Service_Assign';

    var res = await http.delete(Uri.parse(serverIP + serviceAssignUrl + '?id=' + id.toString()),headers: header);

    return Future.value(res.statusCode==200?true:false);
  }

  static Future fetchServiceLog() async{
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String serviceLogUrl = '/api/Service_Log';

    return await http.get(Uri.parse(serverIP + serviceLogUrl),headers: header);
  }

  static Future fetchServiceLogByEmpIDProductClientDespTarget(double EmpID, String Product, String Client, String Description, String Target) async{
    print('fetchServiceLogByEmpIDProductClientDespTarget');
    print('EmpID-' + EmpID.toString());

    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';

    return await http.post(Uri.parse(serverIP + '/api/Service_Log_Retrieve?EmpID='+EmpID.toString()+'&product='+Product+'&client=' + Client + '&description=' + Description + '&target=' + Target),headers: header);
  }

  static Future fetchServiceLogByEmpIDMonthYear(double EmpID, String Month, String Year) async{
    print('fetchPaySheetByEmpIDMonthYear');
    print('EmpID-' + EmpID.toString());
    print('Month-' + Month);
    print('Year-' + Year);

    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';

    return await http.post(Uri.parse(serverIP + '/api/Service_Log_Custom?EmpID='+EmpID.toString()+'&month='+Month+'&year=' + Year),headers: header);
  }

  static Future<bool> postServiceLog(Service_Log obj) async{
    var myObj = obj.toMap();
    var ObjBody = json.encode(myObj);

    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String serviceLogUrl = '/api/Service_Log';

    print(serverIP + serviceLogUrl);
    print(ObjBody.toString());

    var res = await http.post(Uri.parse(serverIP + serviceLogUrl),headers: header,body: ObjBody);

    return Future.value(res.statusCode==200?true:false);
  }

  static Future<bool> deleteServiceLog(double id) async{
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String serviceLogUrl = '/api/Service_Log';

    var res = await http.delete(Uri.parse(serverIP + serviceLogUrl + '?id=' + id.toString()),headers: header);

    return Future.value(res.statusCode==200?true:false);
  }

  static Future fetchTeam() async{
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String teamUrl = '/api/Team';

    return await http.get(Uri.parse(serverIP + teamUrl),headers: header);
  }

  static Future fetchUserReq(double EmpID) async{
    print('fetchUserReq start');
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';

    return await http.post(Uri.parse(serverIP + '/api/User_Req?EmpID='+EmpID.toString()),headers: header);
  }

  static Future fetchEmpPhoto(double id) async{
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String empPhotoUrl = '/api/emp_photo';

    return await http.get(Uri.parse(serverIP + empPhotoUrl + '/' + id.toString()),headers: header);
  }

  static Future<bool> postEmpPhoto(Emp_Photo obj) async{
    var myObj = obj.toMap();
    var ObjBody = json.encode(myObj);

    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String empPhotoUrl = '/api/emp_photo';

    var res = await http.post(Uri.parse(serverIP + empPhotoUrl),headers: header,body: ObjBody);

    return Future.value(res.statusCode==200?true:false);
  }

  static Future<bool> deleteEmpPhoto(double id) async{
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String empPhotoUrl = '/api/emp_photo';

    var res = await http.delete(Uri.parse(serverIP + empPhotoUrl + '?id=' + id.toString()),headers: header);

    return Future.value(res.statusCode==200?true:false);
  }

  static Future fetchEmployeeUserReq(double id) async{
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String employeeUserReqUrl = '/api/employee_user_req';

    return await http.get(Uri.parse(serverIP + employeeUserReqUrl + '/' + id.toString()),headers: header);
  }

  static Future<bool> postEmployeeUserReq(Employee_User_Req obj) async{
    var myObj = obj.toMap();
    var ObjBody = json.encode(myObj);

    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String employeeUserReqUrl = '/api/employee_user_req';

    print(serverIP + employeeUserReqUrl);
    print(ObjBody);

    var res = await http.post(Uri.parse(serverIP + employeeUserReqUrl),headers: header,body: ObjBody);

    return Future.value(res.statusCode==200?true:false);
  }

  static Future<bool> deleteEmployeeUserReq(double id) async{
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String employeeUserReqUrl = '/api/employee_user_req';

    var res = await http.delete(Uri.parse(serverIP + employeeUserReqUrl + '?id=' + id.toString()),headers: header);

    return Future.value(res.statusCode==200?true:false);
  }

  static Future fetchEmpEducation(double id) async{
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String empEducationUrl = '/api/emp_education_user_req';

    return await http.get(Uri.parse(serverIP + empEducationUrl + '/' + id.toString()),headers: header);
  }

  static Future<bool> postEmpEducation(Emp_Education_User_Req obj) async{
    var myObj = obj.toMap();
    var ObjBody = json.encode(myObj);

    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String empEducationUrl = '/api/emp_education_user_req';

    print(serverIP + empEducationUrl);
    print(ObjBody.toString());
    var res = await http.post(Uri.parse(serverIP + empEducationUrl),headers: header,body: ObjBody);

    return Future.value(res.statusCode==200?true:false);
  }

  static Future postEmpEducationCustom(double EmpID) async{
    print('postEmpEducationCustom start');
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';

    return await http.post(Uri.parse(serverIP + '/api/emp_education_user_req_custom?EmpID='+EmpID.toString()),headers: header);
  }

  static Future<bool> deleteEmpEducation(int id) async{
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String empEducationUrl = '/api/emp_education_user_req';

    print(serverIP + empEducationUrl + '?id=' + id.toString());

    var res = await http.delete(Uri.parse(serverIP + empEducationUrl + '?id=' + id.toString()),headers: header);

    return Future.value(res.statusCode==200?true:false);
  }

  static Future fetchEmpFamily(double id) async{
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String empFamilyUrl = '/api/emp_family_user_req';

    return await http.get(Uri.parse(serverIP + empFamilyUrl + '/' + id.toString()),headers: header);
  }

  static Future<bool> postEmpFamily(Emp_Family_User_Req obj) async{
    print('postEmpFamily');
    var myObj = obj.toMap();
    var ObjBody = json.encode(myObj);

    print(ObjBody.toString());

    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String empFamilyUrl = '/api/emp_family_user_req';

    print(serverIP + empFamilyUrl);
    print(ObjBody.toString());

    var res = await http.post(Uri.parse(serverIP + empFamilyUrl),headers: header,body: ObjBody);

    return Future.value(res.statusCode==200?true:false);
  }

  static Future postEmpFamilyCustom(double EmpID) async{
    print('fetchUserReq start');
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';

    return await http.post(Uri.parse(serverIP + '/api/emp_family_user_req_custom?EmpID='+EmpID.toString()),headers: header);
  }

  static Future<bool> deleteEmpFamily(int id) async{
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String empFamilyUrl = '/api/emp_family_user_req';

    var res = await http.delete(Uri.parse(serverIP + empFamilyUrl + '?id=' + id.toString()),headers: header);

    return Future.value(res.statusCode==200?true:false);
  }

  static Future fetchDegree() async{
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String degreeUrl = '/api/degree_diploma';

    return await http.get(Uri.parse(serverIP + degreeUrl),headers: header);
  }

  static Future fetchEduType() async{
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String eduTypeUrl = '/api/tedu_type';

    return await http.get(Uri.parse(serverIP + eduTypeUrl),headers: header);
  }

  static Future fetchRelation() async{
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.237:99';
    String relationUrl = '/api/relationship';

    return await http.get(Uri.parse(serverIP + relationUrl),headers: header);
  }


}