class Emp_Family_User_Req {
  late int m_autoID;
  late double m_req_ID;
  late double? m_tran_ID;
  late double? m_emp_ID;
  late String? m_name;
  late int? m_sex;
  late int? m_relationShip_ID;
  late String? m_nRC_NO;
  late String? m_email;
  late String? m_education;
  late String? m_occupation;
  late String? m_address;
  late bool? m_expire;
  late String? m_remark;
  late bool? m_tax_Allowance;
  late int? m_foreign_Stay;
  late int? m_punishment;
  late String? m_age;
  late DateTime? m_birth_Date;
  late bool? m_new_Flag;
  late DateTime? m_req_Date;
  late  double?  m_editUserID;
  late  DateTime?  m_editDateTime;

  Emp_Family_User_Req({ required this.m_req_ID, required this.m_tran_ID, required this.m_emp_ID,
    required this.m_name, required this.m_sex, required this.m_relationShip_ID, required this.m_nRC_NO, required this.m_email, required this.m_education, required this.m_occupation,
    required this.m_address, required this.m_expire, required this.m_remark, required this.m_tax_Allowance,
    required this.m_foreign_Stay, required this.m_punishment, required this.m_age, required this.m_birth_Date, required this.m_new_Flag, required this.m_req_Date, required this.m_editUserID, required this.m_editDateTime });

  Emp_Family_User_Req.WithId({ required this.m_autoID, required this.m_req_ID, required this.m_tran_ID, required this.m_emp_ID,
    required this.m_name, required this.m_sex, required this.m_relationShip_ID, required this.m_nRC_NO, required this.m_email, required this.m_education, required this.m_occupation,
    required this.m_address, required this.m_expire, required this.m_remark, required this.m_tax_Allowance,
    required this.m_foreign_Stay, required this.m_punishment, required this.m_age, required this.m_birth_Date, required this.m_new_Flag, required this.m_req_Date, required this.m_editUserID, required this.m_editDateTime });

  int get autoID => m_autoID;
  double get req_ID => m_req_ID;
  double? get tran_ID => m_tran_ID;
  double? get emp_ID => m_emp_ID;
  String? get name => m_name;
  int? get sex => m_sex;
  int? get relationShip_ID => m_relationShip_ID;
  String? get nRC_NO => m_nRC_NO;
  String? get email => m_email;
  String? get education => m_education;
  String? get occupation => m_occupation;
  String? get address => m_address;
  bool? get expire => m_expire;
  String? get remark => m_remark;
  bool? get tax_Allowance => m_tax_Allowance;
  int? get foreign_Stay => m_foreign_Stay;
  int? get punishment => m_punishment;
  String? get age => m_age;
  DateTime? get birth_Date => m_birth_Date;
  bool? get new_Flag => m_new_Flag;
  DateTime? get req_Date => m_req_Date;
  double? get editUserID => m_editUserID;
  DateTime? get editDateTime => m_editDateTime;

  set autoID(int newautoID) { m_autoID = newautoID; }
  set req_ID(double newreq_ID) { m_req_ID = newreq_ID; }
  set tran_ID(double? newtran_ID) { m_tran_ID = newtran_ID; }
  set emp_ID(double? newemp_ID) { m_emp_ID = newemp_ID; }
  set name(String? newname) { m_name = newname; }
  set sex(int? newsex) { m_sex = newsex; }
  set relationShip_ID(int? newrelationShip_ID) { m_relationShip_ID = newrelationShip_ID; }
  set nRC_NO(String? newnrcno) { m_nRC_NO = newnrcno; }
  set email(String? newemail) { m_email = newemail; }
  set education(String? neweducation) { m_education = neweducation; }
  set occupation(String? newoccupation) { m_occupation = newoccupation; }
  set address(String? newaddress) { m_address = newaddress; }
  set expire(bool? newexpire) { m_expire = newexpire; }
  set remark(String? newremark) { m_remark = newremark; }
  set tax_Allowance(bool? newtax_Allowance) { m_tax_Allowance = newtax_Allowance; }
  set foreign_Stay(int? newforeign_Stay) { m_foreign_Stay = newforeign_Stay; }
  set punishment(int? newpunishment) { m_punishment = newpunishment; }
  set age(String? newage) { m_age = newage; }
  set birth_Date(DateTime? newbirth_Date) { m_birth_Date = newbirth_Date; }
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
      map["name"]=m_name;
      map["sex"]=m_sex;
      map["relationShip_ID"]=m_relationShip_ID;
      map["nrC_NO"]=m_nRC_NO;
      map["email"]=m_email;
      map["education"]=m_education;
      map["occupation"]=m_occupation;
      map["address"]=m_address;
      map["expire"]=m_expire;
      map["remark"]=m_remark;
      map["tax_Allowance"]=m_tax_Allowance;
      map["foreign_Stay"]=m_foreign_Stay;
      map["punishment"]=m_punishment;
      map["age"]=m_age;
      map["birth_Date"]= m_birth_Date != null ? m_birth_Date!.toIso8601String() : null;
      map["new_Flag"]=m_new_Flag;
      map["req_Date"]=m_req_Date!.toIso8601String();
      map["editUserID"]=m_editUserID;
      map["editDateTime"]=m_editDateTime!.toIso8601String();

      return map;
  }

  Emp_Family_User_Req.fromObject(dynamic o){
    this.m_autoID = int.parse(o["autoID"].toString());
    this.m_req_ID = double.parse(o["req_ID"].toString());
    this.m_tran_ID = double.parse(o["tran_ID"].toString());
    this.m_emp_ID = double.parse(o["emp_ID"].toString());
    this.m_name = o["name"];
    this.m_sex = o["sex"] != null ? int.parse(o["sex"].toString()) : 1;
    this.m_relationShip_ID = o["relationShip_ID"] != null ? int.parse(o["relationShip_ID"].toString()) : 1;
    this.m_nRC_NO = o["nrC_NO"] != null ? o["nrC_NO"].toString() : '';
    this.m_email = o["email"] != null ? o["email"].toString() : '';
    this.m_education = o["education"] != null ? o["education"].toString() : '';
    this.m_occupation = o["occupation"] != null ? o["occupation"].toString() : '';
    this.m_address = o["address"] != null ? o["address"].toString() : '';
    this.m_expire = o["expire"] != null ? o["expire"] : false;
    this.m_remark = o["remark"] != null ? o["remark"].toString() : '';
    this.m_tax_Allowance = o["tax_Allowance"] != null ? o["tax_Allowance"] : false;
    this.m_foreign_Stay = o["foreign_Stay"] != null ? int.parse(o["foreign_Stay"].toString()) : 0;
    this.m_punishment = o["punishment"] != null ? int.parse(o["punishment"].toString()) : 0;
    this.m_age = o["age"] != null ? o["age"] : '';
    this.m_birth_Date = o["birth_Date"] != null ? DateTime.parse(o["birth_Date"].toString()) : null;
    this.m_new_Flag = o["new_Flag"] != null ? o["new_Flag"] : false;
    this.m_req_Date = o["req_Date"] != null ? DateTime.parse(o["req_Date"].toString()) : null;
    this.m_editUserID = o["editUserID"] != null ? double.parse(o["editUserID"].toString()) : null;
    this.m_editDateTime = o["editDateTime"] != null ? DateTime.parse(o["editDateTime"].toString()) : null;
  }
}


