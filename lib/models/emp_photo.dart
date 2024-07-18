class Emp_Photo {
  late double m_emp_ID;
  late String m_photo;
  late double? m_editUserID;
  late DateTime? m_editDateTime;

  Emp_Photo({ required this.m_photo, required this.m_editUserID, required this.m_editDateTime });
  Emp_Photo.WithId({ required this.m_emp_ID, required this.m_photo, required this.m_editUserID, required this.m_editDateTime });

  double get emp_ID => m_emp_ID;
  String get photo => m_photo;
  double? get editUserID => m_editUserID;
  DateTime? get editDateTime => m_editDateTime;

  set photo(String newphoto){ m_photo = newphoto; }
  set editUserID(double? neweditUserID){ m_editUserID = neweditUserID; }
  set editDateTime(DateTime? neweditDateTime){ m_editDateTime = neweditDateTime; }

  Map<String,dynamic> toMap(){
      var map=Map<String,dynamic>();
      map["photo"]=m_photo;
      map["editUserID"]=m_editUserID;
      map["editDateTime"]=m_editDateTime!.toIso8601String();

      if (m_emp_ID!=null){
        map["emp_ID"]=m_emp_ID;
      }

      return map;
  }

  Emp_Photo.fromObject(dynamic o){
    this.m_emp_ID = o["emp_ID"];
    this.m_photo = o["photo"];
    this.m_editUserID = o["editUserID"] != null ? double.parse(o["editUserID"].toString()) : null;
    this.m_editDateTime = o["editDateTime"] != null ? DateTime.parse(o["editDateTime"].toString()) : null;
  }
}


