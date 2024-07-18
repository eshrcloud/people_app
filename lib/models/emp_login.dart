class Emp_Login {
  late double m_emp_ID;
  late String m_emp_Short;
  late String m_emp_Name;
  late String m_password;
  late int m_level_ID;
  late int m_active;
  late  double?  m_editUserID;
  late  DateTime?  m_editDateTime;

  Emp_Login({ required this.m_emp_Short, required this.m_emp_Name, required this.m_password, required this.m_level_ID, required this.m_editUserID, required this.m_active, required this.m_editDateTime });
  Emp_Login.WithId({ required this.m_emp_ID, required this.m_emp_Short, required this.m_emp_Name, required this.m_password, required this.m_level_ID, required this.m_active, required this.m_editUserID, required this.m_editDateTime });

  double get emp_ID => m_emp_ID;
  String get emp_Short => m_emp_Short;
  String get emp_Name => m_emp_Name;
  String get password => m_password;
  int get level_ID => m_level_ID;
  int get active => m_active;
  double? get editUserID => m_editUserID;
  DateTime? get editDateTime => m_editDateTime;

  set emp_Short(String newemp_Short)
  {
    m_emp_Short = newemp_Short;
  }

  set emp_Name(String newemp_Name)
  {
    m_emp_Name = newemp_Name;
  }

  set password(String newpassword)
  {
    m_password = newpassword;
  }

  set level_ID(int newlevel_ID)
  {
    m_level_ID = newlevel_ID;
  }

  set active(int newactive){ m_active = newactive; }
  set editUserID(double? neweditUserID){ m_editUserID = neweditUserID; }
  set editDateTime(DateTime? neweditDateTime){ m_editDateTime = neweditDateTime; }

  Map<String,dynamic> toMap(){
      var map=Map<String,dynamic>();
      map["emp_Short"]=m_emp_Short;
      map["emp_Name"]=m_emp_Name;
      map["password"]=m_password;
      map["level_ID"]=m_level_ID;
      map["active"]=m_active;
      map["editUserID"]=m_editUserID;
      map["editDateTime"]=m_editDateTime!.toIso8601String();

      if (m_emp_ID!=null){
        map["emp_ID"]=m_emp_ID;
      }

      return map;
  }

  Emp_Login.fromObject(dynamic o){
    this.m_emp_ID = double.parse(o["emp_ID"].toString());
    this.m_emp_Short = o["emp_Short"];
    this.m_emp_Name = o["emp_Name"];
    this.m_password = o["password"];
    this.m_level_ID = o["level_ID"];
    this.m_active = o["active"] != null ? o["active"] : 0;
    this.m_editUserID = o["editUserID"] != null ? double.parse(o["editUserID"].toString()) : 0.0;
    this.m_editDateTime = o["editDateTime"] != null ? DateTime.parse(o["editDateTime"]) : null;
  }
}


