
class Team {
  late  int  m_team_ID;
  late String m_team_Name;
  late double? m_editUserID;
  late DateTime? m_editDateTime;

  Team({ required this.m_team_Name, required this.m_editUserID, required this.m_editDateTime });
  Team.WithId({ required this.m_team_ID, required this.m_team_Name, required this.m_editUserID, required this.m_editDateTime });

  int get team_ID => m_team_ID;
  String get team_Name => m_team_Name;
  double? get editUserID => m_editUserID;
  DateTime? get editDateTime => m_editDateTime;

  set team_Name(String newteam_Name){ m_team_Name = newteam_Name; }
  set editUserID(double? neweditUserID){ m_editUserID = neweditUserID; }
  set editDateTime(DateTime? neweditDateTime){ m_editDateTime = neweditDateTime; }

  Map<String,dynamic> toMap(){
    var map=Map<String,dynamic>();
    map["team_Name"]=m_team_Name;
    map["editUserID"]=m_editUserID;
    map["editDateTime"]=m_editDateTime!.toIso8601String();

    if (m_team_ID!=null){
      map["team_ID"]=m_team_ID;
    }

    return map;
  }

  Team.fromObject(dynamic o){
    this.m_team_ID = o["team_ID"];
    this.m_team_Name = o["team_Name"];
    this.m_editUserID = o["editUserID"] != null ? double.parse(o["editUserID"].toString()) : null;
    this.m_editDateTime = o["editDateTime"] != null ? DateTime.parse(o["editDateTime"].toString()) : null;
  }
}


