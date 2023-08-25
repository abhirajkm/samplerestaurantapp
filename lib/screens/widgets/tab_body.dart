import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/models/table_menu_list.dart';
import 'package:restaurant_app/providers/restaurant.dart';

import '../../utils/theme.dart';
import '../../utils/view.dart';

class TabBody extends StatelessWidget {
  final List<TableMenuList>? dish;

  const TabBody({
    Key? key,
    required TabController? nestedTabController,
    this.dish,
  })  : _nestedTabController = nestedTabController,
        super(key: key);

  final TabController? _nestedTabController;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: _nestedTabController,
      children: dish!.map((e) => TabBodyItem(dish: e)).toList(),
    );
  }
}

class TabBodyItem extends StatefulWidget {
  final TableMenuList dish;
  const TabBodyItem({Key? key, required this.dish}) : super(key: key);

  @override
  State<TabBodyItem> createState() => _TabBodyItemState();
}

class _TabBodyItemState extends State<TabBodyItem> {
  @override
  Widget build(BuildContext context) {
    final categoryDishes = widget.dish.categoryDishes;
    int qty=0;
    return Consumer<RestaurantProvider>(builder: (context, value, child) =>  ListView.builder(
          shrinkWrap: true,
          itemCount: categoryDishes!.length,
          itemBuilder: (context, index) {
            final dish=categoryDishes[index];
            return InkWell(
              onTap: (){
                Provider.of<RestaurantProvider>(context,listen: false).setIndex(index);
              },
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            dish.dishType== 2?
                            Image.asset(
                              "assets/icons/veg.png",
                              width: 20,
                            ):
                            Image.asset(
                              "assets/icons/nonveg.png",
                              width: 20,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                              width: fullWidth(context) / 2,
                              child: Text(
                                categoryDishes[index].dishName
                                    .toString(),
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width:  fullWidth(context) / 1.5,
                          padding:
                          const EdgeInsets.only(left: 25, right: 10),
                          child: Row(
                            children: [
                              Text(
                                "${
                                    categoryDishes[index]
                                        .dishCurrency ==
                                        "SAR"
                                        ? "INR"
                                        : "INR"

                                }" "  "
                                    "${categoryDishes[index]
                                    .dishPrice!}",

                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              const Spacer(),
                              Text(
                                "${categoryDishes[index].dishCalories}calories",
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),

                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                            padding: const EdgeInsets.only(left: 25),
                            width:  fullWidth(context) / 1.5,
                            child: Text(
                              categoryDishes[index].dishDescription
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade500),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Container(
                            height: 35,
                            width:  fullWidth(context) / 3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: green),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () async{
                                     await decrementQty(dish);
                                    },
                                    icon: const Icon(
                                      Icons.remove,
                                      color: white,
                                      size: 20,
                                    )),
                                Text(
                                  dish.count.toString(),
                                  style: const TextStyle(
                                      color: white, fontSize: 16),
                                ),
                                IconButton(
                                    onPressed: () async{
                                      await incrementQty(dish);
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
                        const SizedBox(
                          height: 10,
                        ),
                        categoryDishes[index].addonCat!.isNotEmpty
                            ? const Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: Text(
                            "Customizations Available",
                            style: TextStyle(
                                color: soldColor,
                                fontSize: 14),
                          ),
                        )
                            : Container()
                      ],
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                            imageUrl: "https://images.pexels.com/photos/262978/pexels-photo-262978.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"??categoryDishes[index].dishImage.toString(),
                            placeholder: (context, url) =>
                            const LoadingIndicator(
                              indicatorType: Indicator.ballRotateChase, /// Required, The loading type of the widget
                              colors:[Colors.grey],       /// Optional, The color collections
                              strokeWidth:0.1,                     /// Optional, The stroke of the line, only applicable to widget which contains line
                            ),
                            errorWidget: (context, url, error) => Center(child: new Icon(Icons.error)),
                            width: 100,
                          ),
                        ]
                      // Image.network(widget.categoryDishes![index].dishImage.toString(),width: 100,)],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
  incrementQty(CategoryDish dish){
    final provider=Provider.of<RestaurantProvider>(context,listen: false);
    if(dish.count!>-1){

      setState(() {
        dish.count=dish.count!+1;
      });

      if(dish.count==1){
        //provider.setQty(dish.count!,dish.dishId!);
        provider.addDish(dish);
      }
      provider.setQty(dish.count!,dish.dishId!);

    }
  }

  decrementQty(CategoryDish dish){
    final provider=Provider.of<RestaurantProvider>(context,listen: false);
    if(dish.count!>0){
      setState(() {
        dish.count=dish.count!-1;
      });
      provider.setQty(dish.count!,dish.dishId!);
      if(dish.count==0) {
        provider.removeDish(dish);
      }
    }
  }
}
