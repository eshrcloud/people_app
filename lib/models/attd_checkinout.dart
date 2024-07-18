import 'dart:convert';

class Attd_CheckInOut {
  late double m_tran_ID;
  late double? m_emp_ID;
  late DateTime? m_log_Date;
  late int? m_in_Time;
  late String? m_in_TimeStr;
  late int? m_out_Time;
  late String? m_out_TimeStr;
  late int? m_working_Hr;
  late String? m_working_HrStr;
  late String? m_intime_Remark;
  late String? m_outtime_Remark;
  late double? m_in_Latitude;
  late double? m_in_Longitude;
  late double? m_out_Latitude;
  late double? m_out_Longitude;
  late bool? m_notInRange;
  late bool? m_approved;
  late double? m_approvedBy;
  late DateTime? m_approvedDateTime;
  late bool? m_imp_Copy;
  late bool? m_qR_Pass;
  late double? m_editUserID;
  late DateTime? m_editDateTime;

  Attd_CheckInOut({ required this.m_emp_ID, required this.m_log_Date,
    required this.m_in_Time, required this.m_in_TimeStr, required this.m_out_Time, required this.m_out_TimeStr, required this.m_working_Hr, required this.m_working_HrStr, required this.m_intime_Remark, required this.m_outtime_Remark,
    required this.m_in_Latitude, required this.m_in_Longitude, required this.m_out_Latitude, required this.m_out_Longitude,
    required this.m_notInRange, required this.m_approved, required this.m_approvedBy, required this.m_approvedDateTime, required this.m_imp_Copy, required this.m_qR_Pass, required this.m_editUserID, required this.m_editDateTime
  });
  Attd_CheckInOut.WithId({ required this.m_tran_ID, required this.m_emp_ID, required this.m_log_Date,
    required this.m_in_Time, required this.m_in_TimeStr, required this.m_out_Time, required this.m_out_TimeStr, required this.m_working_Hr, required this.m_working_HrStr, required this.m_intime_Remark, required this.m_outtime_Remark,
    required this.m_in_Latitude, required this.m_in_Longitude, required this.m_out_Latitude, required this.m_out_Longitude,
    required this.m_notInRange, required this.m_approved, required this.m_approvedBy, required this.m_approvedDateTime, required this.m_imp_Copy, required this.m_qR_Pass, required this.m_editUserID, required this.m_editDateTime
  });

  double get tran_ID => m_tran_ID;
  double? get emp_ID => m_emp_ID;
  DateTime? get log_Date => m_log_Date;
  int? get in_Time => m_in_Time;
  String? get in_TimeStr => m_in_TimeStr;
  int? get out_Time => m_out_Time;
  String? get out_TimeStr => m_out_TimeStr;
  int? get working_Hr => m_working_Hr;
  String? get working_HrStr => m_working_HrStr;
  String? get intime_Remark => m_intime_Remark;
  String? get outtime_Remark => m_outtime_Remark;
  double? get in_Latitude => m_in_Latitude;
  double? get in_Longitude => m_in_Longitude;
  double? get out_Latitude => m_out_Latitude;
  double? get out_Longitude => m_out_Longitude;
  bool? get notInRange => m_notInRange;
  bool? get approved => m_approved;
  double? get approvedBy => m_approvedBy;
  DateTime? get approvedDateTime => m_approvedDateTime;
  bool? get imp_Copy => m_imp_Copy;
  bool? get qR_Pass => m_qR_Pass;
  double? get editUserID => m_editUserID;
  DateTime? get editDateTime => m_editDateTime;

  set tran_ID(double newtran_ID){ m_tran_ID = newtran_ID; }
  set emp_ID(double? newemp_ID){ m_emp_ID = newemp_ID; }
  set log_Date(DateTime? newlog_Date){ m_log_Date = newlog_Date; }
  set in_Time(int? newin_Time){ m_in_Time = newin_Time; }
  set in_TimeStr(String? newin_TimeStr){ m_in_TimeStr = newin_TimeStr; }
  set out_Time(int? newout_Time){ m_out_Time = newout_Time; }
  set out_TimeStr(String? newout_TimeStr){ m_out_TimeStr = newout_TimeStr; }
  set working_Hr(int? newworking_Hr){ m_working_Hr = newworking_Hr; }
  set working_HrStr(String? newworking_HrStr){ m_working_HrStr = newworking_HrStr; }
  set intime_Remark(String? newintime_Remark){ m_intime_Remark = newintime_Remark; }
  set outtime_Remark(String? newouttime_Remark){ m_outtime_Remark = newouttime_Remark; }
  set in_Latitude(double? newin_Latitude){ m_in_Latitude = newin_Latitude; }
  set in_Longitude(double? newin_Longitude){ m_in_Longitude = newin_Longitude; }
  set out_Latitude(double? newout_Latitude){ m_out_Latitude = newout_Latitude; }
  set out_Longitude(double? newout_Longitude){ m_out_Longitude = newout_Longitude; }
  set notInRange(bool? newnotInRange){ m_notInRange = newnotInRange; }
  set approved(bool? newapproved){ m_approved = newapproved; }
  set approvedBy(double? newapprovedBy){ m_approvedBy = newapprovedBy; }
  set approvedDateTime(DateTime? newapprovedDateTime){ m_approvedDateTime = newapprovedDateTime; }
  set imp_Copy(bool? newimp_Copy){ m_imp_Copy = newimp_Copy; }
  set qR_Pass(bool? newqR_Pass){ m_qR_Pass = newqR_Pass; }
  set editUserID(double? neweditUserID){ m_editUserID = neweditUserID; }
  set editDateTime(DateTime? neweditDateTime){ m_editDateTime = neweditDateTime; }

