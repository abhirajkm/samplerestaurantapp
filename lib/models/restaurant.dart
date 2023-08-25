import 'package:restaurant_app/models/table_menu_list.dart';

class Restaurant {
  String? restaurantId;
  String?restaurantName;
  String? restaurantImage;
  String? tableId;
  String? tableName;
  String? branchName;
  String? nexturl;
  List<TableMenuList>? tableMenuList;
  Restaurant.fromJson(Map<String, dynamic> json)
      : restaurantId = json["restaurant_id"]?? "",
        restaurantName = json["restaurant_name"]??"",
        restaurantImage = json["restaurant_image"]??"",
        tableId = json["table_id"]??"",
        tableName = json["table_name"]??"",
        branchName = json["branch_name"]??"",
        nexturl = json["nexturl"]??"",
        tableMenuList = TableMenuList.convertToList(json["table_menu_list"]??[]);


  static List< Restaurant> convertToList(List<dynamic>? list) {
    if (list == null) return [];

    List< Restaurant>  Restaurants = [];
    list.forEach((element) {
       Restaurants.add( Restaurant.fromJson(element));
    });

    return  Restaurants;
  }
}
