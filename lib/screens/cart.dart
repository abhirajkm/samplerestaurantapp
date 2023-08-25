import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/models/table_menu_list.dart';
import 'package:restaurant_app/screens/home.dart';
import 'package:restaurant_app/utils/view.dart';

import '../providers/restaurant.dart';
import '../utils/theme.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/orderSummary";
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RestaurantProvider>(context, listen: false);

    return provider.cartList.isNotEmpty
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: white,
              leading: IconButton(
                onPressed: () async {
                  await provider
                      .fetchRestaurant()
                      .then((value) => Navigator.pop(context));
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.grey,
                ),
              ),
              title: const Text(
                "Order Summary",
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
              centerTitle: true,
            ),
            bottomNavigationBar: SizedBox(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      provider.clearCart();
                      Future.sync(
                          () => provider.fetchRestaurant().then((value) {
                                if(value!=null){
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      HomeScreen.routeName, (route) => false);
                                }
                              }));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      height: 50,
                      width: fullWidth(context),
                      decoration: BoxDecoration(
                          color: Colors.green.shade900,
                          borderRadius: BorderRadius.circular(50)),
                      child: const Center(
                        child: Text(
                          "Place Order",
                          style: TextStyle(fontSize: 20, color: white),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                    indent: 10,
                    endIndent: 10,
                  ),
                ],
              ),
            ),
            body: const OrderSummaryItem(),
          )
        : const Scaffold(
            body: Center(
              child: Text(
                "CART IS EMPTY",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
          );
  }
}

class OrderSummaryItem extends StatefulWidget {
  const OrderSummaryItem({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderSummaryItem> createState() => _OrderSummaryItemState();
}

class _OrderSummaryItemState extends State<OrderSummaryItem> {
  double total = 0;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                height: 50,
                width: fullWidth(context),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.green.shade900),
                child: Consumer<RestaurantProvider>(
                    builder: (context, value, child) {
                  return Center(
                      child: Text(
                    "${value.cartList.length}-Dishes ${value.qty}-Items",
                    style: const TextStyle(fontSize: 16, color: white),
                  ));
                }),
              ),
              const SizedBox(height: 20),
              Consumer<RestaurantProvider>(builder: (context, cart, child) {
                return Card(
                  child: Column(
                    children: cart.cartList
                        .map((e) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/icons/veg.png",
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: fullWidth(context) / 5,
                                        child: Text(
                                          e.dishName!,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "INR ${e.dishPrice}",
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${e.dishCalories}calories",
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25),
                                    child: Container(
                                      height: 35,
                                      width: fullWidth(context) / 3,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.green.shade900),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                              onPressed: () async {
                                                await decrementQty(e);
                                              },
                                              icon: const Icon(
                                                Icons.remove,
                                                color: white,
                                                size: 20,
                                              )),
                                          Text(
                                            e.count.toString(),
                                            style: const TextStyle(
                                                color: white, fontSize: 16),
                                          ),
                                          IconButton(
                                              onPressed: () async {
                                                await incrementQty(e);
                                              },
                                              icon: const Icon(
                                                Icons.add,
                                                color: white,
                                                size: 20,
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5,),
                                  Expanded(
                                    child: Text(
                                      "INR ${e.total.toString()}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                );
              }),
              const Divider(
                color: Colors.grey,
                indent: 10,
                endIndent: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Consumer<RestaurantProvider>(
                    builder: (context, value, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total Amount",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        "INR ${value.grandTotal()}",
                        style:
                            const TextStyle(color: Colors.green, fontSize: 15),
                      )
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  incrementQty(CategoryDish dish) {
    final provider = Provider.of<RestaurantProvider>(context, listen: false);
    if (dish.count! > 0) {
      setState(() {
        dish.count = dish.count! + 1;
      });

      if (dish.count == 1) {
        provider.addDish(dish);
      }
      provider.setQty(dish.count!, dish.dishId!);
    }
  }

  decrementQty(CategoryDish dish) {
    final provider = Provider.of<RestaurantProvider>(context, listen: false);
    if (dish.count! > 0) {
      setState(() {
        dish.count = dish.count! - 1;
      });
      provider.setQty(dish.count!, dish.dishId!);
      if (dish.count == 0) {
        provider.removeDish(dish);
      }
    }
  }
}
