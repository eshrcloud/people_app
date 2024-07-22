import 'dart:async';
import 'package:people_app/models/emp_login.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:people_app/ui/leaverequestdetailscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:people_app/models/user.dart';
import 'package:people_app/models/Office_Code.dart';
import 'package:people_app/models/param_output.dart';
import 'package:people_app/models/attd_checkinout.dart';
import 'package:people_app/models/leave_request_his.dart';
import 'package:people_app/services/api.services.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class TodayScreen extends StatefulWidget {
  static const routeName = '/todayscreen';
  const TodayScreen({Key? key}) : super(key: key);

  @override
  _TodayScreenState createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  late SharedPreferences sharedPreferences;
  late Attd_CheckInOut attd_checkInOut;
  final connectionIssueSnackBar = SnackBar(content: Text("404, Connection Issue !"));

  String vNote = "";
  String intime_Remark = "";
  String outtime_Remark = "";

  List<Office_Code>? officeLists;
  List<Attd_CheckInOut>? attd_checkinouts;

  double screenHeight = 0;
  double screenWidth = 0;

  String active_intime_Remark = "";
  String active_outtime_Remark = "";

  double active_tranId=0;
  String active_checkIn = "--/--";
  int active_checkInMin = 0;
  String active_checkOut = "--/--";
  int active_checkOutMin = 0;

  double tranId = 0;
  String checkIn = "--/--";
  String checkOut = "--/--";
  int checkInMin = 0;
  int checkOutMin = 0;
  String location = " ";
  String scanResult = " ";
  String officeCode = " ";

  bool qR_Pass = false;

  String vTodayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateTime vToday = DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));

  Color primary = const Color(0xFF0288D1);

  @override
  void initState() {
    print('initState Start!');
    super.initState();
    _getRecord();
    _getOfficeCode();
    print('initState Finish!');
  }

  void _getOfficeCode() async {
    /*
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection("Attributes").doc("Office1").get();
    setState(() {
      officeCode = snap['code'];
    });
     */
    await APIServices.fetchOfficeCode().then((response) async {
      //print('fetchOfficeCode start');
      //Iterable list=json.decode("[" + response.body + "]");
      Iterable list=json.decode(response.body);
      //print(list);
      List<Office_Code>? officeList;
      //print('fetchOfficeCode end');
      officeList = list.map((model)=> Office_Code.fromObject(model)).toList();

      officeLists = officeList;

      if (officeList.isNotEmpty) {
        officeList!.forEach((e) {
          print(e.officeCode.toString());
          setState(() {
            officeCode = e.officeCode.toString();
          });
        });
      }

    });
  }

  String _calculate_key() {
    Object? _value = 2;
    num _key = 0;
    String _strkey = '';

    String _date = DateTime.now().year.toString() + '-' +
        (DateTime.now().month.toString().length == 1 ? '0' + DateTime.now().month.toString() : DateTime.now().month.toString()) + '-' +
        (DateTime.now().day.toString().length == 1 ? '0' + DateTime.now().day.toString() : DateTime.now().day.toString());

    String _stryear = DateTime.now().year.toString();
    String _strmonth =DateTime.now().month.toString();
    String _strday = DateTime.now().day.toString();

    if (_strmonth.length == 1)
    {
      _strmonth = '0' + _strmonth;
    }
    if (_strday.length == 1)
    {
      _strday = '0' + _strday;
    }
    _date = _stryear + '-' + _strmonth + '-' + _strday;

    String _calDateStr;
    if (vTodayStr == '')
    {
      _calDateStr = _date + ' 00:00:00.000';
    }
    else
    {
      _calDateStr = vTodayStr + ' 00:00:00.000';
    }
    _strkey = _calDateStr;

    final _calDate = DateTime.parse(_calDateStr);
    final _Y = _calDate.year as int;
    final _M = _calDate.month as int;
    final _D = _calDate.day as int;
    final _YMD=_Y.toString() + _M.toString() + _D.toString() ;
    final _Tmp = num.parse(_YMD) / (_Y - _M - _D);

    if (_value == 1){
      if ((_Tmp.round() - _Tmp <= 0.5) && (_Tmp.round() - _Tmp > 0)) {
        final _Tmp2 = _Tmp.round() - 1;
        _key = _Tmp2;
      }
      else{
        final _Tmp2 = _Tmp.round();
        _key = _Tmp2;
      }
    }
    else if (_value == 2) {
      if ((_Tmp.round() - _Tmp <= 0.5) && (_Tmp.round() - _Tmp > 0)) {
        final _Tmp2 = (_Tmp.round() - 1) * (_D + _M);
        _key = _Tmp2;
      }
      else {
        final _Tmp2 = _Tmp.round() * (_D + _M);
        _key = _Tmp2;
      }
    }
    else if (_value == 3) {
      if ((_Tmp.round() - _Tmp <= 0.5) && (_Tmp.round() - _Tmp > 0)) {
        final _Tmp2 = _Tmp.round() - 1;
        _key = _Tmp2 * _D;
      }
      else{
        final _Tmp2 = _Tmp.round();
        _key = _Tmp2 * _D;
      }
    }

    return _key.toString();
  }

  Future<void> scanQRandCheck() async {
    String result = " ";

    try {
      result = await FlutterBarcodeScanner.scanBarcode(
        "#ffffff",
        "Cancel",
        false,
        ScanMode.QR,
      );
    } catch(e) {
      print("error");
    }

    setState(() {
      scanResult = result;
    });

    bool chkExist = false;
    String _OfficeCode = "";
    String _key = _calculate_key();

    print('getSystemDailyAttdQR');
    await APIServices.getSystemDailyAttdQR().then((response) async {

      print(response.body.toString());
      Iterable list=json.decode(response.body);
      List<Param_Output>? pList;
      pList = list.map((model)=> Param_Output.fromObject(model)).toList();

      if (pList.isNotEmpty) {
        pList!.forEach((ep) {
          print('isNotEmpty 2');
          print(ep.result.toString());
          if (ep.result == '0') { // Not Daily Attd QR
            if (officeLists!.length > 0) {
              officeLists!.forEach((e) {
                if (chkExist == false) {
                  if (scanResult == e.officeCode.toString()) {
                    chkExist = true;
                  }
                }
              });
            }
          }
          else{ // Daily Attd QR

            if (officeLists!.length > 0) {
              officeLists!.forEach((e) {
                if (chkExist == false) {
                  _OfficeCode = e.officeCode.toString();
                  //chkExist = scanResult.contains(_OfficeCode);

                  if (scanResult == _OfficeCode + "-" + _key) {
                    chkExist = true;
                  }
                }
              });
            }

          }
        });
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('connection Issue!'),
              duration: Duration(seconds: 3),
            )
        );
      }
    });

    // for Daily QR
    /*
        _OfficeCode = e.officeCode.toString();
        //chkExist = scanResult.contains(_OfficeCode);

        if (scanResult == _OfficeCode + "-" + _key) {
          chkExist = true;
        }
     */

    // for Only Office QR
    /*
        if (scanResult == e.officeCode.toString()) {
          chkExist = true;
        }
    */

    if(chkExist == true) {
      /*
          if(User.lat != 0) {
        _getLocation();

        QuerySnapshot snap = await FirebaseFirestore.instance
            .collection("Employee")
            .where('id', isEqualTo: User.employeeId)
            .get();

        DocumentSnapshot snap2 = await FirebaseFirestore.instance
            .collection("Employee")
            .doc(snap.docs[0].id)
            .collection("Record")
            .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
            .get();

        try {
          String checkIn = snap2['checkIn'];

          setState(() {
            checkOut = DateFormat('hh:mm').format(DateTime.now());
          });

          await FirebaseFirestore.instance
              .collection("Employee")
              .doc(snap.docs[0].id)
              .collection("Record")
              .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
              .update({
            'date': Timestamp.now(),
            'checkIn': checkIn,
            'checkOut': DateFormat('hh:mm').format(DateTime.now()),
            'checkInLocation': location,
          });
        } catch (e) {
          setState(() {
            checkIn = DateFormat('hh:mm').format(DateTime.now());
          });

          await FirebaseFirestore.instance
              .collection("Employee")
              .doc(snap.docs[0].id)
              .collection("Record")
              .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
              .set({
            'date': Timestamp.now(),
            'checkIn': DateFormat('hh:mm').format(DateTime.now()),
            'checkOut': "--/--",
            'checkOutLocation': location,
          });
        }
      } else {
        Timer(const Duration(seconds: 3), () async {
          _getLocation();

          QuerySnapshot snap = await FirebaseFirestore.instance
              .collection("Employee")
              .where('id', isEqualTo: User.employeeId)
              .get();

          DocumentSnapshot snap2 = await FirebaseFirestore.instance
              .collection("Employee")
              .doc(snap.docs[0].id)
              .collection("Record")
              .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
              .get();

          try {
            String checkIn = snap2['checkIn'];

            setState(() {
              checkOut = DateFormat('hh:mm').format(DateTime.now());
            });

            await FirebaseFirestore.instance
                .collection("Employee")
                .doc(snap.docs[0].id)
                .collection("Record")
                .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                .update({
              'date': Timestamp.now(),
              'checkIn': checkIn,
              'checkOut': DateFormat('hh:mm').format(DateTime.now()),
              'checkInLocation': location,
            });
          } catch (e) {
            setState(() {
              checkIn = DateFormat('hh:mm').format(DateTime.now());
            });

            await FirebaseFirestore.instance
                .collection("Employee")
                .doc(snap.docs[0].id)
                .collection("Record")
                .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                .set({
              'date': Timestamp.now(),
              'checkIn': DateFormat('hh:mm').format(DateTime.now()),
              'checkOut': "--/--",
              'checkOutLocation': location,
            });
          }
        });
      }
       */
      print('start');
      if(User.lat != 0) {
        _getLocation();
        await APIServices.fetchAttdCheckByEmpIDLogDate(User.employeeId, DateFormat('dd MMMM yyyy').format(DateTime.now()).toString()).then((response) async{
          Iterable list=json.decode(response.body);
          List<Attd_CheckInOut>? attdList;
          attdList = list.map((model)=> Attd_CheckInOut.fromObject(model)).toList();

          attdList?.forEach((e) {
            //ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text("fetchAttdCheckByEmpIDLogDate 3")));
            tranId = e.tran_ID;
            checkIn = e.in_TimeStr.toString();
            checkInMin = e.in_Time!;
          });

          if (attdList.length > 0) {
            print('@@@@@@@@@@@@@@@@');
            setState(() {
              checkOut = checkIn != "--/--" ? DateFormat('HH:mm').format(DateTime.now()) : "--/--";

              active_tranId = tranId;
              active_checkIn = checkIn;
              active_checkOut = checkOut;
              active_checkInMin =
              active_checkIn != "--/--" ? hhmmToMinutes(
                  active_checkIn) : 0;
              active_checkOutMin =
              active_checkOut != "--/--" ? hhmmToMinutes(
                  active_checkOut) : 0;
              attd_checkInOut.in_Latitude = User.lat;
              attd_checkInOut.in_Longitude = User.long;

              tranId = active_tranId;
              qR_Pass = true;
              print(tranId.toString());
            });
          }

        });

        if (checkIn != "--/--"){
          print('set attd_checkInOut!');
          print(vToday);
          print(tranId.toString());
          print('CheckOut!!!!!!!!!!!!');

          attd_checkInOut.tran_ID = tranId;
          attd_checkInOut.emp_ID = User.employeeId;
          //attd_checkInOut.log_Date = vToday;
          attd_checkInOut.approvedDateTime = vToday;
          attd_checkInOut.in_TimeStr = checkIn;
          attd_checkInOut.in_Time = checkInMin;
          attd_checkInOut.out_TimeStr = DateFormat('HH:mm').format(DateTime.now());
          attd_checkInOut.out_Time = hhmmToMinutes(attd_checkInOut.out_TimeStr.toString());
          attd_checkInOut.out_Latitude = User.lat;
          attd_checkInOut.out_Longitude = User.long;
          attd_checkInOut.qR_Pass = true;
          print('attd_checkInOut start posting!');
          //ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text("set attd_checkInOut! 2")));

          var saveResponse = await APIServices.postAttdCheck(attd_checkInOut);

          //_getRecord();

          print(saveResponse);
          //ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text("set attd_checkInOut! 3")));
          if (saveResponse == true) {
            //setState(() { });
            //Navigator.pop(context, true);

            await APIServices.postAttdCheckProc(User.employeeId, vTodayStr).then((response) async{  });

          }
          else{
            //setState(() { });
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:Text('connection Issue!'),
                  duration: Duration(seconds: 3),
                )
            );
          }

        }
        else{

          setState(() {
            checkIn = DateFormat('HH:mm').format(DateTime.now());
            checkInMin = hhmmToMinutes(checkIn);

            active_tranId = tranId;
            active_checkIn = checkIn;
            active_checkOut = checkOut;
            active_checkInMin = active_checkIn != "--/--" ? hhmmToMinutes(active_checkIn) : 0;
            active_checkOutMin = active_checkOut != "--/--" ? hhmmToMinutes(active_checkOut) : 0;
            tranId = active_tranId;
            qR_Pass = true;

          });

          print('set attd_checkInOut!');

          print('CheckIn!!!!!!!!!!!!');

          attd_checkInOut.tran_ID = active_tranId != 0 ? active_tranId : 0;
          attd_checkInOut.emp_ID = User.employeeId;
          attd_checkInOut.log_Date = vToday;
          attd_checkInOut.approvedDateTime = vToday;
          attd_checkInOut.in_TimeStr = DateFormat('HH:mm').format(DateTime.now());
          attd_checkInOut.in_Time = hhmmToMinutes(attd_checkInOut.in_TimeStr.toString());
          attd_checkInOut.out_TimeStr = "--/--";
          attd_checkInOut.out_Time = 0;
          attd_checkInOut.in_Latitude = User.lat;
          attd_checkInOut.in_Longitude = User.long;
          attd_checkInOut.qR_Pass = true;

          print('attd_checkInOut start posting!');
          var saveResponse = await APIServices.postAttdCheck(attd_checkInOut);
          print(saveResponse);

          //_getRecord();

          if (saveResponse == true) {
            //setState(() { });
            //Navigator.pop(context, true);
            await APIServices.postAttdCheckProc(User.employeeId, vTodayStr).then((response) async{  });
          }
          else{
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:Text('connection Issue!'),
                  duration: Duration(seconds: 3),
                )
            );
          }

          //key.currentState!.reset();

        }

        //_getRecord();
        print('save!! 3');
      }
      else { // Not Lat
        Timer(const Duration(seconds: 3), () async {
          _getLocation();

          await APIServices.fetchAttdCheck().then((response) async {
            Iterable list=json.decode(response.body);
            List<Attd_CheckInOut>? attdList;
            attdList = list.map((model)=> Attd_CheckInOut.fromObject(model)).toList();
            Iterable<Attd_CheckInOut> iattdList = attdList.where((e) => e.emp_ID == User.employeeId && e.log_Date == DateFormat('dd MMMM yyyy').format(DateTime.now()).toString());

            iattdList.forEach((e) {
              tranId = e.tran_ID;
              checkIn = e.in_TimeStr.toString();
            });

          });

          if (checkIn != "--/--") {
            setState(() {
              checkOut = checkIn != "--/--" ? DateFormat('HH:mm').format(DateTime.now()) : "--/--";

              active_tranId = tranId;
              active_checkIn = checkIn;
              active_checkOut = checkOut;
              active_checkInMin =
              active_checkIn != "--/--" ? hhmmToMinutes(
                  active_checkIn) : 0;
              active_checkOutMin =
              active_checkOut != "--/--" ? hhmmToMinutes(
                  active_checkOut) : 0;
              attd_checkInOut.in_Latitude = User.lat;
              attd_checkInOut.in_Longitude = User.long;
              qR_Pass = false;
            });

            print('set attd_checkInOut!');
            print('CheckOut Not Lat!!!!!!!!!!!!');

            attd_checkInOut.tran_ID = tranId;
            attd_checkInOut.emp_ID = User.employeeId;
            //attd_checkInOut.log_Date = vToday;
            attd_checkInOut.approvedDateTime = vToday;
            attd_checkInOut.in_TimeStr = checkIn;
            attd_checkInOut.in_Time = hhmmToMinutes(attd_checkInOut.in_TimeStr.toString());
            attd_checkInOut.in_Latitude = User.lat;
            attd_checkInOut.in_Longitude = User.long;
            attd_checkInOut.out_TimeStr = DateFormat('HH:mm').format(DateTime.now());
            attd_checkInOut.out_Time = hhmmToMinutes(attd_checkInOut.out_TimeStr.toString());
            attd_checkInOut.out_Latitude = 0;
            attd_checkInOut.out_Longitude = 0;
            attd_checkInOut.qR_Pass = false;

            print('attd_checkInOut start posting!');
            var saveResponse = await APIServices.postAttdCheck(attd_checkInOut);

            //_getRecord();
            print(saveResponse);
            if (saveResponse == true) {
              //setState(() { });
              //Navigator.pop(context, true);
              await APIServices.postAttdCheckProc(User.employeeId, vTodayStr).then((response) async{  });
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
          else {

            setState(() {
              checkIn = DateFormat('HH:mm').format(DateTime.now());

              active_tranId = tranId;
              active_checkIn = checkIn;
              active_checkOut = checkOut;
              active_checkInMin = active_checkIn != "--/--" ? hhmmToMinutes(active_checkIn) : 0;
              active_checkOutMin = active_checkOut != "--/--" ? hhmmToMinutes(active_checkOut) : 0;
              qR_Pass = false;

            });

            print('set attd_checkInOut!');
            print('CheckIn Not Lat!!!!!!!!!!!!');
            attd_checkInOut.tran_ID = active_tranId != 0 ? active_tranId : 0;
            attd_checkInOut.emp_ID = User.employeeId;
            attd_checkInOut.log_Date = vToday;
            attd_checkInOut.approvedDateTime = vToday;
            attd_checkInOut.in_TimeStr = DateFormat('HH:mm').format(DateTime.now());
            attd_checkInOut.in_Time = hhmmToMinutes(attd_checkInOut.in_TimeStr.toString());
            attd_checkInOut.in_Latitude = User.lat;
            attd_checkInOut.in_Longitude = User.long;
            attd_checkInOut.out_TimeStr = "--/--";
            attd_checkInOut.out_Time = 0;
            attd_checkInOut.out_Latitude = 0;
            attd_checkInOut.out_Longitude = 0;
            attd_checkInOut.qR_Pass = false;

            print('attd_checkInOut start posting!');
            var saveResponse = await APIServices.postAttdCheck(attd_checkInOut);

            //_getRecord();
            print(saveResponse);
            if (saveResponse == true) {
              //setState(() { });
              //Navigator.pop(context, true);
              await APIServices.postAttdCheckProc(User.employeeId, vTodayStr).then((response) async{  });
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

          //_getRecord();

        });
      }
    }
  }

  void _getLocation() async {
    List<Placemark> placemark = await placemarkFromCoordinates(User.lat, User.long);

    setState(() {
      location = "${placemark[0].street}, ${placemark[0].administrativeArea}, ${placemark[0].postalCode}, ${placemark[0].country}";
    });
  }

  @override
  void _getRecord() async {
    try {
      await APIServices.fetchAttdCheckByEmpIDLogDate(User.employeeId,DateFormat('dd-MMM-yyyy').format(DateTime.now()).toString()).then((response) async{
        Iterable list=json.decode(response.body);
        List<Attd_CheckInOut>? attdList;
        attdList = list.map((model)=> Attd_CheckInOut.fromObject(model)).toList();

        if (attdList.isNotEmpty) {
          print('isNotEmpty 1');
          attd_checkinouts = attdList!;
          attdList!.forEach((e) {
            //print('isNotEmpty 2');
            setState(() {
              attd_checkInOut = e;
              checkIn = e.in_TimeStr.toString();
              checkOut = e.out_TimeStr.toString();
              tranId = e.tran_ID;
              qR_Pass = e.qR_Pass!;
              intime_Remark = e.intime_Remark.toString();
              outtime_Remark = e.outtime_Remark.toString();
            });
          });
        }
        else{
          print('isEmpty 1');
          attd_checkInOut = new Attd_CheckInOut.WithId(m_tran_ID: 0, m_emp_ID: 0, m_log_Date: DateTime.now(), m_in_Time: 0, m_in_TimeStr: '', m_out_Time: 0, m_out_TimeStr: '', m_working_Hr: 0, m_working_HrStr: '', m_intime_Remark: '', m_outtime_Remark: '', m_in_Latitude: 0, m_in_Longitude: 0, m_out_Latitude: 0, m_out_Longitude: 0, m_notInRange: true, m_approved: false, m_approvedBy: 0, m_approvedDateTime: null, m_imp_Copy: false, m_qR_Pass: false, m_editUserID: User.employeeId, m_editDateTime: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now())));
          attdList?.add(attd_checkInOut as Attd_CheckInOut);
          print('set attd_checkInOut! _getRecord!!');
          print(attdList.toString());
          print('len - ' + attdList.length.toString());
          attd_checkinouts = attdList!;

          if (this.mounted) {
            setState(() {
              checkIn = "--/--";
              checkOut = "--/--";
              tranId = 0;
              attd_checkInOut.in_Time = 0;
              attd_checkInOut.in_TimeStr = checkIn;
              attd_checkInOut.out_Time = 0;
              attd_checkInOut.out_TimeStr = checkOut;
              attd_checkInOut.intime_Remark = null;
              attd_checkInOut.outtime_Remark = null;
            });
          }
        }
      });
    } catch(e) {
      setState(() {
        checkIn = "--/--";
        checkOut = "--/--";
        intime_Remark = "";
        outtime_Remark = "";
        tranId = 0;
      });
    }
  }

  int hhmmToMinutes(String hhmm) {
    List<String> time = hhmm.split(':');
    int hours = int.parse(time[0]);
    int minutes = int.parse(time[1]);
    return hours * 60 + minutes;
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildAddShiftFloatingButton(),
            SizedBox(width: 16), // Add some space between the two FABs
            _buildAddLeaveFloatingButton(),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop ,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 32),
                child: Text(
                  "Welcome,",
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: "NexaRegular",
                    fontSize: screenWidth / 20,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  User == null ? "Employee" : User.lastName,
                  style: TextStyle(
                    fontFamily: "NexaBold",
                    fontSize: screenWidth / 18,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 32),
                child: Text(
                  "Today's Status",
                  style: TextStyle(
                    fontFamily: "NexaBold",
                    fontSize: screenWidth / 18,
                  ),
                ),
              ),

              /*
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 32),
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
                            DateFormat('EE\ndd').format(vToday),
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
                            checkIn,
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
                            checkOut,
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
              ),

               */
