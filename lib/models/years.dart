
class Years {
  late String m_yearVal;

  Years({ required this.m_yearVal });

  String get yearVal => m_yearVal;

  set yearVal(String newyearVal){ m_yearVal = newyearVal; }

  Map<String,dynamic> toMap(){
    var map=Map<String,dynamic>();
    map["yearVal"]= int.parse(m_yearVal);

    return map;
  }

  Years.fromObject(dynamic o){
    this.m_yearVal = o["yearVal"].toString();
  }
}


