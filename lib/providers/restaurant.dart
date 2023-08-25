import 'package:flutter/cupertino.dart';

import '../interfaces/restaurant.dart';
import '../models/restaurant.dart';
import '../models/table_menu_list.dart';

class RestaurantProvider with ChangeNotifier{
  Restaurant? restaurant;
  int selectedIndex=0;
  int selectedDishIndex = 0;
  int qty=0;
  List<CategoryDish> cartList = [];


  void setDishIndex(index){
    index=selectedDishIndex;
    notifyListeners();
  }

  clearCart(){

    cartList=[];
    restaurant?.tableMenuList!.clear();
    //removeDish(dish)
    notifyListeners();
  }

  setQty(int quantity,String id){
    final index = cartList.indexWhere((element) => element.dishId == id);
    if(index>-1) {
     qty=cartList[index].count=quantity;
     cartList[index].total=cartList[index].dishPrice!*double.parse(quantity.toString());
      notifyListeners();
    }


  }

  addDish(CategoryDish dish){
    cartList.add(dish);
    notifyListeners();
  }
  removeDish(CategoryDish dish){
    cartList.remove(dish);
    notifyListeners();
  }


  void setIndex(index){
    index=selectedIndex;
    notifyListeners();
  }

  String grandTotal() {
    double grantTotal = 0;
    for (var e in cartList) {

      grantTotal += double.parse(e.total.toString());
    }
    return '$grantTotal';
  }


  Future<Restaurant?> fetchRestaurant() async {

    final data = await RestaurantInterface.fetchRestaurant();

    if (data != null) {
     restaurant=data;
      notifyListeners();
    }

    return data;
  }


}