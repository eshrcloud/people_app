class Leave_Type {
  late int m_leave_Type_ID;
  late String m_leave_Type_Name;
  late String m_leave_Type_Code;
  late int? m_default_Value;
  late int? m_entitlement;
  late int? m_is_Sys;
  late int? m_yearly_Entitlement;
  late int? m_leave_Limit;
  late int? m_serviceOnEntitle;
  late int? m_duration;
  late int? m_job_Status_ID;
  late int? m_leave_Increase;
  late int? m_leave_Upto;
  late int? m_carry_Upto;
  late int? m_leaveReqBeforeDay;
  late double? m_editUserID;
  late DateTime? m_editDateTime;

  Leave_Type({ required this.m_leave_Type_Name, required this.m_leave_Type_Code,
    required this.m_default_Value, required this.m_entitlement, required this.m_is_Sys, required this.m_yearly_Entitlement,
    required this.m_leave_Limit, required this.m_serviceOnEntitle, required this.m_duration, required this.m_job_Status_ID,
    required this.m_leave_Increase, required this.m_leave_Upto, required this.m_carry_Upto, required this.m_leaveReqBeforeDay, required this.m_editUserID, required this.m_editDateTime
  });
  Leave_Type.WithId({ required this.m_leave_Type_ID, required this.m_leave_Type_Name, required this.m_leave_Type_Code,
    required this.m_default_Value, required this.m_entitlement, required this.m_is_Sys, required this.m_yearly_Entitlement,
    required this.m_leave_Limit, required this.m_serviceOnEntitle, required this.m_duration, required this.m_job_Status_ID,
    required this.m_leave_Increase, required this.m_leave_Upto, required this.m_carry_Upto, required this.m_leaveReqBeforeDay, required this.m_editUserID, required this.m_editDateTime
  });

  int get leave_Type_ID => m_leave_Type_ID;
  String get leave_Type_Name => m_leave_Type_Name;
  String get leave_Type_Code => m_leave_Type_Code;
  int? get default_Value => m_default_Value;
  int? get entitlement => m_entitlement;
  int? get is_Sys => m_is_Sys;
  int? get yearly_Entitlement => m_yearly_Entitlement;
  int? get leave_Limit => m_leave_Limit;
  int? get serviceOnEntitle => m_serviceOnEntitle;
  int? get duration => m_duration;
  int? get job_Status_ID => m_job_Status_ID;
  int? get leave_Increase => m_leave_Increase;
  int? get leave_Upto => m_leave_Upto;
  int? get carry_Upto => m_carry_Upto;
  int? get leaveReqBeforeDay => m_leaveReqBeforeDay;
  double? get editUserID => m_editUserID;
  DateTime? get editDateTime => m_editDateTime;

  set leave_Type_Name(String newleave_Type_Name){ m_leave_Type_Name = newleave_Type_Name; }
  set leave_Type_Code(String newleave_Type_Code){ m_leave_Type_Code = newleave_Type_Code; }
  set default_Value(int? newdefault_Value){ m_default_Value = newdefault_Value; }
  set entitlement(int? newentitlement){ m_entitlement = newentitlement; }
  set is_Sys(int? newis_Sys){ m_is_Sys = newis_Sys; }
  set yearly_Entitlement(int? newyearly_Entitlement){ m_yearly_Entitlement = newyearly_Entitlement; }
  set leave_Limit(int? newleave_Limit){ m_leave_Limit = newleave_Limit; }
  set serviceOnEntitle(int? newserviceOnEntitle){ m_serviceOnEntitle = newserviceOnEntitle; }
  set duration(int? newduration){ m_duration = newduration; }
  set job_Status_ID(int? newjob_Status_ID){ m_job_Status_ID = newjob_Status_ID; }
  set leave_Increase(int? newleave_Increase){ m_leave_Increase = newleave_Increase; }
  set leave_Upto(int? newleave_Upto){ m_leave_Upto = newleave_Upto; }
  set carry_Upto(int? newcarry_Upto){ m_carry_Upto = newcarry_Upto; }
  set leaveReqBeforeDay(int? newleaveReqBeforeDay){ m_leaveReqBeforeDay = newleaveReqBeforeDay; }
  set editUserID(double? neweditUserID){ m_editUserID = neweditUserID; }
  set editDateTime(DateTime? neweditDateTime){ m_editDateTime = neweditDateTime; }

  Map<String,dynamic> toMap(){
      var map=Map<String,dynamic>();
      map["leave_Type_Name"]=m_leave_Type_Name;
      map["leave_Type_Code"]=m_leave_Type_Code;
      map["default_Value"]=m_default_Value;
      map["entitlement"]=m_entitlement;
      map["is_Sys"]=m_is_Sys;
      map["yearly_Entitlement"]=m_yearly_Entitlement;
      map["leave_Limit"]=m_leave_Limit;
      map["serviceOnEntitle"]=m_serviceOnEntitle;
      map["duration"]=m_duration;
      map["job_Status_ID"]=m_job_Status_ID;
      map["leave_Increase"]=m_leave_Increase;
      map["leave_Upto"]=m_leave_Upto;
      map["carry_Upto"]=m_carry_Upto;
      map["leaveReqBeforeDay"]=m_leaveReqBeforeDay;
      map["editUserID"]=m_editUserID;
      map["editDateTime"]=m_editDateTime!.toIso8601String();

      if (m_leave_Type_ID!=null){
        map["leave_Type_ID"]=m_leave_Type_ID;
      }

      return map;
  }

  Leave_Type.fromObject(dynamic o){
    this.m_leave_Type_ID = o["leave_Type_ID"];
    this.m_leave_Type_Name = o["leave_Type_Name"];
    this.m_leave_Type_Code = o["leave_Type_Code"];
    this.m_default_Value = o["default_Value"];
    this.m_entitlement = o["entitlement"];
    this.m_is_Sys = o["is_Sys"];
    this.m_yearly_Entitlement = o["yearly_Entitlement"];
    this.m_leave_Limit = o["leave_Limit"];
    this.m_serviceOnEntitle = o["serviceOnEntitle"];
    this.m_duration = o["duration"];
    this.m_job_Status_ID = o["job_Status_ID"];
    this.m_leave_Increase = o["leave_Increase"];
    this.m_leave_Upto = o["leave_Upto"];
    this.m_carry_Upto = o["carry_Upto"];
    this.m_editUserID = o["editUserID"] != null ? double.parse(o["editUserID"].toString()) : null;
    this.m_editDateTime = o["editDateTime"] != null ? DateTime.parse(o["editDateTime"].toString()) : null;
  }
}


