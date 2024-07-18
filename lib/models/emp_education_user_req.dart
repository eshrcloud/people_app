class Emp_Education_User_Req {
  late int m_autoID;
  late double m_req_ID;
  late double? m_tran_ID;
  late double? m_emp_ID;
  late int? m_fromYear;
  late int? m_toYear;
  late int? m_edu_Type_ID;
  late String? m_edu_Desp;
  late int? m_degree_ID;
  late int? m_edu_Year;
  late String? m_institute_College;
  late String? m_remark;
  late int? m_year_Achieve;
  late String? m_location;
  late bool? m_new_Flag;
  late DateTime? m_req_Date;
  late  double?  m_editUserID;
  late  DateTime?  m_editDateTime;

  Emp_Education_User_Req({ required this.m_req_ID, required this.m_tran_ID, required this.m_emp_ID,
    required this.m_fromYear, required this.m_toYear, required this.m_edu_Type_ID, required this.m_edu_Desp,
    required this.m_degree_ID, required this.m_edu_Year, required this.m_institute_College, required this.m_remark,
    required this.m_year_Achieve, required this.m_location, required this.m_new_Flag, required this.m_req_Date, required this.m_editUserID, required this.m_editDateTime });

  Emp_Education_User_Req.WithId({ required this.m_autoID, required this.m_req_ID, required this.m_tran_ID, required this.m_emp_ID,
    required this.m_fromYear, required this.m_toYear, required this.m_edu_Type_ID, required this.m_edu_Desp,
    required this.m_degree_ID, required this.m_edu_Year, required this.m_institute_College, required this.m_remark,
    required this.m_year_Achieve, required this.m_location, required this.m_new_Flag, required this.m_req_Date, required this.m_editUserID, required this.m_editDateTime });

  int get autoID => m_autoID;
  double get req_ID => m_req_ID;
  double? get tran_ID => m_tran_ID;
  double? get emp_ID => m_emp_ID;
  int? get fromYear => m_fromYear;
  int? get toYear => m_toYear;
  int? get edu_Type_ID => m_edu_Type_ID;
  String? get edu_Desp => m_edu_Desp;
  int? get degree_ID => m_degree_ID;
  int? get edu_Year => m_edu_Year;
  String? get institute_College => m_institute_College;
  String? get remark => m_remark;
  int? get year_Achieve => m_year_Achieve;
  String? get location => m_location;
  bool? get new_Flag => m_new_Flag;
  DateTime? get req_Date => m_req_Date;
  double? get editUserID => m_editUserID;
  DateTime? get editDateTime => m_editDateTime;

  set autoID(int newautoID) { m_autoID = newautoID; }
  set req_ID(double newreq_ID) { m_req_ID = newreq_ID; }
  set tran_ID(double? newtran_ID) { m_tran_ID = newtran_ID; }
  set emp_ID(double? newemp_ID) { m_emp_ID = newemp_ID; }
  set fromYear(int? newfromYear) { m_fromYear = newfromYear; }
  set toYear(int? newtoYear) { m_toYear = newtoYear; }
  set edu_Type_ID(int? newedu_Type_ID) { m_edu_Type_ID = newedu_Type_ID; }
  set edu_Desp(String? newedu_Desp) { m_edu_Desp = newedu_Desp; }
  set degree_ID(int? newdegree_ID) { m_degree_ID = newdegree_ID; }
  set edu_Year(int? newedu_Year) { m_edu_Year = newedu_Year; }
  set institute_College(String? newinstitute_College) { m_institute_College = newinstitute_College; }
  set remark(String? newremark) { m_remark = newremark; }
  set year_Achieve(int? newyear_Achieve) { m_year_Achieve = newyear_Achieve; }
  set location(String? newlocation) { m_location = newlocation; }
  set new_Flag(bool? newnew_Flag) { m_new_Flag = newnew_Flag; }
  set req_Date(DateTime? newreq_Date) { m_req_Date = newreq_Date; }
  set editUserID(double? neweditUserID){ m_editUserID = neweditUserID; }
  set editDateTime(DateTime? neweditDateTime){ m_editDateTime = neweditDateTime; }

  Map<String,dynamic> toMap(){
      var map=Map<String,dynamic>();
      map["autoID"]=m_autoID != null ? m_autoID : 0;
      map["req_ID"]=m_req_ID;
      map["tran_ID"]=m_tran_ID;
      map["emp_ID"]=m_emp_ID;
      map["fromYear"]=m_fromYear;
      map["toYear"]=m_toYear;
      map["edu_Type_ID"]=m_edu_Type_ID;
      map["edu_Desp"]=m_edu_Desp;
      map["degree_ID"]=m_degree_ID;
      map["edu_Year"]=m_edu_Year;
      map["institute_College"]=m_institute_College;
      map["remark"]=m_remark;
      map["year_Achieve"]=m_year_Achieve;
      map["location"]=m_location;
      map["new_Flag"]=m_new_Flag;
      map["req_Date"]=m_req_Date!.toIso8601String();
      map["editUserID"]=m_editUserID;
      map["editDateTime"]=m_editDateTime!.toIso8601String();

      return map;
  }

  Emp_Education_User_Req.fromObject(dynamic o){
    this.m_autoID = int.parse(o["autoID"].toString());
    this.m_req_ID = double.parse(o["req_ID"].toString());
    this.m_tran_ID = double.parse(o["tran_ID"].toString());
    this.m_emp_ID = double.parse(o["emp_ID"].toString());
    this.m_fromYear = o["fromYear"] != null ? int.parse(o["fromYear"].toString()) : null;
    this.m_toYear = o["toYear"] != null ? int.parse(o["toYear"].toString()) : null;
    this.m_edu_Type_ID = o["edu_Type_ID"] != null ? int.parse(o["edu_Type_ID"].toString()) : null;
    this.m_edu_Desp = o["edu_Desp"];
    this.m_degree_ID = o["degree_ID"] != null ? int.parse(o["degree_ID"].toString()) : null;
    this.m_edu_Year = o["edu_Year"] != null ? int.parse(o["edu_Year"].toString()) : null;
    this.m_institute_College = o["institute_College"];
    this.m_remark = o["remark"];
    this.m_year_Achieve = o["year_Achieve"] != null ? int.parse(o["year_Achieve"].toString()) : null;
    this.m_location = o["location"];
    this.m_new_Flag = o["new_Flag"];
    this.m_req_Date = o["req_Date"] != null ? DateTime.parse(o["req_Date"].toString()) : null;
    this.m_editUserID = o["editUserID"] != null ? double.parse(o["editUserID"].toString()) : null;
    this.m_editDateTime = o["editDateTime"] != null ? DateTime.parse(o["editDateTime"].toString()) : null;
  }
}


