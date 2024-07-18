class PaySheet {
  late double m_sheet_ID;
  late String m_sheet_Name;
  late int? m_year;
  late int? m_month;
  late String m_dept_ID;
  late bool? m_includeSub;
  late int? m_rounding;
  late int? m_salary_Type_ID;
  late int m_parent_Sheet_ID;
  late int m_type;
  late DateTime? m_sStart_Date;
  late DateTime? m_sEnd_Date;
  late bool? m_isProtected;
  late double? m_user_ID;
  late double? m_editUserID;
  late DateTime? m_editDateTime;

  PaySheet({ required this.m_sheet_Name, required this.m_year,
    required this.m_month, required this.m_dept_ID, required this.m_includeSub, required this.m_rounding,
    required this.m_salary_Type_ID, required this.m_parent_Sheet_ID, required this.m_type, required this.m_sStart_Date,
    required this.m_sEnd_Date, required this.m_isProtected, required this.m_user_ID, required this.m_editUserID, required this.m_editDateTime
  });
  PaySheet.WithId({ required this.m_sheet_ID, required this.m_sheet_Name, required this.m_year,
    required this.m_month, required this.m_dept_ID, required this.m_includeSub, required this.m_rounding,
    required this.m_salary_Type_ID, required this.m_parent_Sheet_ID, required this.m_type, required this.m_sStart_Date,
    required this.m_sEnd_Date, required this.m_isProtected, required this.m_user_ID, required this.m_editUserID, required this.m_editDateTime
  });

  double get sheet_ID => m_sheet_ID;
  String get sheet_Name => m_sheet_Name;
  int? get year => m_year;
  int? get month => m_month;
  String get dept_ID => m_dept_ID;
  bool? get includeSub => m_includeSub;
  int? get rounding => m_rounding;
  int? get salary_Type_ID => m_salary_Type_ID;
  int get parent_Sheet_ID => m_parent_Sheet_ID;
  int get type => m_type;
  DateTime? get sStart_Date => m_sStart_Date;
  DateTime? get sEnd_Date => m_sEnd_Date;
  bool? get isProtected => m_isProtected;
  double? get user_ID => m_user_ID;
  double? get editUserID => m_editUserID;
  DateTime? get editDateTime => m_editDateTime;

  set sheet_Name(String newsheet_Name){ m_sheet_Name = newsheet_Name; }
  set year(int? newyear){ m_year = newyear; }
  set month(int? newmonth){ m_month = newmonth; }
  set dept_ID(String newdept_ID){ m_dept_ID = newdept_ID; }
  set includeSub(bool? newincludeSub){ m_includeSub = newincludeSub; }
  set rounding(int? newrounding){ m_rounding = newrounding; }
  set salary_Type_ID(int? newsalary_Type_ID){ m_salary_Type_ID = newsalary_Type_ID; }
  set parent_Sheet_ID(int newparent_Sheet_ID){ m_parent_Sheet_ID = newparent_Sheet_ID; }
  set type(int newtype){ m_type = newtype; }
  set sStart_Date(DateTime? newsStart_Date){ m_sStart_Date = newsStart_Date; }
  set sEnd_Date(DateTime? newsEnd_Date){ m_sEnd_Date = newsEnd_Date; }
  set isProtected(bool? newisProtected){ m_isProtected = newisProtected; }
  set user_ID(double? newuser_ID){ m_user_ID = newuser_ID; }
  set editUserID(double? neweditUserID){ m_editUserID = neweditUserID; }
  set editDateTime(DateTime? neweditDateTime){ m_editDateTime = neweditDateTime; }

  Map<String,dynamic> toMap(){
      var map=Map<String,dynamic>();
      map["sheet_Name"]=m_sheet_Name;
      map["year"]=m_year;
      map["month"]=m_month;
      map["dept_ID"]=m_dept_ID;
      map["includeSub"]=m_includeSub;
      map["rounding"]=m_rounding;
      map["salary_Type_ID"]=m_salary_Type_ID;
      map["parent_Sheet_ID"]=m_parent_Sheet_ID;
      map["type"]=m_type;
      map["sStart_Date"]=m_sStart_Date;
      map["sEnd_Date"]=m_sEnd_Date;
      map["isProtected"]=m_isProtected;
      map["user_ID"]=m_user_ID;
      map["editUserID"]=m_editUserID;
      map["editDateTime"]=m_editDateTime!.toIso8601String();

      if (m_sheet_ID!=null){
        map["sheet_ID"]=m_sheet_ID;
      }

      return map;
  }

  PaySheet.fromObject(dynamic o){
    this.m_sheet_ID = double.parse(o["sheet_ID"].toString());
    this.m_sheet_Name = o["sheet_Name"];
    this.m_year = o["year"] != null ? int.parse(o["year"].toString()) : null;
    this.m_month = o["month"] != null ? int.parse(o["month"].toString()) : null;
    this.m_dept_ID = o["dept_ID"] != null ? o["dept_ID"].toString() : "";
    this.m_includeSub = o["includeSub"];
    this.m_rounding = o["rounding"];
    this.m_salary_Type_ID = o["salary_Type_ID"] != null ? int.parse(o["salary_Type_ID"].toString()) : null;
    this.m_parent_Sheet_ID = int.parse(o["parent_Sheet_ID"].toString());
    this.m_type = int.parse(o["type"].toString());
    this.m_sStart_Date = o["sStart_Date"] != null ? DateTime.parse(o["sStart_Date"].toString()) : null;
    this.m_sEnd_Date = o["sEnd_Date"] != null ? DateTime.parse(o["sEnd_Date"].toString()) : null;
    this.m_isProtected = o["isProtected"];
    this.m_user_ID = o["user_ID"] != null ? double.parse(o["user_ID"].toString()) : null;
    this.m_editUserID = o["editUserID"] != null ? double.parse(o["editUserID"].toString()) : null;
    this.m_editDateTime = o["editDateTime"] != null ? DateTime.parse(o["editDateTime"].toString()) : null;
  }
}


