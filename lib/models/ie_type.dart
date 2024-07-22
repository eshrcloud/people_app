
class IE_Type {
  late  int  m_IEType;
  late String m_Name;
  late int? m_ChkIE;

  IE_Type({ required this.m_Name, required this.m_ChkIE });
  IE_Type.WithId({ required this.m_IEType, required this.m_Name, required this.m_ChkIE });

  int get IEType => m_IEType;
  String get Name => m_Name;
  int? get ChkIE => m_ChkIE;

  set IEType(int newIEType){ m_IEType = newIEType; }
  set Name(String newName){ m_Name = newName; }
  set ChkIE(int? newChkIE){ m_ChkIE = newChkIE; }

  Map<String,dynamic> toMap(){
    var map=Map<String,dynamic>();
    map["Name"]=m_Name;
    map["ChkIE"]=m_ChkIE;

    if (m_IEType!=null){
      map["IEType"]=m_IEType;
    }

    return map;
  }

  IE_Type.fromObject(dynamic o){
    this.m_IEType = o["IEType"] != null ? o["IEType"] : 0;
    this.m_Name = o["Name"] != null ? o["Name"] : '';
    this.m_ChkIE = o["ChkIE"] != null ? int.parse(o["ChkIE"]) : 0;
  }
}