/*
              SizedBox(
                height: screenHeight / 4,
                child: _buildAttdList(),
              ),

 */
              Container(
                alignment: Alignment.centerLeft,
                height: screenHeight / 4,
                child: ListView.builder(
                  itemCount: (attd_checkinouts!= null) ? attd_checkinouts?.length : 1,
                  itemBuilder: (context, index) {

                    if (attd_checkinouts!= null) {
                      print('ListView.builder *************');
                      //setState(() {
                      tranId = attd_checkinouts![index].tran_ID;

                      checkIn = attd_checkinouts![index].in_TimeStr!.toString();
                      checkOut = attd_checkinouts![index].out_TimeStr!.toString();

                      checkIn = checkIn == "" ? "--/--" : checkIn;
                      checkOut = checkOut == "" ? "--/--" : checkOut;

                      checkInMin = attd_checkinouts![index].in_Time!;
                      checkOutMin = attd_checkinouts![index].out_Time!;

                      intime_Remark = attd_checkinouts![index].intime_Remark.toString();
                      outtime_Remark = attd_checkinouts![index].outtime_Remark.toString();

                      if ((tranId == active_tranId) && (tranId != 0)){
                        print('active_tranId - ' + active_tranId.toString());
                        checkIn = active_checkIn;
                        checkInMin = active_checkInMin;
                        checkOut = active_checkOut;
                        checkOutMin = active_checkOutMin;
                        intime_Remark = active_intime_Remark;
                        outtime_Remark = active_outtime_Remark;
                      }
                      //});
                    }
                    else{
                      //setState(() {
                      tranId = 0;

                      checkIn = "--/--";
                      checkOut = "--/--";

                      checkInMin = 0;
                      checkOutMin = 0;

                      intime_Remark = "";
                      outtime_Remark = "";
                      //});
                    }

                    return attd_checkinouts!= null ? Container(
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
                                /*
                              child: Text(
                                DateFormat('EE\ndd').format(attd_checkinouts![index].log_Date!),
                                style: TextStyle(
                                  fontFamily: "NexaBold",
                                  fontSize: screenWidth / 18,
                                  color: Colors.white,
                                ),
                              ),
                             */
                                child: GestureDetector(
                                  child: Text(
                                    DateFormat('EE\ndd').format(attd_checkinouts![index].log_Date!),
                                    style: TextStyle(
                                      fontFamily: "NexaBold",
                                      fontSize: screenWidth / 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onDoubleTap: () async{
                                    //initState();
                                    _getRecord();
                                  },
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
                                    fontSize: screenWidth / 22,
                                    color: Colors.black54,
                                  ),
                                ),
                                Text(
                                  checkIn,
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
                                    fontSize: screenWidth / 22,
                                    color: Colors.black54,
                                  ),
                                ),
                                Text(
                                  checkOut,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                ElevatedButton(
                                  child: Icon(Icons.edit),
                                  onPressed: () async {
                                    //editAttdCheckOut(attd_checkinouts![index].tran_ID);

                                    print('set attd_checkInOut!');
                                    attd_checkInOut.tran_ID =
                                        attd_checkinouts![index].tran_ID;
                                    attd_checkInOut.emp_ID =
                                        attd_checkinouts![index].emp_ID;
                                    //attd_checkInOut.log_Date = attd_checkinouts![index].log_Date;
                                    attd_checkInOut.approvedDateTime =
                                        attd_checkinouts![index].approvedDateTime;
                                    attd_checkInOut.in_TimeStr =
                                        attd_checkinouts![index].in_TimeStr;
                                    attd_checkInOut.in_Time =
                                        attd_checkinouts![index].in_Time;
                                    attd_checkInOut.in_Latitude =
                                        attd_checkinouts![index].in_Latitude;
                                    attd_checkInOut.in_Longitude =
                                        attd_checkinouts![index].in_Longitude;
                                    attd_checkInOut.out_TimeStr = "--/--";
                                    attd_checkInOut.out_Time = 0;
                                    attd_checkInOut.out_Latitude = 0;
                                    attd_checkInOut.out_Longitude = 0;

                                    tranId = attd_checkInOut.tran_ID;
                                    checkIn = attd_checkInOut.in_TimeStr.toString();
                                    checkOut = attd_checkInOut.out_TimeStr.toString();
                                    checkInMin = int.parse(attd_checkInOut.in_Time.toString());
                                    checkOutMin = int.parse(attd_checkInOut.out_Time.toString());

                                    active_tranId = tranId;
                                    active_checkIn = checkIn;
                                    active_checkOut = checkOut;
                                    active_checkInMin = checkInMin;
                                    active_checkOutMin = checkOutMin;

                                    print('attd_checkInOut start editing!');
                                    var saveResponse = await APIServices.postAttdCheck(
                                        attd_checkInOut);
                                    print(saveResponse);
                                    if (saveResponse == true) {
                                      //Navigator.pop(context, true);
                                      _getRecord();
                                    }
                                    else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('connection Issue!'),
                                            duration: Duration(seconds: 3),
                                          )
                                      );
                                    }
                                  },
                                ),

                                ElevatedButton(
                                  child: Icon(Icons.delete),
                                  onPressed: () async {
                                    //deleteAttdCheck(attd_checkinouts![index].tran_ID);

                                    print('delete 1');
                                    print(attd_checkinouts![index].tran_ID.toString());
                                    var dResponse = await APIServices.deleteAttdCheck(
                                        attd_checkinouts![index].tran_ID);
                                    print('delete 2');
                                    print(dResponse);
                                    if (dResponse == true) {
                                      //Navigator.pop(context, true);
                                      _getRecord();
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
                    )
                        : Container(
                      margin: const EdgeInsets.only(top: 12, bottom: 32),
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
                                  DateFormat('EE\ndd').format(vToday),
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
                                  checkIn,
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
                                  checkOut,
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
                    );

                  },
                ),
              ),

              Container(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      text: DateTime.now().day.toString(),
                      style: TextStyle(
                        color: primary,
                        fontSize: screenWidth / 18,
                        fontFamily: "NexaBold",
                      ),
                      children: [
                        TextSpan(
                          text: DateFormat(' MMMM yyyy').format(DateTime.now()),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth / 20,
                            fontFamily: "NexaBold",
                          ),
                        ),
                      ],
                    ),
                  )
              ),
              StreamBuilder(
                stream: Stream.periodic(const Duration(seconds: 1)),
                builder: (context, snapshot) {
                  return Container(

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:<Widget> [
                        Expanded(
                          child: Text(
                            DateFormat('hh:mm:ss a').format(DateTime.now()),
                            style: TextStyle(
                              fontFamily: "NexaRegular",
                              fontSize: screenWidth / 20,
                              color: Colors.black54,
                            ),
                          ),
                        ),

                        Expanded(
                          //alignment: Alignment.center,
                          //margin: const EdgeInsets.only(top: 32),
                          child: Align(
                              //padding: const EdgeInsets.symmetric(vertical: 0.0),
                              alignment: Alignment.centerRight,
                              child: IconButton(tooltip: 'Note',icon: Icon(Icons.note_alt_outlined),onPressed: () async{
                                await showDialog(
                                  context: context,
                                  builder: (BuildContext context){
                                    return Note_Add();
                                  },
                                );
                                setState(() {});
                              },)
                          ),

                        ),

                      ],
                    ),

                  );
                  return Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      DateFormat('hh:mm:ss a').format(DateTime.now()),
                      style: TextStyle(
                        fontFamily: "NexaRegular",
                        fontSize: screenWidth / 20,
                        color: Colors.black54,
                      ),
                    ),
                  );
                },
              ),
              checkOut == "--/--" ? Container(
                margin: const EdgeInsets.only(top: 24, bottom: 12),
                child: Builder(
                  builder: (context) {
                    final GlobalKey<SlideActionState> key = GlobalKey();

                    return SlideAction(

                      text: checkIn == "--/--" ? "Slide to Check In" : "Slide to Check Out",
                      //text: checkInMin == 0 ? "Slide to Check In" : "Slide to Check Out",
                      textStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: screenWidth / 20,
                        fontFamily: "NexaRegular",
                      ),
                      outerColor: Colors.white,
                      innerColor: primary,
                      key: key,
                      onSubmit: () async {
                        print('start');

                        sharedPreferences = await SharedPreferences.getInstance();
                        if(sharedPreferences.getString('note') != null) {
                          setState(() {
                            vNote = sharedPreferences.getString('note')!;
                          });
                        }

                        if(User.lat != 0) {
                          _getLocation();
/*
                        QuerySnapshot snap = await FirebaseFirestore.instance
                            .collection("Employee")
                            .where('id', isEqualTo: User.employeeId)
                            .get();

                        DocumentSnapshot snap2 = await FirebaseFirestore.instance
                            .collection("Employee")
                            .doc(snap.docs[0].id)
                            .collection("Record")
                            .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                            .get();
 */
                          await APIServices.fetchAttdCheckByEmpIDLogDate(User.employeeId, DateFormat('dd MMMM yyyy').format(DateTime.now()).toString()).then((response)async{
                            Iterable list=json.decode(response.body);
                            List<Attd_CheckInOut>? attdList;
                            attdList = list.map((model)=> Attd_CheckInOut.fromObject(model)).toList();

                            //ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text("fetchAttdCheckByEmpIDLogDate 1")));

                            //String checkIn = snap2['checkIn'];

                            //ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text("fetchAttdCheckByEmpIDLogDate 2")));

                            //attd_checkinouts = attdList;

                            attdList?.forEach((e) {
                              //ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text("fetchAttdCheckByEmpIDLogDate 3")));
                              tranId = e.tran_ID;
                              checkIn = e.in_TimeStr.toString();
                              checkInMin = e.in_Time!;
                              intime_Remark = e.intime_Remark.toString();
                              outtime_Remark = e.outtime_Remark.toString();
                            });
/*
                            tranId = int.parse(attdList?.lastWhere((e) => true).tran_ID as String);
                            checkIn = attdList?.lastWhere((e) => true).in_TimeStr as String;
                            checkInMin = int.parse(attdList?.lastWhere((e) => true).in_Time as String);
 */

                            if (attdList.length > 0) {
                              print('@@@@@@@@@@@@@@@@');
                              setState(() {
                                checkOut = checkIn != "--/--" ? DateFormat('HH:mm').format(DateTime.now()) : "--/--";

                                active_tranId = tranId;
                                active_checkIn = checkIn;
                                active_checkOut = checkOut;
                                active_checkInMin =
                                active_checkIn != "--/--" ? hhmmToMinutes(
                                    active_checkIn) : 0;
                                active_checkOutMin =
                                active_checkOut != "--/--" ? hhmmToMinutes(
                                    active_checkOut) : 0;

                                active_intime_Remark = intime_Remark;
                                active_outtime_Remark = outtime_Remark;

                                tranId = active_tranId;
                                qR_Pass = false;
                                print(tranId.toString());
                              });
                            }

                          });

                          if (checkIn != "--/--"){
/*
                          await FirebaseFirestore.instance
                              .collection("Employee")
                              .doc(snap.docs[0].id)
                              .collection("Record")
                              .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                              .update({
                            'date': Timestamp.now(),
                            'checkIn': checkIn,
                            'checkOut': DateFormat('hh:mm').format(DateTime.now()),
                            'checkInLocation': location,
                          });
 */

                            print('set attd_checkInOut!');
                            //ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text("set attd_checkInOut!")));
                            print(vToday);
                            print(tranId.toString());
                            print('CheckOut!!!!!!!!!!!!');

                            outtime_Remark = vNote;

                            attd_checkInOut.tran_ID = tranId;
                            attd_checkInOut.emp_ID = User.employeeId;
                            //attd_checkInOut.log_Date = vToday;
                            attd_checkInOut.approvedDateTime = vToday;
                            attd_checkInOut.in_TimeStr = checkIn;
                            attd_checkInOut.in_Time = checkInMin;
                            attd_checkInOut.out_TimeStr = DateFormat('HH:mm').format(DateTime.now());
                            attd_checkInOut.out_Time = hhmmToMinutes(attd_checkInOut.out_TimeStr.toString());
                            attd_checkInOut.out_Latitude = User.lat;
                            attd_checkInOut.out_Longitude = User.long;
                            attd_checkInOut.qR_Pass = false;
                            attd_checkInOut.intime_Remark = intime_Remark;
                            attd_checkInOut.outtime_Remark = outtime_Remark;
                            print('attd_checkInOut start posting!');
                            //ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text("set attd_checkInOut! 2")));

                            var saveResponse = await APIServices.postAttdCheck(attd_checkInOut);

                            //_getRecord();

                            print(saveResponse);
                            //ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text("set attd_checkInOut! 3")));
                            if (saveResponse == true) {
                              //setState(() { });
                              //Navigator.pop(context, true);
                              await APIServices.postAttdCheckProc(User.employeeId, vTodayStr).then((response) async{  });
                            }
                            else{
                              //setState(() { });
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:Text('connection Issue!'),
                                    duration: Duration(seconds: 3),
                                  )
                              );
                            }

                            //After Save Processing
                            _getRecord();
                            /*
                            await APIServices.fetchAttdCheckByEmpIDLogDateIO(User.employeeId, DateFormat('dd MMMM yyyy').format(DateTime.now()).toString(), checkInMin.toString(), checkOutMin.toString()).then((response)async {
                              Iterable list = json.decode('[' + response.body + ']');
                              List<Attd_CheckInOut>? attdList;
                              attdList = list.map((model) =>
                                  Attd_CheckInOut.fromObject(model)).toList();

                              print('fetchAttdCheckByEmpIDLogDateIO');

                              attdList?.forEach((e) {
                                setState(() {
                                  tranId = e.tran_ID;
                                  active_tranId = e.tran_ID;
                                  print('tranid:' + e.tran_ID.toString());
                                  /*
                                  checkIn = e.in_TimeStr.toString();
                                  checkInMin = e.in_Time!;
                                  checkOut = e.out_TimeStr.toString();
                                  checkOutMin = e.out_Time!;
                                   */
                                });
                              });
                            });
                            */
                          }
                          else{

                            setState(() {
                              checkIn = DateFormat('HH:mm').format(DateTime.now());
                              checkInMin = hhmmToMinutes(checkIn);

                              active_tranId = tranId;
                              active_checkIn = checkIn;
                              active_checkOut = checkOut;
                              active_checkInMin = active_checkIn != "--/--" ? hhmmToMinutes(active_checkIn) : 0;
                              active_checkOutMin = active_checkOut != "--/--" ? hhmmToMinutes(active_checkOut) : 0;
                              tranId = active_tranId;
                              qR_Pass = false;
                              active_intime_Remark = intime_Remark;
                              active_outtime_Remark = outtime_Remark;

                            });
/*
                          await FirebaseFirestore.instance
                              .collection("Employee")
                              .doc(snap.docs[0].id)
                              .collection("Record")
                              .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                              .set({
                            'date': Timestamp.now(),
                            'checkIn': DateFormat('hh:mm').format(DateTime.now()),
                            'checkOut': "--/--",
                            'checkOutLocation': location,
                          });
 */
                            print('set attd_checkInOut!');

                            print('CheckIn!!!!!!!!!!!!');

                            intime_Remark = vNote;

                            attd_checkInOut.tran_ID = active_tranId != 0 ? active_tranId : 0;
                            attd_checkInOut.emp_ID = User.employeeId;
                            attd_checkInOut.log_Date = vToday;
                            attd_checkInOut.approvedDateTime = vToday;
                            attd_checkInOut.in_TimeStr = DateFormat('HH:mm').format(DateTime.now());
                            attd_checkInOut.in_Time = hhmmToMinutes(attd_checkInOut.in_TimeStr.toString());
                            attd_checkInOut.out_TimeStr = "--/--";
                            attd_checkInOut.out_Time = 0;
                            attd_checkInOut.in_Latitude = User.lat;
                            attd_checkInOut.in_Longitude = User.long;
                            qR_Pass = false;
                            attd_checkInOut.intime_Remark = intime_Remark;
                            attd_checkInOut.outtime_Remark = outtime_Remark;

                            print('attd_checkInOut start posting!');
                            var saveResponse = await APIServices.postAttdCheck(attd_checkInOut);
                            print(saveResponse);

                            //_getRecord();

                            if (saveResponse == true) {
                              //setState(() { });
                              //Navigator.pop(context, true);
                              await APIServices.postAttdCheckProc(User.employeeId, vTodayStr).then((response) async{  });
                            }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:Text('connection Issue!'),
                                    duration: Duration(seconds: 3),
                                  )
                              );
                            }

                            //After Save Processing
                            _getRecord();
                            /*
                            await APIServices.fetchAttdCheckByEmpIDLogDateIO(User.employeeId, DateFormat('dd MMMM yyyy').format(DateTime.now()).toString(), checkInMin.toString(), checkOutMin.toString()).then((response)async {
                              Iterable list = json.decode('[' + response.body + ']');
                              List<Attd_CheckInOut>? attdList;
                              attdList = list.map((model) =>
                                  Attd_CheckInOut.fromObject(model)).toList();

                              print('fetchAttdCheckByEmpIDLogDateIO');

                              attdList?.forEach((e) {
                                setState(() {
                                  tranId = e.tran_ID;
                                  active_tranId = e.tran_ID;
                                  print('tranid:' + e.tran_ID.toString());
                                  /*
                                  checkIn = e.in_TimeStr.toString();
                                  checkInMin = e.in_Time!;
                                  checkOut = e.out_TimeStr.toString();
                                  checkOutMin = e.out_Time!;
                                   */
                                });
                              });
                            });
                            */

                            //key.currentState!.reset();

                          }

                          //_getRecord();
                          if (key.currentState != null) {
                            key.currentState!.reset();
                          }
                          print('save!! 3');
                        }
                        else { // Not Lat
                          Timer(const Duration(seconds: 3), () async {
                            _getLocation();
/*
                          QuerySnapshot snap = await FirebaseFirestore.instance
                              .collection("Employee")
                              .where('id', isEqualTo: User.employeeId)
                              .get();

                          DocumentSnapshot snap2 = await FirebaseFirestore.instance
                              .collection("Employee")
                              .doc(snap.docs[0].id)
                              .collection("Record")
                              .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                              .get();
*/
                            await APIServices.fetchAttdCheck().then((response) async{
                              Iterable list=json.decode(response.body);
                              List<Attd_CheckInOut>? attdList;
                              attdList = list.map((model)=> Attd_CheckInOut.fromObject(model)).toList();
                              Iterable<Attd_CheckInOut> iattdList = attdList.where((e) => e.emp_ID == User.employeeId && e.log_Date == DateFormat('dd MMMM yyyy').format(DateTime.now()).toString());

                              //String checkIn = snap2['checkIn'];

                              //attd_checkinouts = iattdList.toList();

                              iattdList.forEach((e) {
                                tranId = e.tran_ID;
                                checkIn = e.in_TimeStr.toString();
                              });

                            });

                            if (checkIn != "--/--") {
/*
                            await FirebaseFirestore.instance
                                .collection("Employee")
                                .doc(snap.docs[0].id)
                                .collection("Record")
                                .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                                .update({
                              'date': Timestamp.now(),
                              'checkIn': checkIn,
                              'checkOut': DateFormat('hh:mm').format(DateTime.now()),
                              'checkInLocation': location,
                            });
 */
                              outtime_Remark = vNote;

                              setState(() {
                                checkOut = checkIn != "--/--" ? DateFormat('HH:mm').format(DateTime.now()) : "--/--";

                                active_tranId = tranId;
                                active_checkIn = checkIn;
                                active_checkOut = checkOut;
                                active_checkInMin =
                                active_checkIn != "--/--" ? hhmmToMinutes(
                                    active_checkIn) : 0;
                                active_checkOutMin =
                                active_checkOut != "--/--" ? hhmmToMinutes(
                                    active_checkOut) : 0;
                                qR_Pass = false;
                                active_intime_Remark = intime_Remark;
                                active_outtime_Remark = outtime_Remark;
                              });

                              print('set attd_checkInOut!');
                              print('CheckOut Not Lat!!!!!!!!!!!!');

                              attd_checkInOut.tran_ID = tranId;
                              attd_checkInOut.emp_ID = User.employeeId;
                              //attd_checkInOut.log_Date = vToday;
                              attd_checkInOut.approvedDateTime = vToday;
                              attd_checkInOut.in_TimeStr = checkIn;
                              attd_checkInOut.in_Time = hhmmToMinutes(attd_checkInOut.in_TimeStr.toString());
                              attd_checkInOut.in_Latitude = User.lat;
                              attd_checkInOut.in_Longitude = User.long;
                              attd_checkInOut.out_TimeStr = DateFormat('HH:mm').format(DateTime.now());
                              attd_checkInOut.out_Time = hhmmToMinutes(attd_checkInOut.out_TimeStr.toString());
                              attd_checkInOut.out_Latitude = 0;
                              attd_checkInOut.out_Longitude = 0;
                              attd_checkInOut.qR_Pass = false;
                              attd_checkInOut.intime_Remark = intime_Remark;
                              attd_checkInOut.outtime_Remark = outtime_Remark;

                              print('attd_checkInOut start posting!');
                              var saveResponse = await APIServices.postAttdCheck(attd_checkInOut);

                              //_getRecord();
                              print(saveResponse);
                              if (saveResponse == true) {
                                //setState(() { });
                                //Navigator.pop(context, true);
                                await APIServices.postAttdCheckProc(User.employeeId, vTodayStr).then((response) async{  });
                              }
                              else{
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:Text('connection Issue!'),
                                      duration: Duration(seconds: 3),
                                    )
                                );
                              }

                              //After Save Processing
                              _getRecord();
                              /*
                              await APIServices.fetchAttdCheckByEmpIDLogDateIO(User.employeeId, DateFormat('dd MMMM yyyy').format(DateTime.now()).toString(), checkInMin.toString(), checkOutMin.toString()).then((response)async {
                                Iterable list = json.decode('[' + response.body + ']');
                                List<Attd_CheckInOut>? attdList;
                                attdList = list.map((model) =>
                                    Attd_CheckInOut.fromObject(model)).toList();

                                print('fetchAttdCheckByEmpIDLogDateIO');

                                attdList?.forEach((e) {
                                  setState(() {
                                    tranId = e.tran_ID;
                                    active_tranId = e.tran_ID;
                                    print('tranid:' + e.tran_ID.toString());
                                    /*
                                  checkIn = e.in_TimeStr.toString();
                                  checkInMin = e.in_Time!;
                                  checkOut = e.out_TimeStr.toString();
                                  checkOutMin = e.out_Time!;
                                   */
                                  });
                                });
                              });
                              */
                            }
                            else {

                              intime_Remark = vNote;

                              setState(() {
                                checkIn = DateFormat('HH:mm').format(DateTime.now());

                                active_tranId = tranId;
                                active_checkIn = checkIn;
                                active_checkOut = checkOut;
                                active_checkInMin = active_checkIn != "--/--" ? hhmmToMinutes(active_checkIn) : 0;
                                active_checkOutMin = active_checkOut != "--/--" ? hhmmToMinutes(active_checkOut) : 0;
                                qR_Pass = false;
                                active_intime_Remark = intime_Remark;
                                active_outtime_Remark = outtime_Remark;

                              });

                              /*
                            await FirebaseFirestore.instance
                                .collection("Employee")
                                .doc(snap.docs[0].id)
                                .collection("Record")
                                .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                                .set({
                              'date': Timestamp.now(),
                              'checkIn': DateFormat('hh:mm').format(DateTime.now()),
                              'checkOut': "--/--",
                              'checkOutLocation': location,
                            });
                             */
                              print('set attd_checkInOut!');
                              print('CheckIn Not Lat!!!!!!!!!!!!');
                              attd_checkInOut.tran_ID = active_tranId != 0 ? active_tranId : 0;
                              attd_checkInOut.emp_ID = User.employeeId;
                              attd_checkInOut.log_Date = vToday;
                              attd_checkInOut.approvedDateTime = vToday;
                              attd_checkInOut.in_TimeStr = DateFormat('HH:mm').format(DateTime.now());
                              attd_checkInOut.in_Time = hhmmToMinutes(attd_checkInOut.in_TimeStr.toString());
                              attd_checkInOut.in_Latitude = User.lat;
                              attd_checkInOut.in_Longitude = User.long;
                              attd_checkInOut.out_TimeStr = "--/--";
                              attd_checkInOut.out_Time = 0;
                              attd_checkInOut.out_Latitude = 0;
                              attd_checkInOut.out_Longitude = 0;
                              attd_checkInOut.qR_Pass = false;
                              attd_checkInOut.intime_Remark = intime_Remark;
                              attd_checkInOut.outtime_Remark = outtime_Remark;

                              print('attd_checkInOut start posting!');
                              var saveResponse = await APIServices.postAttdCheck(attd_checkInOut);

                              //_getRecord();
                              print(saveResponse);
                              if (saveResponse == true) {
                                //setState(() { });
                                //Navigator.pop(context, true);
                                await APIServices.postAttdCheckProc(User.employeeId, vTodayStr).then((response) async{  });
                              }
                              else{
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:Text('connection Issue!'),
                                      duration: Duration(seconds: 3),
                                    )
                                );
                              }

                              //After Save Processing
                              _getRecord();
                              /*
                              await APIServices.fetchAttdCheckByEmpIDLogDateIO(User.employeeId, DateFormat('dd MMMM yyyy').format(DateTime.now()).toString(), checkInMin.toString(), checkOutMin.toString()).then((response)async {
                                Iterable list = json.decode('[' + response.body + ']');
                                List<Attd_CheckInOut>? attdList;
                                attdList = list.map((model) =>
                                    Attd_CheckInOut.fromObject(model)).toList();

                                print('fetchAttdCheckByEmpIDLogDateIO');

                                attdList?.forEach((e) {
                                  setState(() {
                                    tranId = e.tran_ID;
                                    active_tranId = e.tran_ID;
                                    print('tranid:' + e.tran_ID.toString());
                                    /*
                                  checkIn = e.in_TimeStr.toString();
                                  checkInMin = e.in_Time!;
                                  checkOut = e.out_TimeStr.toString();
                                  checkOutMin = e.out_Time!;
                                   */
                                  });
                                });
                              });
                              */
                            }

                            //_getRecord();

                            if (key.currentState != null) {
                              key.currentState!.reset();
                            }

                          });
                        }
                      },
                    );
                  },
                ),
              ) : Container(
                margin: const EdgeInsets.only(top: 32, bottom: 32),
                child: Text(
                  "You have completed this day!",
                  style: TextStyle(
                    fontFamily: "NexaRegular",
                    fontSize: screenWidth / 20,
                    color: Colors.black54,
                  ),
                ),
              ),
              location != " " ? Text(
                "Location: " + location,
              ) : const SizedBox(),
              GestureDetector(
                onTap: () {
                  scanQRandCheck();
                },
                child: Container(
                  height: screenWidth / 2,
                  width: screenWidth / 2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(2, 2),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.expand,
                            size: 70,
                            color: primary,
                          ),
                          Icon(
                            FontAwesomeIcons.camera,
                            size: 25,
                            color: primary,
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8,),
                        child: Text(
                          checkIn == "--/--" ? "Scan to Check In" : "Scan to Check Out",
                          style: TextStyle(
                            fontFamily: "NexaRegular",
                            fontSize: screenWidth / 20,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }

  Widget _buildAttdList(){

    return ListView.builder(
      itemCount: (attd_checkinouts!= null) ? attd_checkinouts?.length : 1,
      itemBuilder: (context, index) {

        if (attd_checkinouts!= null) {
          print('chk 1');
          //setState(() {
          tranId = attd_checkinouts![index].tran_ID;

          checkIn = attd_checkinouts![index].in_TimeStr!.toString();
          checkOut = attd_checkinouts![index].out_TimeStr!.toString();

          checkIn = checkIn == "" ? "--/--" : checkIn;
          checkOut = checkOut == "" ? "--/--" : checkOut;

          checkInMin = attd_checkinouts![index].in_Time!;
          checkOutMin = attd_checkinouts![index].out_Time!;

          intime_Remark = attd_checkinouts![index].intime_Remark!.toString();
          outtime_Remark = attd_checkinouts![index].outtime_Remark!.toString();

          if (tranId == active_tranId){
            print('active_tranId - ' + active_tranId.toString());
            checkIn = active_checkIn;
            checkInMin = active_checkInMin;
            checkOut = active_checkOut;
            checkOutMin = active_checkOutMin;
            intime_Remark = active_intime_Remark;
            outtime_Remark = active_outtime_Remark;
          }

          //});
          print('chk 2');
        }
        else{
          //setState(() {
          tranId = 0;

          checkIn = "--/--";
          checkOut = "--/--";

          checkInMin = 0;
          checkOutMin = 0;

          intime_Remark = "";
          outtime_Remark = "";
          //});
        }

        return attd_checkinouts!= null ? Container(
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
                      DateFormat('EE\ndd').format(attd_checkinouts![index].log_Date!),
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
                        fontSize: screenWidth / 24,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      checkIn,
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
                        fontSize: screenWidth / 24,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      checkOut,
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ElevatedButton(
                      child: Icon(Icons.edit),
                      onPressed: () async {
                        //editAttdCheckOut(attd_checkinouts![index].tran_ID);

                        print('set attd_checkInOut!');
                        attd_checkInOut.tran_ID =
                            attd_checkinouts![index].tran_ID;
                        attd_checkInOut.emp_ID =
                            attd_checkinouts![index].emp_ID;
                        //attd_checkInOut.log_Date = attd_checkinouts![index].log_Date;
                        attd_checkInOut.approvedDateTime =
                            attd_checkinouts![index].approvedDateTime;
                        attd_checkInOut.in_TimeStr =
                            attd_checkinouts![index].in_TimeStr;
                        attd_checkInOut.in_Time =
                            attd_checkinouts![index].in_Time;
                        attd_checkInOut.in_Latitude =
                            attd_checkinouts![index].in_Latitude;
                        attd_checkInOut.in_Longitude =
                            attd_checkinouts![index].in_Longitude;
                        attd_checkInOut.out_TimeStr = "--/--";
                        attd_checkInOut.out_Time = 0;
                        attd_checkInOut.out_Latitude = 0;
                        attd_checkInOut.out_Longitude = 0;

                        tranId = attd_checkInOut.tran_ID;
                        checkIn = attd_checkInOut.in_TimeStr.toString();
                        checkOut = attd_checkInOut.out_TimeStr.toString();
                        checkInMin = int.parse(attd_checkInOut.in_Time.toString());
                        checkOutMin = int.parse(attd_checkInOut.out_Time.toString());

                        active_tranId = tranId;
                        active_checkIn = checkIn;
                        active_checkOut = checkOut;
                        active_checkInMin = checkInMin;
                        active_checkOutMin = checkOutMin;

                        print('attd_checkInOut start editing!');
                        var saveResponse = await APIServices.postAttdCheck(
                            attd_checkInOut);
                        print(saveResponse);
                        if (saveResponse == true) {
                          //Navigator.pop(context, true);
                          await APIServices.postAttdCheckProc(User.employeeId, vTodayStr).then((response) async{  });
                          _getRecord();
                        }
                        else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('connection Issue!'),
                                duration: Duration(seconds: 3),
                              )
                          );
                        }
                      },
                    ),

                    ElevatedButton(
                      child: Icon(Icons.delete),
                      onPressed: () async {
                        //deleteAttdCheck(attd_checkinouts![index].tran_ID);

                        await APIServices.deleteAttdCheckProc(attd_checkinouts![index].tran_ID).then((response) async{  });

                        print('delete 1');
                        var dResponse = await APIServices.deleteAttdCheck(
                            attd_checkinouts![index].tran_ID);
                        print('delete 2');

                        print('delete 3');
                        print(dResponse);
                        if (dResponse == true) {
                          //Navigator.pop(context, true);
                          _getRecord();
                        }
                        else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('connection Issue!'),
                                duration: Duration(seconds: 3),
                              )
                          );
                        }
                        print('delete 4');

                        //setState(() { });

                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
            : Container(
          margin: const EdgeInsets.only(top: 12, bottom: 32),
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
                      DateFormat('EE\ndd').format(vToday),
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
                      checkIn,
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
                      checkOut,
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
        );

      },
    );
  }

  Widget _buildAddShiftFloatingButton(){
    return FloatingActionButton(
        heroTag: "btnAddShift",
        tooltip: "Add Shift",
        backgroundColor: Colors.white,
        child: Icon(Icons.more_time, color:Colors.black,size: 30.0,),
        onPressed: () async {
          print('set attd_checkInOut!');

          active_tranId=0;
          active_checkIn = "--/--";
          active_checkOut = "--/--";
          active_checkInMin=0;
          active_checkOutMin=0;
          tranId=0;
          checkIn = "--/--";
          checkOut = "--/--";
          checkInMin = 0;
          checkOutMin = 0;

          attd_checkInOut.tran_ID = 0;
          attd_checkInOut.emp_ID = User.employeeId;
          attd_checkInOut.log_Date = vToday;
          attd_checkInOut.approvedDateTime = vToday;
          attd_checkInOut.in_TimeStr = "--/--";
          attd_checkInOut.in_Time = 0;
          attd_checkInOut.in_Latitude = User.lat;
          attd_checkInOut.in_Longitude = User.long;
          attd_checkInOut.out_TimeStr = "--/--";
          attd_checkInOut.out_Time = 0;
          attd_checkInOut.out_Latitude = 0;
          attd_checkInOut.out_Longitude = 0;

          print('attd_checkInOut start adding!');
          var saveResponse = await APIServices.postAttdCheck(attd_checkInOut);
          print(saveResponse);
          if (saveResponse == true) {
            //Navigator.pop(context, true);
            _getRecord();
          }
          else{
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:Text('connection Issue!'),
                  duration: Duration(seconds: 3),
                )
            );
          }
        });
  }

  Widget _buildAddLeaveFloatingButton(){
    return FloatingActionButton(
        heroTag: "btnAddLeave",
        tooltip: "Add Leave Request",
        backgroundColor: Colors.white,
        child: Icon(Icons.airplane_ticket_outlined, color:Colors.black,size: 30.0,),
        onPressed: () async {
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

class Note_Add extends StatefulWidget {
  const Note_Add({Key? key}) : super(key: key);

  @override
  State<Note_Add> createState() => _Note_Add();
}

class _Note_Add extends State<Note_Add> {
  late SharedPreferences sharedPreferences;
  var noteController = TextEditingController();

  double screenHeight = 0;
  double screenWidth = 0;

  var textStyle=TextStyle();

  @override
  void initState() {
    super.initState();
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

    return AlertDialog(
      title: const Text('Check In/Out Note'),
      content: SingleChildScrollView(
        child: TextField(
          controller: noteController,
          style: textStyle,
          onChanged: (value)=>updateNote(),
          decoration: InputDecoration(
              labelText: "Fill Note..",
              labelStyle: textStyle,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
              )
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _cancel,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Save'),
        ),
      ],
    );
  }

  Future<void> updateNote() async {
    /*
    if (noteController.text.contains('http') == false){
      ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text("Invalid API Server URL!!")));
      return;
    }
     */
  }

  void _cancel(){
    Navigator.pop(context);
  }

  Future<void> _submit() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('note', noteController.text);
    setState(() {
    });

    Navigator.pop(context);
  }
}
