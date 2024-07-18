import 'package:people_app/ui/loginscreen.dart';
import 'package:people_app/ui/homescreen.dart';
import 'package:people_app/ui/todayscreen.dart';
import 'package:people_app/ui/enquiryscreen.dart';
import 'package:people_app/ui/profilescreen.dart';

var appRoutes = {
  LoginScreen.routeName: (context) => LoginScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  TodayScreen.routeName: (context) => TodayScreen(),
  EnquiryScreen.routeName: (context) => EnquiryScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
};
