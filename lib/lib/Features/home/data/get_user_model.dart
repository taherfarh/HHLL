class GetUserModel {
  final String phone;
  final String password;
  final String login;
  final String a;
  final String b;
  final String c;
  final String d;
  final String e;
  final String f;
  final String g;
  final String h;

  GetUserModel({required this.phone, required this.password,required this.login,required this.a,required this.b,required this.c,required this.d,required this.e,required this.f,required this.g,required this.h, });


  factory GetUserModel.fromJson(Map<String,dynamic> json){
    return GetUserModel(
      phone: json["phone"],
      password: json["password"],
      login: json["login"], 
      a: json["a"],
      b: json["b"],
      c: json["c"],
      d: json["d"],
      e: json["e"],
      f: json["f"],
      g: json["g"],
      h: json["h"],
      );
  }
}