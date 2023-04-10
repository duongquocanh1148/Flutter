// ignore_for_file: implementation_imports

import 'package:flutter/material.dart';
import 'package:food_now/models/basket.dart';
import 'package:food_now/models/food_basket.dart';
import 'package:food_now/widget/textfield.dart';

import '../models/food.dart';

class CartPage extends StatelessWidget {
  final FoodBasket? foodBasket;
  const CartPage({super.key, this.foodBasket});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          map(),
          listItem(),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Order"),
          )
        ]),
      ),
    );
  }

  map() {
    return SizedBox(
      width: double.infinity,
      height: 150,
      child: Image.asset("asset/image/${foodBasket!.image}"),
    );
  }

  listItem() {
    // Map<String, Food> foods;
    // Basket basket = Basket(foods: foods, totalPrice: 1, totalItem: 1);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(        
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.asset("asset/image/${foodBasket!.image}")),
                    Column(
                      children: [
                        Text(foodBasket!.name,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.green)),
                        TextWidget()
                            .priceBasket(text: foodBasket!.price.toString()),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      iconSize: 15,
                      splashRadius: 15,
                      color: Colors.green,
                      icon: const Icon(Icons.remove),
                      onPressed: () {},
                    ),
                    const Text(
                      "1",
                      style: TextStyle(fontSize: 15),
                    ),
                    IconButton(
                      iconSize: 15,
                      splashRadius: 15,
                      color: Colors.green,
                      icon: const Icon(Icons.add),
                      onPressed: () {},
                    )
                  ],
                )
              ],
            ),
          Container(
            margin: EdgeInsets.only(top: 300),
            child: Row(
              children: [
                const Text("Tổng tiền: "),
                TextWidget().price(text: foodBasket!.price.toString()),
              ],
            ),
          ),
          ],         
        ),
      ),
    );
  }
}
