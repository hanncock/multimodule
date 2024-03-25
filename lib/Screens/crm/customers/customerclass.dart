class CustomersCls{
  
  final int? clientsId;
  final String clientName;
  final String clientEmail;
  final String clientPhone;
  final String contPersonName;
  final String referral;
  final String location;
  final String postalAdd;
  final String industry;
  
  CustomersCls({
    this.clientsId,
    required this.clientName,
    required this.clientEmail,
    required this.clientPhone,
    required this.contPersonName,
    required this.referral,
    required this.location,
    required this.postalAdd,
    required this.industry
  });

  factory CustomersCls.fromJson(Map<dynamic, dynamic>json){
    return CustomersCls(
      clientsId: json['userId'],
      clientName: json['firstName'].toString(),
      clientEmail: json['otherNames'],
      clientPhone: json['idNo'],
      contPersonName: json['email'],
      referral: json['phone'],
      location: json['phone'],
      postalAdd: json['phone'],
      industry: json['phone']
    );
  }

}

// final String id;
// final String fName;
// final String? sName;
// final String? idNo;
// final String email;
// final String? phoneNum;
//
// User({
//   required this.id,
//   required this.fName,
//   this.sName,
//   this.idNo,
//   required this.email,
//   this.phoneNum
// });
//
