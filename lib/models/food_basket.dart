// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'food.dart';

class FoodBasket extends Food {
  int? quantity;
  double? sum;
  Food? food;
  FoodBasket({
    this.quantity,
    this.sum,
    this.food,
  });
  void increase() {
        quantity = (quantity! + 1);
        sum = (price! * quantity!).toDouble();
    }

    void decrease() {
        if (quantity! > 0) {
           quantity = (quantity! - 1);
           sum = (price! * quantity!).toDouble();
        }
    }
  // @override
  // FoodBasket copyWith({
  //   int? quantity,
  //   double? sum,
  //   Food? food,
  // }) {
  //   return FoodBasket(
  //     quantity: quantity ?? this.quantity,
  //     sum: sum ?? this.sum,
  //     food: food ?? this.food,
  //   );
  // }
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'quantity': quantity,
      'sum': sum,
      'food': food?.toMap(),
    };
  }

  factory FoodBasket.fromMap(Map<String, dynamic> map) {
    return FoodBasket(
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      sum: map['sum'] != null ? map['sum'] as double : null,
      food: map['food'] != null ? Food.fromMap(map['food'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FoodBasket.fromJson(String source) => FoodBasket.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'FoodBasket(quantity: $quantity, sum: $sum, food: $food)';

  @override
  bool operator ==(covariant FoodBasket other) {
    if (identical(this, other)) return true;
  
    return 
      other.quantity == quantity &&
      other.sum == sum &&
      other.food == food;
  }

  @override
  int get hashCode => quantity.hashCode ^ sum.hashCode ^ food.hashCode;
}
