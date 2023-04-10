// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:flutter/foundation.dart';

import 'package:food_now/models/food.dart';

class Restaurant {
  String resKey;
  String name;
  String logo;
  String cover;
  String address;
  String openHours;
  List<Food>? menu;
  int rate;
  Restaurant({
    required this.resKey,
    required this.name,
    required this.logo,
    required this.cover,
    required this.address,
    required this.openHours,
    this.menu,
    required this.rate,
  });

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

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'resKey': resKey,
  //     'name': name,
  //     'logo': logo,
  //     'cover': cover,
  //     'address': address,
  //     'openHours': openHours,
  //     'menu': menu?.map((x) => x.toMap()).toList(),
  //     'rate': rate,
  //   };
  // }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      resKey: map['resKey'],
      name: map['name'],
      logo: map['logo'],
      cover: map['cover'],
      address: map['address'],
      openHours: map['openHours'],
      menu: map['menu']??[],
      rate: map['rate'],
    );
  }

  // String toJson() => json.encode(toMap());

  // factory Restaurant.fromJson(String source) =>
  //     Restaurant.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Restaurant(resKey: $resKey, name: $name, logo: $logo, cover: $cover, address: $address, openHours: $openHours, menu: $menu, rate: $rate)';
  }

  @override
  bool operator ==(covariant Restaurant other) {
    if (identical(this, other)) return true;

    return other.resKey == resKey &&
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
