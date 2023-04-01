// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'food_basket.dart';

class Basket {
  Map<String, FoodBasket>? foods;
  double? totalPrice;
  int? totalItem;
  Basket({
    this.foods,
    this.totalPrice,
    this.totalItem,
  });


  Basket copyWith({
    Map<String, FoodBasket>? foods,
    double? totalPrice,
    int? totalItem,
  }) {
    return Basket(
      foods: foods ?? this.foods,
      totalPrice: totalPrice ?? this.totalPrice,
      totalItem: totalItem ?? this.totalItem,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'foods': foods,
      'totalPrice': totalPrice,
      'totalItem': totalItem,
    };
  }

  // factory Basket.fromMap(Map<String, dynamic> map) {
  //   return Basket(
  //     foods: map['foods'] != null ? Map<String, FoodBasket>.from((map['foods'] as Map<String, FoodBasket>) : null,
  //     totalPrice: map['totalPrice'] != null ? map['totalPrice'] as double : null,
  //     totalItem: map['totalItem'] != null ? map['totalItem'] as int : null,
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory Basket.fromJson(String source) => Basket.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Basket(foods: $foods, totalPrice: $totalPrice, totalItem: $totalItem)';

  @override
  bool operator ==(covariant Basket other) {
    if (identical(this, other)) return true;
  
    return 
      mapEquals(other.foods, foods) &&
      other.totalPrice == totalPrice &&
      other.totalItem == totalItem;
  }

  @override
  int get hashCode => foods.hashCode ^ totalPrice.hashCode ^ totalItem.hashCode;
}
