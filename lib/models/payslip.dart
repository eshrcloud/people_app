class PaySlip {
  late double m_slip_ID;
  late double m_emp_ID;
  late double m_sheet_ID;
  late int m_dept_ID;
  late int m_post_ID;
  late int? m_grade_ID;
  late int? m_pMonth;
  late int? m_pYear;
  late int? m_salary_Currency;
  late double? m_basic_Pay;
  late String m_basic_PayEnc;
  late double? m_award_Amt;
  late String m_award_AmtEnc;
  late double? m_deduct_Amt;
  late String m_deduct_AmtEnc;
  late double? m_net_Amt;
  late String m_net_AmtEnc;
  late int m_eFlag;
  late String m_bank_Acct_No;
  late double? m_basic_Pay_Kyat;
  late double? m_award_Amt_Kyat;
  late double? m_deduct_Amt_Kyat;
  late double? m_net_Amt_Kyat;
  late double? m_editUserID;
  late DateTime? m_editDateTime;

  PaySlip({ required this.m_emp_ID, required this.m_sheet_ID,
    required this.m_post_ID, required this.m_dept_ID, required this.m_grade_ID, required this.m_pMonth,
    required this.m_pYear, required this.m_salary_Currency, required this.m_basic_Pay, required this.m_basic_PayEnc, required this.m_award_Amt,
    required this.m_award_AmtEnc, required this.m_deduct_Amt, required this.m_deduct_AmtEnc,
    required this.m_net_Amt, required this.m_net_AmtEnc, required this.m_eFlag, required this.m_bank_Acct_No,
    required this.m_basic_Pay_Kyat, required this.m_award_Amt_Kyat, required this.m_deduct_Amt_Kyat, required this.m_net_Amt_Kyat,
    required this.m_editUserID, required this.m_editDateTime
  });
  PaySlip.WithId({ required this.m_slip_ID, required this.m_emp_ID, required this.m_sheet_ID,
    required this.m_post_ID, required this.m_dept_ID, required this.m_grade_ID, required this.m_pMonth,
    required this.m_pYear, required this.m_salary_Currency, required this.m_basic_Pay, required this.m_basic_PayEnc, required this.m_award_Amt,
    required this.m_award_AmtEnc, required this.m_deduct_Amt, required this.m_deduct_AmtEnc,
    required this.m_net_Amt, required this.m_net_AmtEnc, required this.m_eFlag, required this.m_bank_Acct_No,
    required this.m_basic_Pay_Kyat, required this.m_award_Amt_Kyat, required this.m_deduct_Amt_Kyat, required this.m_net_Amt_Kyat,
    required this.m_editUserID, required this.m_editDateTime
  });

  double get slip_ID => m_slip_ID;
  double get emp_ID => m_emp_ID;
  double get sheet_ID => m_sheet_ID;
  int get dept_ID => m_dept_ID;
  int get post_ID => m_post_ID;
  int? get grade_ID => m_grade_ID;
  int? get pMonth => m_pMonth;
  int? get pYear => m_pYear;
  int? get salary_Currency => m_salary_Currency;
  double? get basic_Pay => m_basic_Pay;
  String get basic_PayEnc => m_basic_PayEnc;
  double? get award_Amt => m_award_Amt;
  String get award_AmtEnc => m_award_AmtEnc;
  double? get deduct_Amt => m_deduct_Amt;
  String get deduct_AmtEnc => m_deduct_AmtEnc;
  double? get net_Amt => m_net_Amt;
  String get net_AmtEnc => m_net_AmtEnc;
  int get eFlag => m_eFlag;
  String get bank_Acct_No => m_bank_Acct_No;
  double? get basic_Pay_Kyat => m_basic_Pay_Kyat;
  double? get award_Amt_Kyat => m_award_Amt_Kyat;
  double? get deduct_Amt_Kyat => m_deduct_Amt_Kyat;
  double? get net_Amt_Kyat => m_net_Amt_Kyat;
  double? get editUserID => m_editUserID;
  DateTime? get editDateTime => m_editDateTime;

  set emp_ID(double newemp_ID){ m_emp_ID = newemp_ID; }
  set sheet_ID(double newsheet_ID){ m_sheet_ID = newsheet_ID; }
  set post_ID(int newpost_ID){ m_post_ID = newpost_ID; }
  set dept_ID(int newdept_ID){ m_dept_ID = newdept_ID; }
  set grade_ID(int? newgrade_ID){ m_grade_ID = newgrade_ID; }
  set pMonth(int? newpMonth){ m_pMonth = newpMonth; }
  set pYear(int? newpYear){ m_pYear = newpYear; }
  set salary_Currency(int? newsalary_Currency){ m_salary_Currency = newsalary_Currency; }
  set basic_Pay(double? newbasic_Pay){ m_basic_Pay = newbasic_Pay; }
  set basic_PayEnc(String newbasic_PayEnc){ m_basic_PayEnc = newbasic_PayEnc; }
  set award_Amt(double? newaward_Amt){ m_award_Amt = newaward_Amt; }
  set award_AmtEnc(String newaward_AmtEnc){ m_award_AmtEnc = newaward_AmtEnc; }
  set deduct_Amt(double? newdeduct_Amt){ m_deduct_Amt = newdeduct_Amt; }
  set deduct_AmtEnc(String newdeduct_AmtEnc){ m_deduct_AmtEnc = newdeduct_AmtEnc; }
  set net_Amt(double? newnet_Amt){ m_net_Amt = newnet_Amt; }
  set net_AmtEnc(String newnet_AmtEnc){ m_net_AmtEnc = newnet_AmtEnc; }
  set eFlag(int neweFlag){ m_eFlag = neweFlag; }
  set bank_Acct_No(String newbank_Acct_No){ m_bank_Acct_No = newbank_Acct_No; }
  set basic_Pay_Kyat(double? newbasic_Pay_Kyat){ m_basic_Pay_Kyat = newbasic_Pay_Kyat; }
  set award_Amt_Kyat(double? newaward_Amt_Kyat){ m_award_Amt_Kyat = newaward_Amt_Kyat; }
  set deduct_Amt_Kyat(double? newdeduct_Amt_Kyat){ m_deduct_Amt_Kyat = newdeduct_Amt_Kyat; }
  set net_Amt_Kyat(double? newnet_Amt_Kyat){ m_net_Amt_Kyat = newnet_Amt_Kyat; }
  set editUserID(double? neweditUserID){ m_editUserID = neweditUserID; }
  set editDateTime(DateTime? neweditDateTime){ m_editDateTime = neweditDateTime; }

  Map<String,dynamic> toMap(){
      var map=Map<String,dynamic>();
      map["emp_ID"]=m_emp_ID;
      map["sheet_ID"]=m_sheet_ID;
      map["dept_ID"]=m_dept_ID;
      map["post_ID"]=m_post_ID;
      map["grade_ID"]=m_grade_ID;
      map["pMonth"]=m_pMonth;
      map["pYear"]=m_pYear;
      map["salary_Currency"]=m_salary_Currency;
      map["basic_Pay"]=m_basic_Pay;
      map["basic_PayEnc"]=m_basic_PayEnc;
      map["award_Amt"]=m_award_Amt;
      map["award_AmtEnc"]=m_award_AmtEnc;
      map["deduct_Amt"]=m_deduct_Amt;
      map["deduct_AmtEnc"]=m_deduct_AmtEnc;
      map["net_Amt"]=m_net_Amt;
      map["net_AmtEnc"]=m_net_AmtEnc;
      map["eFlag"]=m_eFlag;
      map["bank_Acct_No"]=m_bank_Acct_No;
      map["basic_Pay_Kyat"]=m_basic_Pay_Kyat;
      map["award_Amt_Kyat"]=m_award_Amt_Kyat;
      map["deduct_Amt_Kyat"]=m_deduct_Amt_Kyat;
      map["net_Amt_Kyat"]=m_net_Amt_Kyat;
      map["editUserID"]=m_editUserID;
      map["editDateTime"]=m_editDateTime!.toIso8601String();

      if (m_slip_ID!=null){
        map["slip_ID"]=m_slip_ID;
      }

      return map;
  }

  PaySlip.fromObject(dynamic o){
    this.m_slip_ID = o["slip_ID"];
    this.m_emp_ID = o["emp_ID"];
    this.m_sheet_ID = o["sheet_ID"];
    this.m_post_ID = o["post_ID"];
    this.m_dept_ID = o["dept_ID"];
    this.m_grade_ID = o["grade_ID"];
    this.m_pMonth = o["pMonth"];
    this.m_pYear = o["pYear"];
    this.m_salary_Currency = o["salary_Currency"] != null ? o["salary_Currency"] : 0;
    this.m_basic_Pay = o["basic_Pay"];
    this.m_basic_PayEnc = o["basic_PayEnc"];
    this.m_award_Amt = o["award_Amt"];
    this.m_award_AmtEnc = o["award_AmtEnc"];
    this.m_deduct_Amt = o["deduct_Amt"];
    this.m_deduct_AmtEnc = o["deduct_AmtEnc"];
    this.m_net_Amt = o["net_Amt"];
    this.m_net_AmtEnc = o["net_AmtEnc"];
    this.m_eFlag = o["eFlag"];
    this.m_bank_Acct_No = o["bank_Acct_No"];
    this.m_editUserID = o["editUserID"] != null ? o["editUserID"] : 0;
    this.m_editDateTime = o["editDateTime"] != null ? o["editDateTime"] : null;
    this.m_basic_Pay_Kyat = o["basic_Pay_Kyat"];
    this.m_award_Amt_Kyat = o["award_Amt_Kyat"];
    this.m_deduct_Amt_Kyat = o["deduct_Amt_Kyat"];
    this.m_net_Amt_Kyat = o["net_Amt_Kyat"];
    this.m_editUserID = o["editUserID"] != null ? double.parse(o["editUserID"].toString()) : null;
    this.m_editDateTime = o["editDateTime"] != null ? DateTime.parse(o["editDateTime"].toString()) : null;
  }
}


