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
import 'package:people_app/models/attd_checkinout.dart';
import 'package:people_app/services/api.services.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class TodayScreenSingle extends StatefulWidget {
  const TodayScreenSingle({Key? key}) : super(key: key);

  @override
  _TodayScreenSingleState createState() => _TodayScreenSingleState();
}

class _TodayScreenSingleState extends State<TodayScreenSingle> {
  late SharedPreferences sharedPreferences;
  late Attd_CheckInOut attd_checkInOut;
  final connectionIssueSnackBar = SnackBar(content: Text("404, Connection Issue !"));

  List<Attd_CheckInOut>? attd_checkinouts;

  double screenHeight = 0;
  double screenWidth = 0;

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

  String vTodayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateTime vToday = DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));

  Color primary = const Color(0xFF0288D1);

  @override
  void initState() {
    super.initState();
    _getRecord();
    _getOfficeCode();
  }

  void _getOfficeCode() async {
    /*
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection("Attributes").doc("Office1").get();
    setState(() {
      officeCode = snap['code'];
    });
     */
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
/*
    if(scanResult == officeCode) {
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
    }

 */
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
      APIServices.fetchAttdCheckByEmpIDLogDate(User.employeeId,DateFormat('dd-MMM-yyyy').format(DateTime.now()).toString()).then((response){
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
            });
          });
        }
        else{
          print('isEmpty 1');
          attd_checkInOut = new Attd_CheckInOut.WithId(m_tran_ID: 0, m_emp_ID: 0, m_log_Date: DateTime.now(), m_in_Time: 0, m_in_TimeStr: '', m_out_Time: 0, m_out_TimeStr: '', m_working_Hr: 0, m_working_HrStr: '', m_intime_Remark: '', m_outtime_Remark: '', m_in_Latitude: 0, m_in_Longitude: 0, m_out_Latitude: 0, m_out_Longitude: 0, m_notInRange: true, m_approved: false, m_approvedBy: 0, m_approvedDateTime: null, m_imp_Copy: false, m_qR_Pass: false, m_editUserID: User.employeeId, m_editDateTime: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now())));
          attdList?.add(attd_checkInOut as Attd_CheckInOut);
          print('set attd_checkInOut! _getRecord!!');
          print(attdList);
          print('len - ' + attdList.length.toString());
          attd_checkinouts = attdList!;

          if (this.mounted) {
            setState(() {
              checkIn = "--/--";
              checkOut = "--/--";
              tranId = 0;
            });
          }
        }
      });
    } catch(e) {
      setState(() {
        checkIn = "--/--";
        checkOut = "--/--";
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
                  User == null ? "Employee" : User.firstName,
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
                          APIServices.fetchAttdCheckByEmpIDLogDate(User.employeeId, DateFormat('dd MMMM yyyy').format(DateTime.now()).toString()).then((response){
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
                            });

                            setState(() {
                              checkOut = DateFormat('HH:mm').format(DateTime.now());

                              active_tranId = tranId;
                              active_checkIn = checkIn;
                              active_checkOut = checkOut;
                              active_checkInMin = active_checkIn != "--/--" ? hhmmToMinutes(active_checkIn) : 0;
                              active_checkOutMin = active_checkOut != "--/--" ? hhmmToMinutes(active_checkOut) : 0;

                            });


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
                            print('attd_checkInOut start posting!');
                            //ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text("set attd_checkInOut! 2")));

                            var saveResponse = await APIServices.postAttdCheck(attd_checkInOut);

                            //_getRecord();

                            print(saveResponse);
                            //ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content:Text("set attd_checkInOut! 3")));
                            if (saveResponse == true) {
                              //setState(() { });
                              Navigator.pop(context, true);
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

                            attd_checkInOut.tran_ID = 0;
                            attd_checkInOut.emp_ID = User.employeeId;
                            attd_checkInOut.log_Date = vToday;
                            attd_checkInOut.approvedDateTime = vToday;
                            attd_checkInOut.in_TimeStr = DateFormat('HH:mm').format(DateTime.now());
                            attd_checkInOut.in_Time = hhmmToMinutes(attd_checkInOut.in_TimeStr.toString());
                            attd_checkInOut.out_TimeStr = "--/--";
                            attd_checkInOut.out_Time = 0;
                            attd_checkInOut.in_Latitude = User.lat;
                            attd_checkInOut.in_Longitude = User.long;

                            print('attd_checkInOut start posting!');
                            var saveResponse = await APIServices.postAttdCheck(attd_checkInOut);
                            print(saveResponse);

                            //_getRecord();

                            if (saveResponse == true) {
                              //setState(() { });
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

                          //_getRecord();
                          key.currentState!.reset();
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
                            APIServices.fetchAttdCheck().then((response){
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

                              setState(() {
                                checkOut = DateFormat('HH:mm').format(DateTime.now());

                                active_tranId = tranId;
                                active_checkIn = checkIn;
                                active_checkOut = checkOut;
                                active_checkInMin = active_checkIn != "--/--" ? hhmmToMinutes(active_checkIn) : 0;
                                active_checkOutMin = active_checkOut != "--/--" ? hhmmToMinutes(active_checkOut) : 0;

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

                              print('attd_checkInOut start posting!');
                              var saveResponse = await APIServices.postAttdCheck(attd_checkInOut);

                              //_getRecord();
                              print(saveResponse);
                              if (saveResponse == true) {
                                //setState(() { });
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
                            else {

                              setState(() {
                                checkIn = DateFormat('HH:mm').format(DateTime.now());

                                active_tranId = tranId;
                                active_checkIn = checkIn;
                                active_checkOut = checkOut;
                                active_checkInMin = active_checkIn != "--/--" ? hhmmToMinutes(active_checkIn) : 0;
                                active_checkOutMin = active_checkOut != "--/--" ? hhmmToMinutes(active_checkOut) : 0;


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
                              attd_checkInOut.tran_ID = 0;
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

                              print('attd_checkInOut start posting!');
                              var saveResponse = await APIServices.postAttdCheck(attd_checkInOut);

                              //_getRecord();
                              print(saveResponse);
                              if (saveResponse == true) {
                                //setState(() { });
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

                            //_getRecord();

                            key.currentState!.reset();

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
}
