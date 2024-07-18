
class Relationship {
  late  int  m_relationShip_ID;
  late String m_relationShip_Name;
  late int m_relationShip_Group_ID;
  late  String  m_relationShip_Name_Myn;
  late double? m_editUserID;
  late DateTime? m_editDateTime;

  Relationship({ required this.m_relationShip_Name, required this.m_relationShip_Group_ID, required this.m_relationShip_Name_Myn, required this.m_editUserID, required this.m_editDateTime });
  Relationship.WithId({ required this.m_relationShip_ID, required this.m_relationShip_Name, required this.m_relationShip_Group_ID, required this.m_relationShip_Name_Myn, required this.m_editUserID, required this.m_editDateTime });

  int get relationShip_ID => m_relationShip_ID;
  String get relationShip_Name => m_relationShip_Name;
  int get relationShip_Group_ID => m_relationShip_Group_ID;
  String get relationShip_Name_Myn => m_relationShip_Name_Myn;
  double? get editUserID => m_editUserID;
  DateTime? get editDateTime => m_editDateTime;

  set relationShip_ID(int newrelationShip_ID){ m_relationShip_ID = newrelationShip_ID; }
  set relationShip_Name(String newrelationShip_Name){ m_relationShip_Name = newrelationShip_Name; }
  set relationShip_Group_ID(int newrelationShip_Group_ID){ m_relationShip_Group_ID = newrelationShip_Group_ID; }
  set relationShip_Name_Myn(String newrelationShip_Name_Myn){ m_relationShip_Name_Myn = newrelationShip_Name_Myn; }
  set editUserID(double? neweditUserID){ m_editUserID = neweditUserID; }
  set editDateTime(DateTime? neweditDateTime){ m_editDateTime = neweditDateTime; }

  Map<String,dynamic> toMap(){
    var map=Map<String,dynamic>();
    map["relationShip_Name"]=m_relationShip_Name;
    map["relationShip_Group_ID"]=m_relationShip_Group_ID;
    map["relationShip_Name_Myn"]=m_relationShip_Name_Myn;
    map["editUserID"]=m_editUserID;
    map["editDateTime"]=m_editDateTime!.toIso8601String();

    if (m_relationShip_ID!=null){
      map["relationShip_ID"]=m_relationShip_ID;
    }

    return map;
  }

  Relationship.fromObject(dynamic o){
    this.m_relationShip_ID = o["relationShip_ID"] != null ? o["relationShip_ID"] : 0;
    this.m_relationShip_Name = o["relationShip_Name"] != null ? o["relationShip_Name"] : "";
    this.m_relationShip_Group_ID = o["relationShip_Group_ID"] != null ? o["relationShip_Group_ID"] : 0;
    this.m_relationShip_Name_Myn = o["relationShip_Name_Myn"] != null ? o["relationShip_Name_Myn"] : "";
    this.m_editUserID = o["editUserID"] != null ? double.parse(o["editUserID"].toString()) : null;
    this.m_editDateTime = o["editDateTime"] != null ? DateTime.parse(o["editDateTime"].toString()) : null;
  }
}


