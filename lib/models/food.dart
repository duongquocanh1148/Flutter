import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Food {
    String? name;
    String? image;
    int? price;
    int? rate;
    String? resKey;
    String? foodKey;
  Food({
    this.name,
    this.image,
    this.price,
    this.rate,
    this.resKey,
    this.foodKey,
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
    int? price,
    int? rate,
    String? resKey,
    String? foodKey,
  }) {
    return Food(
      name: name ?? this.name,
      image: image ?? this.image,
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
      'price': price,
      'rate': rate,
      'resKey': resKey,
      'foodKey': foodKey,
    };
  }

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      name: map['name'] != null ? map['name'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      price: map['price'] != null ? map['price'] as int : null,
      rate: map['rate'] != null ? map['rate'] as int : null,
      resKey: map['resKey'] != null ? map['resKey'] as String : null,
      foodKey: map['foodKey'] != null ? map['foodKey'] as String : null,
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
      other.price == price &&
      other.rate == rate &&
      other.resKey == resKey &&
      other.foodKey == foodKey;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      image.hashCode ^
      price.hashCode ^
      rate.hashCode ^
      resKey.hashCode ^
      foodKey.hashCode;
  }
}
