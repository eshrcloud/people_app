class Leave_Balance_Tmp {
  late double m_tran_ID;
  late double? m_emp_ID;
  late int? m_leave_Type_ID;
  late int? m_year;
  late int? m_entitlement;
  late int? m_user_ID;
  late String m_leave_Type_Name;
  late double? m_total_Leave;
  late double? m_total_Leave_Entitlement;
  late double? m_leave_Balance;

  Leave_Balance_Tmp({ required this.m_emp_ID, required this.m_leave_Type_ID,
    required this.m_year, required this.m_entitlement, required this.m_user_ID, required this.m_leave_Type_Name,
    required this.m_total_Leave, required this.m_total_Leave_Entitlement, required this.m_leave_Balance
  });
  Leave_Balance_Tmp.WithId({ required this.m_tran_ID, required this.m_emp_ID, required this.m_leave_Type_ID,
    required this.m_year, required this.m_entitlement, required this.m_user_ID, required this.m_leave_Type_Name,
    required this.m_total_Leave, required this.m_total_Leave_Entitlement, required this.m_leave_Balance
  });

  double get tran_ID => m_tran_ID;
  double? get emp_ID => m_emp_ID;
  int? get leave_Type_ID => m_leave_Type_ID;
  int? get year => m_year;
  int? get entitlement => m_entitlement;
  int? get user_ID => m_user_ID;
  String get leave_Type_Name => m_leave_Type_Name;
  double? get total_Leave => m_total_Leave;
  double? get total_Leave_Entitlement => m_total_Leave_Entitlement;
  double? get leave_Balance => m_leave_Balance;

  set emp_ID(double? newemp_ID){ m_emp_ID = newemp_ID; }
  set leave_Type_ID(int? newleave_Type_ID){ m_leave_Type_ID = newleave_Type_ID; }
  set year(int? newyear){ m_year = newyear; }
  set entitlement(int? newentitlement){ m_entitlement = newentitlement; }
  set user_ID(int? newuser_ID){ m_user_ID = newuser_ID; }
  set leave_Type_Name(String newleave_Type_Name){ m_leave_Type_Name = newleave_Type_Name; }
  set total_Leave(double? newtotal_Leave){ m_total_Leave = newtotal_Leave; }
  set total_Leave_Entitlement(double? newtotal_Leave_Entitlement){ m_total_Leave_Entitlement = newtotal_Leave_Entitlement; }
  set leave_Balance(double? newleave_Balance){ m_leave_Balance = newleave_Balance; }

  Map<String,dynamic> toMap(){
      var map=Map<String,dynamic>();
      map["emp_ID"]=m_emp_ID;
      map["leave_Type_ID"]=m_leave_Type_ID;
      map["year"]=m_year;
      map["entitlement"]=m_entitlement;
      map["user_ID"]=m_user_ID;
      map["leave_Type_Name"]=m_leave_Type_Name;
      map["total_Leave"]=m_total_Leave;
      map["total_Leave_Entitlement"]=m_total_Leave_Entitlement;
      map["leave_Balance"]=m_leave_Balance;

      if (m_tran_ID!=null){
        map["tran_ID"]=m_tran_ID;
      }

      return map;
  }

  Leave_Balance_Tmp.fromObject(dynamic o){
    this.m_tran_ID = double.parse(o["tran_ID"].toString());
    this.m_emp_ID = double.parse(o["emp_ID"].toString());
    this.m_leave_Type_ID = int.parse(o["leave_Type_ID"].toString());
    this.m_year = o["year"] != null ? int.parse(o["year"].toString()) : 0;
    this.m_entitlement = o["entitlement"] != null ? int.parse(o["entitlement"].toString()) : 0;
    this.m_user_ID = o["user_ID"] != null ? int.parse(o["user_ID"].toString()) : 0;
    this.m_leave_Type_Name = o["leave_Type_Name"] != null ? o["leave_Type_Name"] : '';
    this.m_total_Leave = o["total_Leave"] != null ? double.parse(o["total_Leave"].toString()) : 0;
    this.m_total_Leave_Entitlement = o["total_Leave_Entitlement"] != null ? double.parse(o["total_Leave_Entitlement"].toString()) : 0;
    this.m_leave_Balance = o["leave_Balance"] != null ? double.parse(o["leave_Balance"].toString()) : 0;
  }
}


