class PaySlip_Detail {
  late double m_slipDetail_ID;
  late double? m_slip_ID;
  late double? m_sheet_ID;
  late String? m_sheet_Name;
  late double? m_emp_ID;
  late int? m_rule_ID;
  late String? m_rule_Name;
  late int? m_rType_ID;
  late String? m_rType_Name;
  late int? m_pMonth;
  late int? m_pYear;
  late int? m_salary_Currency;
  late String? m_salary_Currency_Name;
  late double? m_basic_Pay;
  late double? m_award_Amt;
  late double? m_deduct_Amt;
  late double? m_net_Amt;
  late double? m_aD_Amt;
  late double? m_basic_Pay_Kyat;
  late double? m_award_Amt_Kyat;
  late double? m_deduct_Amt_Kyat;
  late double? m_net_Amt_Kyat;
  late double? m_aD_Amt_Kyat;
  late String? m_remark;
  late double? m_editUserID;
  late DateTime? m_editDateTime;

  PaySlip_Detail({ required this.m_slip_ID, required this.m_sheet_ID, required this.m_sheet_Name, required this.m_emp_ID,
    required this.m_rule_ID, required this.m_rule_Name, required this.m_rType_ID, required this.m_rType_Name, required this.m_pMonth, required this.m_pYear,
    required this.m_salary_Currency, required this.m_salary_Currency_Name, required this.m_basic_Pay, required this.m_award_Amt, required this.m_deduct_Amt, required this.m_net_Amt, required this.m_aD_Amt,
    required this.m_basic_Pay_Kyat, required this.m_award_Amt_Kyat, required this.m_deduct_Amt_Kyat, required this.m_net_Amt_Kyat, required this.m_aD_Amt_Kyat,
    required this.m_remark, required this.m_editUserID, required this.m_editDateTime
  });
  PaySlip_Detail.WithId({ required this.m_slipDetail_ID, required this.m_slip_ID, required this.m_sheet_ID, required this.m_sheet_Name, required this.m_emp_ID,
    required this.m_rule_ID, required this.m_rule_Name, required this.m_rType_ID, required this.m_rType_Name, required this.m_pMonth, required this.m_pYear,
    required this.m_salary_Currency, required this.m_salary_Currency_Name, required this.m_basic_Pay, required this.m_award_Amt, required this.m_deduct_Amt, required this.m_net_Amt, required this.m_aD_Amt,
    required this.m_basic_Pay_Kyat, required this.m_award_Amt_Kyat, required this.m_deduct_Amt_Kyat, required this.m_net_Amt_Kyat, required this.m_aD_Amt_Kyat,
    required this.m_remark, required this.m_editUserID, required this.m_editDateTime
  });

  double get slipDetail_ID => m_slipDetail_ID;
  double? get slip_ID => m_slip_ID;
  double? get sheet_ID => m_sheet_ID;
  String? get sheet_Name => m_sheet_Name;
  double? get emp_ID => m_emp_ID;
  int? get rule_ID => m_rule_ID;
  String? get rule_Name => m_rule_Name;
  int? get rType_ID => m_rType_ID;
  String? get rType_Name => m_rType_Name;
  int? get pMonth => m_pMonth;
  int? get pYear => m_pYear;
  int? get salary_Currency => m_salary_Currency;
  String? get salary_Currency_Name => m_salary_Currency_Name;
  double? get basic_Pay => m_basic_Pay;
  double? get award_Amt => m_award_Amt;
  double? get deduct_Amt => m_deduct_Amt;
  double? get net_Amt => m_net_Amt;
  double? get aD_Amt => m_aD_Amt;
  double? get basic_Pay_Kyat => m_basic_Pay_Kyat;
  double? get award_Amt_Kyat => m_award_Amt_Kyat;
  double? get deduct_Amt_Kyat => m_deduct_Amt_Kyat;
  double? get net_Amt_Kyat => m_net_Amt_Kyat;
  String? get remark => m_remark;
  double? get editUserID => m_editUserID;
  DateTime? get editDateTime => m_editDateTime;

  set slipDetail_ID(double newslipDetail_ID){ m_slipDetail_ID = newslipDetail_ID; }
  set slip_ID(double? newslip_ID){ m_slip_ID = newslip_ID; }
  set sheet_ID(double? newsheet_ID){ m_sheet_ID = newsheet_ID; }
  set sheet_Name(String? newsheet_Name){ m_sheet_Name = newsheet_Name; }
  set emp_ID(double? newemp_ID){ m_emp_ID = newemp_ID; }
  set rule_ID(int? newrule_ID){ m_rule_ID = newrule_ID; }
  set rule_Name(String? newrule_Name){ m_rule_Name = newrule_Name; }
  set rType_ID(int? newrType_ID){ m_rType_ID = newrType_ID; }
  set rType_Name(String? newrType_Name){ m_rType_Name = newrType_Name; }
  set pMonth(int? newpMonth){ m_pMonth = newpMonth; }
  set pYear(int? newpYear){ m_pYear = newpYear; }
  set salary_Currency(int? newsalary_Currency){ m_salary_Currency = newsalary_Currency; }
  set salary_Currency_Name(String? newsalary_Currency_Name){ m_salary_Currency_Name = newsalary_Currency_Name; }
  set basic_Pay(double? newbasic_Pay){ m_basic_Pay = newbasic_Pay; }
  set award_Amt(double? newaward_Amt){ m_award_Amt = newaward_Amt; }
  set deduct_Amt(double? newdeduct_Amt){ m_deduct_Amt = newdeduct_Amt; }
  set net_Amt(double? newnet_Amt){ m_net_Amt = newnet_Amt; }
  set aD_Amt(double? newaD_Amt){ m_aD_Amt = newaD_Amt; }
  set basic_Pay_Kyat(double? newbasic_Pay_Kyat){ m_basic_Pay_Kyat = newbasic_Pay_Kyat; }
  set award_Amt_Kyat(double? newaward_Amt_Kyat){ m_award_Amt_Kyat = newaward_Amt_Kyat; }
  set deduct_Amt_Kyat(double? newdeduct_Amt_Kyat){ m_deduct_Amt_Kyat = newdeduct_Amt_Kyat; }
  set net_Amt_Kyat(double? newnet_Amt_Kyat){ m_net_Amt_Kyat = newnet_Amt_Kyat; }
  set aD_Amt_Kyat(double? newaD_Amt_Kyat){ m_aD_Amt_Kyat = newaD_Amt_Kyat; }
  set remark(String? newremark){ m_remark = newremark; }
  set editUserID(double? neweditUserID){ m_editUserID = neweditUserID; }
  set editDateTime(DateTime? neweditDateTime){ m_editDateTime = neweditDateTime; }

