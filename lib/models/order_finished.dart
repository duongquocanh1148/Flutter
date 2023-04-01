// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'food_basket.dart';

class OrderFinised {
    String? orderID;
    String? orderDate;
    String? orderSum;
    int? orderStatus;
    String? userUID;
    List<FoodBasket>? foodBaskets;

    
  OrderFinised({
    this.orderID,
    this.orderDate,
    this.orderSum,
    this.orderStatus,
    this.userUID,
    this.foodBaskets,
  });

  OrderFinised copyWith({
    String? orderID,
    String? orderDate,
    String? orderSum,
    int? orderStatus,
    String? userUID,
    List<FoodBasket>? foodBaskets,
  }) {
    return OrderFinised(
      orderID: orderID ?? this.orderID,
      orderDate: orderDate ?? this.orderDate,
      orderSum: orderSum ?? this.orderSum,
      orderStatus: orderStatus ?? this.orderStatus,
      userUID: userUID ?? this.userUID,
      foodBaskets: foodBaskets ?? this.foodBaskets,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderID': orderID,
      'orderDate': orderDate,
      'orderSum': orderSum,
      'orderStatus': orderStatus,
      'userUID': userUID,
      'foodBaskets': foodBaskets!.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderFinised.fromMap(Map<String, dynamic> map) {
    return OrderFinised(
      orderID: map['orderID'] != null ? map['orderID'] as String : null,
      orderDate: map['orderDate'] != null ? map['orderDate'] as String : null,
      orderSum: map['orderSum'] != null ? map['orderSum'] as String : null,
      orderStatus: map['orderStatus'] != null ? map['orderStatus'] as int : null,
      userUID: map['userUID'] != null ? map['userUID'] as String : null,
      foodBaskets: map['foodBaskets'] != null ? List<FoodBasket>.from((map['foodBaskets'] as List<int>).map<FoodBasket?>((x) => FoodBasket.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderFinised.fromJson(String source) => OrderFinised.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderFinised(orderID: $orderID, orderDate: $orderDate, orderSum: $orderSum, orderStatus: $orderStatus, userUID: $userUID, foodBaskets: $foodBaskets)';
  }

  @override
  bool operator ==(covariant OrderFinised other) {
    if (identical(this, other)) return true;
  
    return 
      other.orderID == orderID &&
      other.orderDate == orderDate &&
      other.orderSum == orderSum &&
      other.orderStatus == orderStatus &&
      other.userUID == userUID &&
      listEquals(other.foodBaskets, foodBaskets);
  }

  @override
  int get hashCode {
    return orderID.hashCode ^
      orderDate.hashCode ^
      orderSum.hashCode ^
      orderStatus.hashCode ^
      userUID.hashCode ^
      foodBaskets.hashCode;
  }
}