  Map<String,dynamic> toMap(){
      var map=Map<String,dynamic>();
      map["emp_ID"]=m_emp_ID;
      map["log_Date"]= m_log_Date!.toIso8601String();
      map["in_Time"]=m_in_Time;
      map["in_TimeStr"]=m_in_TimeStr;
      map["out_Time"]=m_out_Time;
      map["out_TimeStr"]=m_out_TimeStr;
      map["working_Hr"]=m_working_Hr;
      map["working_HrStr"]=m_working_HrStr;
      map["intime_Remark"]=m_intime_Remark;
      map["outtime_Remark"]=m_outtime_Remark;
      map["in_Latitude"]=m_in_Latitude;
      map["in_Longitude"]=m_in_Longitude;
      map["out_Latitude"]=m_out_Latitude;
      map["out_Longitude"]=m_out_Longitude;
      map["notInRange"]=m_notInRange;
      map["approved"]=m_approved;
      map["approvedBy"]=m_approvedBy;
      map["approvedDateTime"]=m_approvedDateTime!.toIso8601String();
      map["imp_Copy"]=m_imp_Copy;
      map["qR_Pass"]=m_qR_Pass;
      map["editUserID"]=m_editUserID;
      map["editDateTime"]=m_editDateTime!.toIso8601String();

      if (m_tran_ID!=null){
        map["tran_ID"]=m_tran_ID;
      }

      return map;
  }