  Map<String,dynamic> toMap(){
      var map=Map<String,dynamic>();
      map["slipDetail_ID"]=m_slipDetail_ID;
      map["slip_ID"]=m_slip_ID;
      map["sheet_ID"]=m_sheet_ID;
      map["sheet_Name"]=m_sheet_Name;
      map["emp_ID"]=m_emp_ID;
      map["rule_ID"]=m_rule_ID;
      map["rule_Name"]=m_rule_Name;
      map["rType_ID"]=m_rType_ID;
      map["rType_Name"]=m_rType_Name;
      map["pMonth"]=m_pMonth;
      map["pYear"]=m_pYear;
      map["salary_Currency"]=m_salary_Currency;
      map["salary_Currency_Name"]=m_salary_Currency_Name;
      map["basic_Pay"]=m_basic_Pay;
      map["award_Amt"]=m_award_Amt;
      map["deduct_Amt"]=m_deduct_Amt;
      map["net_Amt"]=m_net_Amt;
      map["aD_Amt"]=m_aD_Amt;
      map["basic_Pay_Kyat"]=m_basic_Pay_Kyat;
      map["award_Amt_Kyat"]=m_award_Amt_Kyat;
      map["deduct_Amt_Kyat"]=m_deduct_Amt_Kyat;
      map["net_Amt_Kyat"]=m_net_Amt_Kyat;
      map["aD_Amt_Kyat"]=m_aD_Amt_Kyat;
      map["remark"]=m_remark;
      map["editUserID"]=m_editUserID;
      map["editDateTime"]=m_editDateTime!.toIso8601String();

      if (m_slipDetail_ID!=null){
        map["slipDetail_ID"]=m_slipDetail_ID;
      }

      return map;
  }

  PaySlip_Detail.fromObject(dynamic o){
    this.m_slipDetail_ID = double.parse(o["slipDetail_ID"].toString());
    this.m_slip_ID = double.parse(o["slip_ID"].toString());
    this.m_sheet_ID = double.parse(o["sheet_ID"].toString());
    this.m_sheet_Name = o["sheet_Name"];
    this.m_emp_ID = o["emp_ID"] != null ? double.parse(o["emp_ID"].toString()) : 0.0;
    this.m_rule_ID = o["rule_ID"] != null ? int.parse(o["rule_ID"].toString()) : 0;
    this.m_rule_Name = o["rule_Name"];
    this.m_rType_ID = o["rType_ID"] != null ? int.parse(o["rType_ID"].toString()) : 0;
    this.m_rType_Name = o["rType_Name"];
    this.m_pMonth = o["pMonth"] != null ? int.parse(o["pMonth"].toString()) : 0;
    this.m_pYear = o["pYear"] != null ? int.parse(o["pYear"].toString()) : 0;
    this.m_salary_Currency = o["salary_Currency"] != null ? int.parse(o["salary_Currency"].toString()) : 0;
    this.m_salary_Currency_Name = o["salary_Currency_Name"].toString();
    this.m_basic_Pay = o["basic_Pay"] != null ? double.parse(o["basic_Pay"].toString()) : 0.0;
    this.m_award_Amt = o["award_Amt"] != null ? double.parse(o["award_Amt"].toString()) : 0.0;
    this.m_deduct_Amt = o["deduct_Amt"] != null ? double.parse(o["deduct_Amt"].toString()) : 0.0;
    this.m_net_Amt = o["net_Amt"] != null ? double.parse(o["net_Amt"].toString()) : 0.0;
    this.m_aD_Amt = o["aD_Amt"] != null ? double.parse(o["aD_Amt"].toString()) : 0.0;
    this.m_basic_Pay_Kyat = o["basic_Pay_Kyat"] != null ? double.parse(o["basic_Pay_Kyat"].toString()) : 0.0;
    this.m_award_Amt_Kyat = o["award_Amt_Kyat"] != null ? double.parse(o["award_Amt_Kyat"].toString()) : 0.0;
    this.m_deduct_Amt_Kyat = o["deduct_Amt_Kyat"] != null ? double.parse(o["deduct_Amt_Kyat"].toString()) : 0.0;
    this.m_net_Amt_Kyat = o["net_Amt_Kyat"] != null ? double.parse(o["net_Amt_Kyat"].toString()) : 0.0;
    this.m_aD_Amt_Kyat = o["aD_Amt_Kyat"] != null ? double.parse(o["aD_Amt_Kyat"].toString()) : 0.0;
    this.m_remark = o["remark"].toString();
    this.m_editUserID = o["editUserID"] != null ? double.parse(o["editUserID"].toString()) : null;
    this.m_editDateTime = o["editDateTime"] != null ? DateTime.parse(o["editDateTime"].toString()) : null;
  }
}


