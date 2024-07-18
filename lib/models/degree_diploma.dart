
class Degree_Diploma {
  late  int  m_degree_ID;
  late String m_degree_Name;
  late  int  m_edu_Type_ID;
  late  double?  m_editUserID;
  late  DateTime?  m_editDateTime;

  Degree_Diploma({ required this.m_degree_Name, required this.m_edu_Type_ID, required this.m_editUserID, required this.m_editDateTime });
  Degree_Diploma.WithId({ required this.m_degree_ID, required this.m_degree_Name, required this.m_edu_Type_ID, required this.m_editUserID, required this.m_editDateTime });

  int get degree_ID => m_degree_ID;
  String get degree_Name => m_degree_Name;
  int get edu_Type_ID => m_edu_Type_ID;
  double? get editUserID => m_editUserID;
  DateTime? get editDateTime => m_editDateTime;

  set degree_ID(int newdegree_ID){ m_degree_ID = newdegree_ID; }
  set degree_Name(String newdegree_Name){ m_degree_Name = newdegree_Name; }
  set edu_Type_ID(int newedu_Type_ID){ m_edu_Type_ID = newedu_Type_ID; }
  set editUserID(double? neweditUserID){ m_editUserID = neweditUserID; }
  set editDateTime(DateTime? neweditDateTime){ m_editDateTime = neweditDateTime; }

  Map<String,dynamic> toMap(){
    var map=Map<String,dynamic>();
    map["degree_Name"]=m_degree_Name;
    map["edu_Type_ID"]=m_edu_Type_ID;
    map["editUserID"]=m_editUserID;
    map["editDateTime"]=m_editDateTime!.toIso8601String();

    if (m_degree_ID!=null){
      map["degree_ID"]=m_degree_ID;
    }

    return map;
  }

  Degree_Diploma.fromObject(dynamic o){
    this.m_degree_ID = o["degree_ID"] != null ? o["degree_ID"] : 0;
    this.m_degree_Name = o["degree_Name"] != null ? o["degree_Name"] : '';
    this.m_edu_Type_ID = o["edu_Type_ID"] != null ? o["edu_Type_ID"] : 0;
    this.m_editUserID = o["editUserID"] != null ? double.parse(o["editUserID"].toString()) : null;
    this.m_editDateTime = o["editDateTime"] != null ? DateTime.parse(o["editDateTime"].toString()) : null;
  }
}


