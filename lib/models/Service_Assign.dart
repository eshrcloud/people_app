class Service_Assign {
  late  double m_TranID;
  late double m_ServiceID;
  late double m_EmpID;
  late double? m_editUserID;
  late DateTime? m_editDateTime;

  Service_Assign({ required this.m_ServiceID, required this.m_EmpID, required this.m_editUserID, required this.m_editDateTime });
  Service_Assign.WithId({ required this.m_TranID, required this.m_ServiceID, required this.m_EmpID, required this.m_editUserID, required this.m_editDateTime });

  double get tranID => m_TranID;
  double get serviceID => m_ServiceID;
  double get empID => m_EmpID;
  double? get editUserID => m_editUserID;
  DateTime? get editDateTime => m_editDateTime;

  set serviceID(double newServiceID){ m_ServiceID = newServiceID; }
  set empID(double newEmpID){ m_EmpID = newEmpID; }
  set editUserID(double? neweditUserID){ m_editUserID = neweditUserID; }
  set editDateTime(DateTime? neweditDateTime){ m_editDateTime = neweditDateTime; }

  Map<String,dynamic> toMap(){
    var map=Map<String,dynamic>();
    map["serviceID"]=m_ServiceID;
    map["empID"]=m_EmpID;
    map["editUserID"]=m_editUserID;
    map["editDateTime"]=m_editDateTime!.toIso8601String();

    return map;
  }

  Service_Assign.fromObject(dynamic o){
    this.m_TranID = o["tranID"];
    this.m_ServiceID = o["serviceID"];
    this.m_EmpID = o["empID"];
    this.m_editUserID = o["editUserID"] != null ? double.parse(o["editUserID"].toString()) : 0.0;
    this.m_editDateTime = o["editDateTime"] != null ? DateTime.parse(o["editDateTime"]) : null;
  }

}


