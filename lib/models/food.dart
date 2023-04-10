import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Food {
    String name;
    String image;
    String? description;
    int price;
    int rate;
    String resKey;
    String foodKey;
  Food({
    required this.name,
    required this.image,
    this.description,
    required this.price,
    required this.rate,
    required this.resKey,
    required this.foodKey,
  });
  
  // Products(this.id, this.title, this.description, this.image, this.price);
  
  // static List<Products> init() {
  //   List<Products> data = [
  //     Products(1,"Bread",
  //         "Founded as a bakery brand in Singapore n 2000 and listed on the SGX in 2003. It has since expanded to more than 1,000 retail stores spread across 17 markets. Its brand portfcao correnses BreadTalk. Toast Box. Food Repubec. Food Junction, Din Tai Fung, Bread Society. Thye Moh Chan, The Icing Roan, SD and Nayuki n Sngapore. Din Tai Fung, Song Fa Bak Kut Tell, Wu Pao Chun and Nayuki are franchised brands",
  //         "asset/image/ic_banh_mi.png", 8.0),
  //     Products(2,"Coffee",
  //         "Founded as a bakery brand in Singapore n 2000 and listed on the SGX in 2003. It has since expanded to more than 1,000 retail stores spread across 17 markets. Its brand portfcao correnses BreadTalk. Toast Box. Food Repubec. Food Junction, Din Tai Fung, Bread Society. Thye Moh Chan, The Icing Roan, SD and Nayuki n Sngapore. Din Tai Fung, Song Fa Bak Kut Tell, Wu Pao Chun and Nayuki are franchised brands",
  //         "asset/image/ic_banh_mi.png", 8.0),
  //     Products(3,"Tea",
  //         "Founded as a bakery brand in Singapore n 2000 and listed on the SGX in 2003. It has since expanded to more than 1,000 retail stores spread across 17 markets. Its brand portfcao correnses BreadTalk. Toast Box. Food Repubec. Food Junction, Din Tai Fung, Bread Society. Thye Moh Chan, The Icing Roan, SD and Nayuki n Sngapore. Din Tai Fung, Song Fa Bak Kut Tell, Wu Pao Chun and Nayuki are franchised brands",
  //         "asset/image/ic_banh_mi.png", 8.0),
  //     Products(4,"Bread",
  //         "Founded as a bakery brand in Singapore n 2000 and listed on the SGX in 2003. It has since expanded to more than 1,000 retail stores spread across 17 markets. Its brand portfcao correnses BreadTalk. Toast Box. Food Repubec. Food Junction, Din Tai Fung, Bread Society. Thye Moh Chan, The Icing Roan, SD and Nayuki n Sngapore. Din Tai Fung, Song Fa Bak Kut Tell, Wu Pao Chun and Nayuki are franchised brands",
  //         "asset/image/ic_banh_mi.png", 8.0),
  //     Products(5,"Bread",
  //         "Founded as a bakery brand in Singapore n 2000 and listed on the SGX in 2003. It has since expanded to more than 1,000 retail stores spread across 17 markets. Its brand portfcao correnses BreadTalk. Toast Box. Food Repubec. Food Junction, Din Tai Fung, Bread Society. Thye Moh Chan, The Icing Roan, SD and Nayuki n Sngapore. Din Tai Fung, Song Fa Bak Kut Tell, Wu Pao Chun and Nayuki are franchised brands",
  //         "asset/image/ic_banh_mi.png", 8.0),    
  //   ];
  //   return data;
  // }

  Food copyWith({
    String? name,
    String? image,
    String? des,
    int? price,
    int? rate,
    String? resKey,
    String? foodKey,
  }) {
    return Food(
      name: name ?? this.name,
      image: image ?? this.image,
      description: description ?? description,
      price: price ?? this.price,
      rate: rate ?? this.rate,
      resKey: resKey ?? this.resKey,
      foodKey: foodKey ?? this.foodKey,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'image': image,
      'description': description,
      'price': price,
      'rate': rate,
      'resKey': resKey,
      'foodKey': foodKey,
    };
  }

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      name: map['name'] as String,
      image: map['image'] as String,
      description: map['description'] as String,
      price: map['price'] as int,
      rate: map['rate'] as int,
      resKey: map['resKey'] as String,
      foodKey: map['foodKey'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Food.fromJson(String source) => Food.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Food(name: $name, image: $image, price: $price, rate: $rate, resKey: $resKey, foodKey: $foodKey)';
  }

  @override
  bool operator ==(covariant Food other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.image == image &&
      other.description == description &&
      other.price == price &&
      other.rate == rate &&
      other.resKey == resKey &&
      other.foodKey == foodKey;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      image.hashCode ^
      description.hashCode ^
      price.hashCode ^
      rate.hashCode ^
      resKey.hashCode ^
      foodKey.hashCode;
  }
}
