import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/models/table_menu_list.dart';
import 'package:restaurant_app/providers/restaurant.dart';
import 'package:restaurant_app/screens/cart.dart';
import 'package:restaurant_app/screens/widgets/custom_tab_header.dart';
import 'package:restaurant_app/screens/widgets/tab_body.dart';

import '../utils/theme.dart';
import '../utils/view.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin<HomeScreen> {
  late TabController mTabController;
  late ScrollController mPageController;
  int selectedIndex = 0;
  @override
  void initState() {
    final data = Provider.of<RestaurantProvider>(context, listen: false);
    data.fetchRestaurant().then((value) {
      setState(() {});
    });
    mTabController = TabController(
      length: data.restaurant?.tableMenuList?.length ?? 6,
      vsync: this,
    );

    mTabController.addListener(() {
      if (mTabController.indexIsChanging) {
        setState(() {
          selectedIndex = mTabController.index;
        });
        data.setIndex(selectedIndex);
      }
    });

    mPageController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    mTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Consumer<RestaurantProvider>(builder: (context, value, child) {
      final menuList = value.restaurant?.tableMenuList;
      final categoryDishes=value.restaurant?.tableMenuList?[value.selectedIndex].categoryDishes;
      return value.restaurant!=null
          ? Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: const Icon(
                  Icons.menu,
                  color: Colors.grey,
                  size: 30,
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(CartScreen.routeName);
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderDetails(),));
                              //Get.to(() => const OrderDetails());
                            },
                            icon: const Icon(
                              Icons.shopping_cart,
                              size: 30,
                              color: Colors.grey,
                            )),
                        Positioned(
                          bottom: 15,
                          right: 10,
                          child: Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                                color: soldColor,
                                borderRadius: BorderRadius.circular(50)),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              body: SingleChildScrollView(
                child: SizedBox(
                  height: fullHeight(context)-70,
                  child: Column(
                    children: [
                      CustomTabHeader(
                        nestedTabController: mTabController,
                        menuList: menuList!,
                        selectedIndex: selectedIndex == mTabController.index,
                      ),
                      Expanded(
                        child: TabBody(
                            dish: menuList,
                            nestedTabController: mTabController),
                      ),
                     // const SizedBox(height: 150,)
                    ],
                  ),
                ),
              ),
            )
          : const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
    }));
  }
}
