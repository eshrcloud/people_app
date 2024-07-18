
class Service_Log {
  late double m_ServiceID;
  late  int? m_TeamID;
  late  String? m_Product;
  late  String? m_Client;
  late  String? m_Description;
  late  DateTime? m_ReqDate;
  late  DateTime? m_TargetDate;
  late  bool? m_Finish;
  late  double?  m_Charges;
  late  bool?  m_Paid;
  late  String?  m_Remark;
  late double? m_EmpID;
  late double? m_editUserID;
  late DateTime? m_editDateTime;

  Service_Log({ required this.m_TeamID, required this.m_Product, required this.m_Client, required this.m_Description,
    required this.m_ReqDate, required this.m_TargetDate, required this.m_Finish, required this.m_Charges,
    required this.m_Paid, required this.m_Remark, required this.m_EmpID, required this.m_editUserID, required this.m_editDateTime
  });
  Service_Log.WithId({ required this.m_ServiceID, required this.m_TeamID, required this.m_Product, required this.m_Client, required this.m_Description,
    required this.m_ReqDate, required this.m_TargetDate, required this.m_Finish, required this.m_Charges,
    required this.m_Paid, required this.m_Remark, required this.m_EmpID, required this.m_editUserID, required this.m_editDateTime
  });

  double get serviceID => m_ServiceID;
  int? get teamID => m_TeamID;
  String? get product => m_Product;
  String? get client => m_Client;
  String? get description => m_Description;
  DateTime? get reqDate => m_ReqDate;
  DateTime? get targetDate => m_TargetDate;
  bool? get finish => m_Finish;
  double? get charges => m_Charges;
  bool? get paid => m_Paid;
  String? get remark => m_Remark;
  double? get empID => m_EmpID;
  double? get editUserID => m_editUserID;
  DateTime? get editDateTime => m_editDateTime;

  set serviceID(double newServiceID){ m_ServiceID = newServiceID; }
  set teamID(int? newTeamID){ m_TeamID = newTeamID; }
  set product(String? newProduct){ m_Product = newProduct; }
  set client(String? newClient){ m_Client = newClient; }
  set description(String? newDescription){ m_Description = newDescription; }
  set reqDate(DateTime? newReqDate){ m_ReqDate = newReqDate; }
  set targetDate(DateTime? newTargetDate){ m_TargetDate = newTargetDate; }
  set finish(bool? newFinish){ m_Finish = newFinish; }
  set charges(double? newCharges){ m_Charges = newCharges; }
  set paid(bool? newPaid){ m_Paid = newPaid; }
  set remark(String? newRemark){ m_Remark = newRemark; }
  set empID(double? newEmpID){ m_EmpID = newEmpID; }
  set editUserID(double? neweditUserID){ m_editUserID = neweditUserID; }
  set editDateTime(DateTime? neweditDateTime){ m_editDateTime = neweditDateTime; }

  Map<String,dynamic> toMap(){
    var map=Map<String,dynamic>();
    map["teamID"]=m_TeamID;
    map["product"]=m_Product;
    map["client"]=m_Client;
    map["description"]=m_Description;
    map["reqDate"]= m_ReqDate != null ? m_ReqDate!.toIso8601String() : null;
    map["targetDate"]= m_TargetDate != null ? m_TargetDate!.toIso8601String() : null;
    map["finish"]=m_Finish;
    map["charges"]=m_Charges;
    map["paid"]=m_Paid;
    map["remark"]=m_Remark;
    map["empID"]=m_EmpID;
    map["editUserID"]=m_editUserID;
    map["editDateTime"]=m_editDateTime!.toIso8601String();

    if (m_ServiceID!=null){
      map["serviceID"]=m_ServiceID;
    }

    return map;
  }

  Service_Log.fromObject(dynamic o){
    this.m_ServiceID = double.parse(o["serviceID"].toString());
    this.m_TeamID = o["teamID"] != null ? int.parse(o["teamID"].toString()) : 0;
    this.m_Product = o["product"];
    this.m_Client = o["client"];
    this.m_Description = o["description"];
    this.m_ReqDate = o["reqDate"] != null ? DateTime.parse(o["reqDate"]) : null;
    this.m_TargetDate = o["targetDate"] != null ? DateTime.parse(o["targetDate"]) : null;
    this.m_Finish = o["finish"];
    this.m_Charges = o["charges"] != null ? double.parse(o["charges"].toString()) : 0.0;
    this.m_Paid = o["paid"];
    this.m_Remark = o["remark"];
    this.m_EmpID = o["empID"] != null ? double.parse(o["empID"].toString()) : 0.0;
    this.m_editUserID = o["editUserID"] != null ? double.parse(o["editUserID"].toString()) : 0.0;
    this.m_editDateTime = o["editDateTime"] != null ? DateTime.parse(o["editDateTime"]) : null;
  }
}


