import 'package:people_app/models/user.dart';
import 'package:people_app/ui/enquiryscreen.dart';
import 'package:people_app/ui/profilescreen.dart';
import 'package:people_app/services/location_service.dart';
import 'package:people_app/ui/todayscreen.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:people_app/ui/extensions.dart';
import 'package:people_app/services/api.services.dart';
import 'package:people_app/models/emp_login.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences sharedPreferences;
  List<Emp_Login>? emp_logins;

  double screenHeight = 0;
  double screenWidth = 0;

  //Color primary = const '#3792cb'.toColor();
  Color primary = const Color(0xFF0288D1);

  int currentIndex = 0;

  List<IconData> navigationIcons = [
    FontAwesomeIcons.check,
    FontAwesomeIcons.calendarAlt,
    FontAwesomeIcons.user,
  ];

  @override
  void initState() {
    super.initState();
    _startLocationService();
    getId().then((value) {
      _getCredentials();
      _getProfilePic();
    });
  }

  void _getCredentials() async {
    try {
      /*
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection("Employee").doc(User.id).get();
      setState(() {
        User.canEdit = doc['canEdit'];
        User.firstName = doc['firstName'];
        User.lastName = doc['lastName'];
        User.birthDate = doc['birthDate'];
        User.address = doc['address'];
      });
       */
      /*
      APIServices.fetchEmpLogInByID(User.employeeId).then((response) async {

        Iterable list=json.decode("[" + response.body + "]");
        List<Emp_Login>? empList;
        empList = list.map((model)=> Emp_Login.fromObject(model)).toList();

        emp_logins = empList;

        setState(() {
          User.firstName = (emp_logins?.firstWhere((e) => true).emp_Name).toString();
        });

      });
       */
      sharedPreferences = await SharedPreferences.getInstance();
      if(sharedPreferences.getDouble('employeeId') != null) {
        setState(() {
          User.employeeId = sharedPreferences.getDouble('employeeId')!;
          User.firstName = sharedPreferences.getString('firstName')!;
          User.lastName = sharedPreferences.getString('lastName')!;
          User.password = sharedPreferences.getString('password')!;
          //User.lat = _currentPosition?.latitude as double;
          //User.long = _currentPosition?.longitude as double;
        });
      }
    } catch(e) {
      return;
    }
  }

  void _getProfilePic() async {
    /*
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection("Employee").doc(User.id).get();
    setState(() {
      User.profilePicLink = doc['profilePic'];
    });
    */
  }

  void _startLocationService() async {
    LocationService().initialize();

    LocationService().getLongitude().then((value) {
      setState(() {
        User.long = value!;
      });

      LocationService().getLatitude().then((value) {
        setState(() {
          User.lat = value!;
        });
      });
    });
  }

  Future<void> getId() async {
    /*
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("Employee")
        .where('id', isEqualTo: User.employeeId)
        .get();

    setState(() {
      User.id = snap.docs[0].id;
    });
     */
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    /*
    _startLocationService();
    getId().then((value) {
      _getCredentials();
      _getProfilePic();
    });

     */

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          new TodayScreen(),
          new EnquiryScreen(),
          new ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        margin: const EdgeInsets.only(
          left: 12,
          right: 12,
          bottom: 24,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for(int i = 0; i < navigationIcons.length; i++)...<Expanded>{
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = i;
                      });
                    },
                    child: Container(
                      height: screenHeight,
                      width: screenWidth,
                      color: Colors.white,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              navigationIcons[i],
                              color: i == currentIndex ? primary : Colors.black54,
                              size: i == currentIndex ? 30 : 26,
                            ),
                            i == currentIndex ? Container(
                              margin: const EdgeInsets.only(top: 6),
                              height: 3,
                              width: 22,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(40)),
                                color: primary,
                              ),
                            ) : const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              }
            ],
          ),
        ),
      ),
    );
  }
}
