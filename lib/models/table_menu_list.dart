class TableMenuList {
  String? menuCategory;
  String? menuCategoryId;
  String? menuCategoryImage;
  String? nexturl;
  List<CategoryDish>? categoryDishes;
  TableMenuList.fromJson(Map<String, dynamic> json)
      : menuCategory = json["menu_category"] ?? "",
        menuCategoryId = json["menu_category_id"] ?? "",
        menuCategoryImage = json["menu_category_image"] ?? "",
        nexturl = json["nexturl"] ?? "",
        categoryDishes =
            CategoryDish.convertToList(json["category_dishes"] ?? []);
  static List<TableMenuList> convertToList(List<dynamic> list) {
    return list.map((e) => TableMenuList.fromJson(e)).toList();
  }
}

class CategoryDish {
  String? dishId;
  String? dishName;
  double? dishPrice;
  String? dishImage;
  String? dishCurrency;
  double? dishCalories;
  String? dishDescription;
  bool? dishAvailability;
  int? dishType;
  String? nexturl;
  List<AddonCat>? addonCat;
  int? count;
  double? total;

  CategoryDish.fromJson(Map<String, dynamic> json)
      : dishId = json["dish_id"] ?? "",
        dishName = json["dish_name"] ?? "",
        dishPrice = json["dish_price"] ?? 0.0,
        dishImage = json["dish_image"] ?? "",
        dishCurrency = json["dish_currency"] ?? "",
        dishCalories = json["dish_calories"] ?? 0.0,
        dishDescription = json["dish_description"] ?? "",
        dishAvailability = json["dish_Availability"] ?? true,
        dishType = json["dish_Type"]??0,
        nexturl = json["nexturl"] ?? "",
        addonCat = AddonCat.convertToList(json["addonCat"] ?? []),
        count = json["count"] ?? 0,
        total = json["total"] ?? 0.0;

  CategoryDish.fromMenu(CategoryDish dish)
      : dishId = dish.dishId ?? "",
        dishName = dish.dishName ?? "",
        dishCalories = dish.dishCalories ?? 0.0,
        dishCurrency = dish.dishCurrency?? "",
        count = dish.count ?? 0;

  static List<CategoryDish> convertToList(List<dynamic> list) {
    return list.map((e) => CategoryDish.fromJson(e)).toList();
  }
}

class AddonCat {
  String? addonCategory;
  String? addonCategoryId;
  int? addonSelection;
  String? nexturl;
  List<CategoryDish>? addons;

  AddonCat.fromJson(Map<String, dynamic> json)
      : addonCategory = json["addon_category"] ?? "",
        addonCategoryId = json["addon_category_id"] ?? "",
        addonSelection = json["addon_selection"] ?? 0,
        nexturl = json["nexturl"] ?? "",
        addons = CategoryDish.convertToList(json["addons"] ?? []);

  static List<AddonCat> convertToList(List<dynamic> list) {
    return list.map((e) => AddonCat.fromJson(e)).toList();
  }
}
