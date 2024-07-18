
class Edu_Type {
  late  int  m_edu_Type_ID;
  late String m_edu_Type_Desp;
  late String m_edu_Type_Desp_Myn;
  late  int  m_edu_Level;
  late  double?  m_editUserID;
  late  DateTime?  m_editDateTime;

  Edu_Type({ required this.m_edu_Type_Desp, required this.m_edu_Type_Desp_Myn, required this.m_edu_Level, required this.m_editUserID, required this.m_editDateTime });
  Edu_Type.WithId({ required this.m_edu_Type_ID, required this.m_edu_Type_Desp, required this.m_edu_Type_Desp_Myn, required this.m_edu_Level, required this.m_editUserID, required this.m_editDateTime });

  int get edu_Type_ID => m_edu_Type_ID;
  String get edu_Type_Desp => m_edu_Type_Desp;
  String get edu_Type_Desp_Myn => m_edu_Type_Desp_Myn;
  int get edu_Level => m_edu_Level;
  double? get editUserID => m_editUserID;
  DateTime? get editDateTime => m_editDateTime;

  set edu_Type_ID(int newedu_Type_ID){ m_edu_Type_ID = newedu_Type_ID; }
  set edu_Type_Desp(String newedu_Type_Desp){ m_edu_Type_Desp = newedu_Type_Desp; }
  set edu_Type_Desp_Myn(String newedu_Type_Desp_Myn){ m_edu_Type_Desp_Myn = newedu_Type_Desp_Myn; }
  set edu_Level(int newedu_Level){ m_edu_Level = newedu_Level; }
  set editUserID(double? neweditUserID){ m_editUserID = neweditUserID; }
  set editDateTime(DateTime? neweditDateTime){ m_editDateTime = neweditDateTime; }

  Map<String,dynamic> toMap(){
    var map=Map<String,dynamic>();
    map["edu_Type_Desp"]=m_edu_Type_Desp;
    map["edu_Type_Desp_Myn"]=m_edu_Type_Desp_Myn;
    map["edu_Level"]=m_edu_Level;
    map["editUserID"]=m_editUserID;
    map["editDateTime"]=m_editDateTime!.toIso8601String();

    if (m_edu_Type_ID!=null){
      map["edu_Type_ID"]=m_edu_Type_ID;
    }

    return map;
  }

  Edu_Type.fromObject(dynamic o){
    this.m_edu_Type_ID = o["edu_Type_ID"] != null ? o["edu_Type_ID"] : 0;
    this.m_edu_Type_Desp = o["edu_Type_Desp"] != null ? o["edu_Type_Desp"] : '';
    this.m_edu_Type_Desp_Myn = o["edu_Type_Desp_Myn"] != null ? o["edu_Type_Desp_Myn"] : '';
    this.m_edu_Level = o["edu_Level"] != null ? o["edu_Level"] : 0;
    this.m_editUserID = o["editUserID"] != null ? double.parse(o["editUserID"].toString()) : null;
    this.m_editDateTime = o["editDateTime"] != null ? DateTime.parse(o["editDateTime"].toString()) : null;
  }
}


