class Leave_Request_His {
  late double m_req_ID;
  late double? m_emp_ID;
  late double? m_card_ID;
  late int? m_post_ID;
  late int? m_dept_ID;
  late DateTime? m_request_Date;
  late int? m_leave_Type_ID;
  late DateTime? m_from_Date;
  late DateTime? m_to_Date;
  late double? m_days;
  late int? m_hLV_Status;
  late String m_reason;
  late int? m_status;
  late int? m_approve_Emp_ID;
  late DateTime? m_approve_Date;
  late String m_remark;
  late String m_attach_Type;
  late  double?  m_editUserID;
  late  DateTime?  m_editDateTime;

  Leave_Request_His({ required this.m_emp_ID, required this.m_card_ID,
    required this.m_post_ID, required this.m_dept_ID, required this.m_request_Date, required this.m_leave_Type_ID,
    required this.m_from_Date, required this.m_to_Date, required this.m_days, required this.m_hLV_Status, required this.m_reason, required this.m_status,
    required this.m_approve_Emp_ID, required this.m_approve_Date, required this.m_remark, required this.m_attach_Type, required this.m_editUserID, required this.m_editDateTime
  });
  Leave_Request_His.WithId({ required this.m_req_ID, required this.m_emp_ID, required this.m_card_ID,
    required this.m_post_ID, required this.m_dept_ID, required this.m_request_Date, required this.m_leave_Type_ID,
    required this.m_from_Date, required this.m_to_Date, required this.m_days, required this.m_hLV_Status, required this.m_reason, required this.m_status,
    required this.m_approve_Emp_ID, required this.m_approve_Date, required this.m_remark, required this.m_attach_Type, required this.m_editUserID, required this.m_editDateTime
  });

  double get req_ID => m_req_ID;
  double? get emp_ID => m_emp_ID;
  double? get card_ID => m_card_ID;
  int? get post_ID => m_post_ID;
  int? get dept_ID => m_dept_ID;
  DateTime? get request_Date => m_request_Date;
  int? get leave_Type_ID => m_leave_Type_ID;
  DateTime? get from_Date => m_from_Date;
  DateTime? get to_Date => m_to_Date;
  double? get days => m_days;
  int? get hLV_Status => m_hLV_Status;
  String get reason => m_reason;
  int? get status => m_status;
  int? get approve_Emp_ID => m_approve_Emp_ID;
  DateTime? get approve_Date => m_approve_Date;
  String get remark => m_remark;
  String get attach_Type => m_attach_Type;
  double? get editUserID => m_editUserID;
  DateTime? get editDateTime => m_editDateTime;

  set req_ID(double newreq_ID){ m_req_ID = newreq_ID; }
  set emp_ID(double? newemp_ID){ m_emp_ID = newemp_ID; }
  set card_ID(double? newcard_ID){ m_card_ID = newcard_ID; }
  set post_ID(int? newpost_ID){ m_post_ID = newpost_ID; }
  set dept_ID(int? newdept_ID){ m_dept_ID = newdept_ID; }
  set request_Date(DateTime? newrequest_Date){ m_request_Date = newrequest_Date; }
  set leave_Type_ID(int? newleave_Type_ID){ m_leave_Type_ID = newleave_Type_ID; }
  set from_Date(DateTime? newfrom_Date){ m_from_Date = newfrom_Date; }
  set to_Date(DateTime? newto_Date){ m_to_Date = newto_Date; }
  set days(double? newdays){ m_days = newdays; }
  set hLV_Status(int? newhLV_Status){ m_hLV_Status = newhLV_Status; }
  set reason(String newreason){ m_reason = newreason; }
  set status(int? newstatus){ m_status = newstatus; }
  set approve_Emp_ID(int? newapprove_Emp_ID){ m_approve_Emp_ID = newapprove_Emp_ID; }
  set approve_Date(DateTime? newapprove_Date){ m_approve_Date = newapprove_Date; }
  set remark(String newremark){ m_remark = newremark; }
  set attach_Type(String newattach_Type){ m_attach_Type = newattach_Type; }
  set editUserID(double? neweditUserID){ m_editUserID = neweditUserID; }
  set editDateTime(DateTime? neweditDateTime){ m_editDateTime = neweditDateTime; }

  Map<String,dynamic> toMap(){
      var map=Map<String,dynamic>();
      map["emp_ID"]=m_emp_ID;
      map["card_ID"]=m_card_ID;
      map["dept_ID"]=m_dept_ID;
      map["request_Date"]=m_request_Date!.toIso8601String();
      map["leave_Type_ID"]=m_leave_Type_ID;
      map["from_Date"]=m_from_Date!.toIso8601String();
      map["to_Date"]=m_to_Date!.toIso8601String();
      map["days"]=m_days;
      map["hLV_Status"]=m_hLV_Status;
      map["reason"]=m_reason;
      map["status"]=m_status;
      map["approve_Emp_ID"]=m_approve_Emp_ID;
      map["approve_Date"]=m_approve_Date!.toIso8601String();
      map["remark"]=m_remark;
      map["attach_Type"]=m_attach_Type;
      map["editUserID"]=m_editUserID;
      map["editDateTime"]=m_editDateTime!.toIso8601String();

      if (m_req_ID!=null){
        map["req_ID"]=m_req_ID;
      }

      return map;
  }

  Leave_Request_His.fromObject(dynamic o){
    this.m_req_ID = o["req_ID"] != null ? o["req_ID"] : 0;
    this.m_emp_ID = o["emp_ID"] != null ? o["emp_ID"] : 0;
    this.m_card_ID = o["card_ID"] != null ? o["card_ID"] : -9;
    this.m_dept_ID = o["dept_ID"] != null ? o["dept_ID"] : 0;
    this.m_request_Date = o["request_Date"] != null ? DateTime.parse(o["request_Date"]) : null;
    this.m_leave_Type_ID = o["leave_Type_ID"] != null ? o["leave_Type_ID"] : 0;
    this.m_from_Date = o["from_Date"] != null ? DateTime.parse(o["from_Date"]) : null;
    this.m_to_Date = o["to_Date"] != null ? DateTime.parse(o["to_Date"]) : null;
    this.m_days = o["days"] != null ? o["days"] : 0;
    this.m_hLV_Status = o["hLV_Status"] != null ? o["hLV_Status"] : 0;
    this.m_reason = o["reason"] != null ? o["reason"] : '';
    this.m_status = o["status"] != null ? o["status"] : 1;
    this.m_approve_Emp_ID = o["approve_Emp_ID"] != null ? o["approve_Emp_ID"] : 0;
    this.m_approve_Date = o["approve_Date"] != null ? DateTime.parse(o["approve_Date"]) : null;
    this.m_remark = o["remark"] != null ? o["remark"] : '';
    this.m_attach_Type = o["attach_Type"] != null ? o["attach_Type"] : '';
    this.m_editUserID = o["editUserID"] != null ? double.parse(o["editUserID"].toString()) : null;
    this.m_editDateTime = o["editDateTime"] != null ? DateTime.parse(o["editDateTime"].toString()) : null;
  }
}


