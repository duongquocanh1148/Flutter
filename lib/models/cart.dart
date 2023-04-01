// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Cart {
  int? id;
  String? foodKey;
  String? foodName;
  int? foodPrice;
  String? foodImage;
  int? foodRate;
  String? resKey;
  int? quantity;
  double? sum;
  Cart({
    this.id,
    this.foodKey,
    this.foodName,
    this.foodPrice,
    this.foodImage,
    this.foodRate,
    this.resKey,
    this.quantity,
    this.sum,
  });

  Cart copyWith({
    int? id,
    String? foodKey,
    String? foodName,
    int? foodPrice,
    String? foodImage,
    int? foodRate,
    String? resKey,
    int? quantity,
    double? sum,
  }) {
    return Cart(
      id: id ?? this.id,
      foodKey: foodKey ?? this.foodKey,
      foodName: foodName ?? this.foodName,
      foodPrice: foodPrice ?? this.foodPrice,
      foodImage: foodImage ?? this.foodImage,
      foodRate: foodRate ?? this.foodRate,
      resKey: resKey ?? this.resKey,
      quantity: quantity ?? this.quantity,
      sum: sum ?? this.sum,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'foodKey': foodKey,
      'foodName': foodName,
      'foodPrice': foodPrice,
      'foodImage': foodImage,
      'foodRate': foodRate,
      'resKey': resKey,
      'quantity': quantity,
      'sum': sum,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'] != null ? map['id'] as int : null,
      foodKey: map['foodKey'] != null ? map['foodKey'] as String : null,
      foodName: map['foodName'] != null ? map['foodName'] as String : null,
      foodPrice: map['foodPrice'] != null ? map['foodPrice'] as int : null,
      foodImage: map['foodImage'] != null ? map['foodImage'] as String : null,
      foodRate: map['foodRate'] != null ? map['foodRate'] as int : null,
      resKey: map['resKey'] != null ? map['resKey'] as String : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      sum: map['sum'] != null ? map['sum'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Cart(id: $id, foodKey: $foodKey, foodName: $foodName, foodPrice: $foodPrice, foodImage: $foodImage, foodRate: $foodRate, resKey: $resKey, quantity: $quantity, sum: $sum)';
  }

  @override
  bool operator ==(covariant Cart other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.foodKey == foodKey &&
      other.foodName == foodName &&
      other.foodPrice == foodPrice &&
      other.foodImage == foodImage &&
      other.foodRate == foodRate &&
      other.resKey == resKey &&
      other.quantity == quantity &&
      other.sum == sum;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      foodKey.hashCode ^
      foodName.hashCode ^
      foodPrice.hashCode ^
      foodImage.hashCode ^
      foodRate.hashCode ^
      resKey.hashCode ^
      quantity.hashCode ^
      sum.hashCode;
  }
}
