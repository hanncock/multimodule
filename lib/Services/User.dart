class User{

  final String id;
  final String fName;
  final String? sName;
  final String? idNo;
  final String email;
  final String? phoneNum;

  User({
    required this.id,
    required this.fName,
     this.sName,
     this.idNo,
    required this.email,
     this.phoneNum
  });

  factory User.fromJson(Map<dynamic, dynamic>json){
    return User(
        id: json['id'].toString(),
        fName: json['firstName'].toString(),
        sName: json['otherNames'].toString(),
        idNo: json['idNo'].toString(),
        email: json['email'].toString(),
        phoneNum: json['phone'].toString()
    );
  }

}