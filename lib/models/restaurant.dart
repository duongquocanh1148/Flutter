// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:food_now/models/food.dart';

class Restaurant {
  String? resKey;
  String? name;
  String? logo;
  String? cover;
  String? address;
  String? openHours;
  List<Food>? menu;
  int? rate;
  Restaurant({
    this.resKey,
    this.name,
    this.logo,
    this.cover,
    this.address,
    this.openHours,
    this.menu,
    this.rate,
  });

 
 
  // Categories(int this.id, String this.title, String this.image);

  // static List<Categories> init(){
  //   List<Categories> data = [
  //     Categories(1, 'Highland',"asset/image/ic_highland.jpeg"),
  //     Categories(2, 'Circle K',"asset/image/ic_circlek.jpeg"),
  //     Categories(3, 'Vinmart',"asset/image/ic_vinmart.jpeg"),
  //     Categories(4, 'MiniStop',"asset/image/ic_ministop.jpeg"),
  //     Categories(5, '7 eleven',"asset/image/ic_seveneleven.jpeg"),
  //   ];
  //   return data;
  // }

  Restaurant copyWith({
    String? resKey,
    String? name,
    String? logo,
    String? cover,
    String? address,
    String? openHours,
    List<Food>? menu,
    int? rate,
  }) {
    return Restaurant(
      resKey: resKey ?? this.resKey,
      name: name ?? this.name,
      logo: logo ?? this.logo,
      cover: cover ?? this.cover,
      address: address ?? this.address,
      openHours: openHours ?? this.openHours,
      menu: menu ?? this.menu,
      rate: rate ?? this.rate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'resKey': resKey,
      'name': name,
      'logo': logo,
      'cover': cover,
      'address': address,
      'openHours': openHours,
      'menu': menu!.map((x) => x.toMap()).toList(),
      'rate': rate,
    };
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      resKey: map['resKey'] != null ? map['resKey'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      logo: map['logo'] != null ? map['logo'] as String : null,
      cover: map['cover'] != null ? map['cover'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      openHours: map['openHours'] != null ? map['openHours'] as String : null,
      menu: map['menu'] != null ? List<Food>.from((map['menu'] as List<int>).map<Food?>((x) => Food.fromMap(x as Map<String,dynamic>),),) : null,
      rate: map['rate'] != null ? map['rate'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Restaurant.fromJson(String source) => Restaurant.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Restaurant(resKey: $resKey, name: $name, logo: $logo, cover: $cover, address: $address, openHours: $openHours, menu: $menu, rate: $rate)';
  }

  @override
  bool operator ==(covariant Restaurant other) {
    if (identical(this, other)) return true;
  
    return 
      other.resKey == resKey &&
      other.name == name &&
      other.logo == logo &&
      other.cover == cover &&
      other.address == address &&
      other.openHours == openHours &&
      listEquals(other.menu, menu) &&
      other.rate == rate;
  }

  @override
  int get hashCode {
    return resKey.hashCode ^
      name.hashCode ^
      logo.hashCode ^
      cover.hashCode ^
      address.hashCode ^
      openHours.hashCode ^
      menu.hashCode ^
      rate.hashCode;
  }
}
