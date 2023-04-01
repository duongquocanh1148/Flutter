// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class Users {
  String? userID;
  String? email;
  String? password;
  String? userName;
  String? mobile;
  String? address;
  Users({
    this.userID,
    this.email,
    this.password,
    this.userName,
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
      userID: map['userID'] != null ? map['userID'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      userName: map['userName'] != null ? map['userName'] as String : null,
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
