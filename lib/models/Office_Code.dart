
class Office_Code {
  late  int  m_branchID;
  late String m_officeCode;
  late double? m_editUserID;
  late DateTime? m_editDateTime;

  Office_Code({ required this.m_officeCode, required this.m_editUserID, required this.m_editDateTime });
  Office_Code.WithId({ required this.m_branchID, required this.m_officeCode, required this.m_editUserID, required this.m_editDateTime });

  int get branchID => m_branchID;
  String get officeCode => m_officeCode;
  double? get editUserID => m_editUserID;
  DateTime? get editDateTime => m_editDateTime;

  set branchID(int newBranchID){ m_branchID = newBranchID; }
  set officeCode(String newOfficeCode){ m_officeCode = newOfficeCode; }
  set editUserID(double? neweditUserID){ m_editUserID = neweditUserID; }
  set editDateTime(DateTime? neweditDateTime){ m_editDateTime = neweditDateTime; }

  Map<String,dynamic> toMap(){
    var map=Map<String,dynamic>();
    map["officeCode"]=m_officeCode;
    map["editUserID"]=m_editUserID;
    map["editDateTime"]=m_editDateTime!.toIso8601String();

    if (m_branchID!=null){
      map["branchID"]=m_branchID;
    }

    return map;
  }

  Office_Code.fromObject(dynamic o){
    this.m_branchID = o["branchID"] as int;
    this.m_officeCode = o["officeCode"];
    this.m_editUserID = o["editUserID"] != null ? double.parse(o["editUserID"].toString()) : null;
    this.m_editDateTime = o["editDateTime"] != null ? DateTime.parse(o["editDateTime"].toString()) : null;
  }
}


