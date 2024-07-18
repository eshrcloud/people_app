import 'package:flutter/material.dart';
import 'package:people_app/ui/attendancescreen.dart';
import 'package:people_app/ui/leaverequestscreen.dart';
import 'package:people_app/ui/leavebalancescreen.dart';
import 'package:people_app/ui/paysheetscreen.dart';
import 'package:people_app/ui/servicerecordscreen.dart';

class EnquiryScreen extends StatefulWidget {
  static const routeName = '/home/enquiry';
  EnquiryScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EnquiryScreenState();
}

class _EnquiryScreenState extends State<EnquiryScreen> {
  double screenHeight = 0;
  double screenWidth = 0;

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
                "Enquiry",
                style: TextStyle(
                  fontFamily: "NexaBold",
                  fontSize: screenWidth / 18,
                ),
              ),
            ),
            SizedBox(
              height: screenHeight / 1.45,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index){
                  if (index==0) {
                    return Card(
                      color: Colors.white,
                      elevation: 2.0,
                      child: ListTile(
                        title: ListTile(
                          leading: Icon(Icons.calendar_month,),
                          trailing: Icon(Icons.arrow_forward_ios),
                          title: Text('Attendance'),
                          onTap: () {
                            navigateToAttendance();
                          },
                        ),
                      ),
                    );
                  }
                  else if (index==1) {
                    return Card(
                      color: Colors.white,
                      elevation: 2.0,
                      child: ListTile(
                        title: ListTile(
                          leading: Icon(Icons.calendar_today_outlined,),
                          trailing: Icon(Icons.arrow_forward_ios),
                          title: Text('Leave Request'),
                          onTap: () {
                            navigateToLeaveRequest();
                          },
                        ),
                      ),
                    );
                  }
                  else if (index==2) {
                    return Card(
                      color: Colors.white,
                      elevation: 2.0,
                      child: ListTile(
                        title: ListTile(
                          leading: Icon(Icons.calendar_today_outlined,),
                          trailing: Icon(Icons.arrow_forward_ios),
                          title: Text('Leave Balance'),
                          onTap: () {
                            navigateToLeaveBalance();
                          },
                        ),
                      ),
                    );
                  }
                  else if (index==3) {
                    return Card(
                      color: Colors.white,
                      elevation: 2.0,
                      child: ListTile(
                        title: ListTile(
                          leading: Icon(Icons.money,),
                          trailing: Icon(Icons.arrow_forward_ios),
                          title: Text('Payslip'),
                          onTap: () {
                            navigateToPayslip();
                          },
                        ),
                      ),
                    );
                  }
                  else if (index==4) {
                    return Card(
                      color: Colors.white,
                      elevation: 2.0,
                      child: ListTile(
                        title: ListTile(
                          leading: Icon(Icons.business_center,),
                          trailing: Icon(Icons.arrow_forward_ios),
                          title: Text('Service Record'),
                          onTap: () {
                            navigateToServiceRecord();
                          },
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToAttendance() async{
    await Navigator.push(context, MaterialPageRoute(builder: (context) => AttendanceScreen()));
  }

  void navigateToLeaveRequest() async{
    await Navigator.push(context, MaterialPageRoute(builder: (context) => LeaveRequestScreen()));
  }

  void navigateToLeaveBalance() async{
    await Navigator.push(context, MaterialPageRoute(builder: (context) => LeaveBalanceScreen()));
  }

  void navigateToPayslip() async{
    await Navigator.push(context, MaterialPageRoute(builder: (context) => PaysheetScreen()));
  }

  void navigateToServiceRecord() async{
    await Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceRecordScreen()));
  }

}
