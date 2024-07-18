
class Param_Output {
  late String m_result;

  Param_Output({ required this.m_result });

  String get result => m_result;

  set result(String newResult){ m_result = newResult; }

  Map<String,dynamic> toMap(){
    var map=Map<String,dynamic>();
    map["result"]=m_result;

    return map;
  }

  Param_Output.fromObject(dynamic o){
    this.m_result = o["result"];
  }
}


