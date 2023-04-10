// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Users {
  String userID;
  String email;
  String password;
  String userName;
  String? mobile;
  String? address;
  Users({
    required this.userID,
    required this.email,
    required this.password,
    required this.userName,
    this.mobile,
    this.address,
  });
  Users copyWith({
    String? userID,
    String? email,
    String? password,
    String? userName,
    String? mobile,
    String? address,
  }) {
    return Users(
      userID: userID ?? this.userID,
      email: email ?? this.email,
      password: password ?? this.password,
      userName: userName ?? this.userName,
      mobile: mobile ?? this.mobile,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userID': userID,
      'email': email,
      'password': password,
      'userName': userName,
      'mobile': mobile,
      'address': address,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      userID: map['userID'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      userName: map['userName'] as String,
      mobile: map['mobile'] != null ? map['mobile'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Users.fromJson(String source) => Users.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Users(userID: $userID, email: $email, password: $password, userName: $userName, mobile: $mobile, address: $address)';
  }

  @override
  bool operator ==(covariant Users other) {
    if (identical(this, other)) return true;
  
    return 
      other.userID == userID &&
      other.email == email &&
      other.password == password &&
      other.userName == userName &&
      other.mobile == mobile &&
      other.address == address;
  }

  @override
  int get hashCode {
    return userID.hashCode ^
      email.hashCode ^
      password.hashCode ^
      userName.hashCode ^
      mobile.hashCode ^
      address.hashCode;
  }
}