  Attd_CheckInOut.fromObject(dynamic o){
    this.m_tran_ID = double.parse(o["tran_ID"].toString());
    this.m_emp_ID = double.parse(o["emp_ID"].toString());
    this.m_log_Date = o["log_Date"] != null ? DateTime.parse(o["log_Date"].toString()) : null;
    this.m_in_Time = int.parse(o["in_Time"].toString());
    this.m_in_TimeStr = o["in_TimeStr"].toString();
    this.m_out_Time = int.parse(o["out_Time"].toString());
    this.m_out_TimeStr = o["out_TimeStr"].toString();
    this.m_working_Hr = int.parse(o["working_Hr"].toString());
    this.m_working_HrStr = o["working_HrStr"];
    this.m_intime_Remark = o["intime_Remark"].toString();
    this.m_outtime_Remark = o["outtime_Remark"].toString();
    this.m_in_Latitude = double.parse(o["in_Latitude"].toString());
    this.m_in_Longitude = double.parse(o["in_Longitude"].toString());
    this.m_out_Latitude = double.parse(o["out_Latitude"].toString());
    this.m_out_Longitude = double.parse(o["out_Longitude"].toString());
    this.m_notInRange = o["notInRange"] != null ? o["notInRange"] : false;
    this.m_approved = o["approved"] != null ? o["approved"] : false;
    this.m_approvedBy = o["approvedBy"] != null ? double.parse(o["approvedBy"].toString()) : null;
    this.m_approvedDateTime = o["approvedDateTime"] != null ? DateTime.parse(o["approvedDateTime"].toString()) : null;
    this.m_imp_Copy = o["imp_Copy"] != null ? o["imp_Copy"] : false;
    this.m_qR_Pass = o["qR_Pass"] != null ? o["qR_Pass"] : false;
    this.m_editUserID = o["editUserID"] != null ? double.parse(o["editUserID"].toString()) : null;
    this.m_editDateTime = o["editDateTime"] != null ? DateTime.parse(o["editDateTime"].toString()) : null;
  }

/*
  Attd_CheckInOut.fromObject(dynamic o){
    this.m_tran_ID = 0;
    this.m_emp_ID = 0;
    this.m_log_Date = null;
    this.m_in_Time = 0;
    this.m_in_TimeStr = "";
    this.m_out_Time = 0;
    this.m_out_TimeStr = "";
    this.m_working_Hr = 0;
    this.m_working_HrStr = "";
    this.m_intime_Remark = "";
    this.m_outtime_Remark = "";
    this.m_in_Latitude = 0;
    this.m_in_Longitude = 0;
    this.m_out_Latitude = 0;
    this.m_out_Longitude = 0;
    this.m_notInRange = false;
    this.m_approved = false;
    this.m_approvedBy = 0;
    this.m_approvedDateTime = null;
    this.m_imp_Copy = false;
    this.m_qR_Pass = false;
  }
 */
/*
    Attd_CheckInOut.fromObject(dynamic o){
    this.m_tran_ID = o["tran_ID"] != null ? int.parse(o["tran_ID"]) : 0;
    this.m_emp_ID = o["emp_ID"] != null ? int.parse(o["emp_ID"]) : 0;
    this.m_log_Date = o["log_Date"] != null ? DateTime.parse(o["log_Date"]) : null;
    this.m_in_Time = o["in_Time"] != null ? int.parse(o["in_Time"]) : 0;
    this.m_in_TimeStr = o["in_TimeStr"] != null ? o["in_TimeStr"] as String : "";
    this.m_out_Time = o["out_Time"] != null ? int.parse(o["out_Time"]) : 0;
    this.m_out_TimeStr = o["out_TimeStr"] != null ? o["out_TimeStr"] as String : "";
    this.m_working_Hr = o["working_Hr"] != null ? int.parse(o["working_Hr"]) : 0;
    this.m_working_HrStr = o["working_HrStr"] != null ? o["working_HrStr"] as String : "";
    this.m_intime_Remark = o["intime_Remark"] != null ? o["intime_Remark"] as String : "";
    this.m_outtime_Remark = o["outtime_Remark"] != null ? o["outtime_Remark"] as String : "";
    this.m_in_Latitude = o["in_Latitude"] != null ? double.parse(o["in_Latitude"]) : 0;
    this.m_in_Longitude = o["in_Longitude"] != null ? double.parse(o["in_Longitude"]) : 0;
    this.m_out_Latitude = o["out_Latitude"] != null ? double.parse(o["out_Latitude"]) : 0;
    this.m_out_Longitude = o["out_Longitude"] != null ? double.parse(o["out_Longitude"]) : 0;
    this.m_notInRange = o["notInRange"] != null ? o["notInRange"] as bool : true;
    this.m_approved = o["approved"] != null ? o["approved"] as bool : false;
    this.m_approvedBy = o["approvedBy"] != null ? double.parse(o["approvedBy"]) : 0;
    this.m_approvedDateTime = o["approvedDateTime"] != null ? DateTime.parse(o["approvedDateTime"]) : null;
    this.m_imp_Copy = o["imp_Copy"] != null ? o["imp_Copy"] as bool : false;
    this.m_qR_Pass = o["qR_Pass"] != null ? o["qR_Pass"]  as bool: false;
  }

  factory Attd_CheckInOut.fromJson(Map<String, dynamic> json) => Attd_CheckInOut.WithId(
    m_tran_ID : json["data"]["tran_ID"] != null ? int.parse(json["data"]["tran_ID"] as String) : 0,
    m_emp_ID : json["data"]["emp_ID"] != null ? int.parse(json["data"]["emp_ID"] as String) : 0,
    m_log_Date : json["data"]["log_Date"] != null ? DateTime.parse(json["data"]["log_Date"] as String) : null,
    m_in_Time : json["data"]["in_Time"] != null ? int.parse(json["data"]["in_Time"] as String) : 0,
    m_in_TimeStr : json["data"]["in_TimeStr"] != null ? json["data"]["in_TimeStr"] as String : '',
    m_out_Time : json["data"]["out_Time"] != null ? int.parse(json["data"]["out_Time"] as String) : 0,
    m_out_TimeStr : json["data"]["out_TimeStr"] != null ? json["data"]["out_TimeStr"] as String : '',
    m_working_Hr : json["data"]["working_Hr"] != null ? int.parse(json["data"]["working_Hr"] as String) : 0,
    m_working_HrStr : json["data"]["working_HrStr"] != null ? json["data"]["working_HrStr"] as String : '',
    m_intime_Remark : json["data"]["intime_Remark"] != null ? json["data"]["intime_Remark"] as String : '',
    m_outtime_Remark : json["data"]["outtime_Remark"] != null ? json["data"]["outtime_Remark"] as String : '',
    m_in_Latitude : json["data"]["in_Latitude"] != null ? double.parse(json["data"]["in_Latitude"] as String) : 0,
    m_in_Longitude : json["data"]["in_Longitude"] != null ? double.parse(json["data"]["in_Longitude"] as String) : 0,
    m_out_Latitude : json["data"]["out_Latitude"] != null ? double.parse(json["data"]["out_Latitude"] as String) : 0,
    m_out_Longitude : json["data"]["out_Longitude"] != null ? double.parse(json["data"]["out_Longitude"] as String) : 0,
    m_notInRange : json["data"]["notInRange"] != null ? json["data"]["notInRange"] as bool : true,
    m_approved : json["data"]["approved"] != null ? json["data"]["approved"] as bool : false,
    m_approvedBy : json["data"]["approvedBy"] != null ? double.parse(json["data"]["approvedBy"] as String) : 0,
    m_approvedDateTime : json["data"]["approvedDateTime"] != null ? DateTime.parse(json["data"]["approvedDateTime"] as String) : null,
    m_imp_Copy : json["data"]["imp_Copy"] != null ? json["data"]["imp_Copy"] as bool : false,
    m_qR_Pass : json["data"]["qR_Pass"] != null ? json["data"]["qR_Pass"]  as bool: false,
  );
 */
}


