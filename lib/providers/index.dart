
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:restaurant_app/providers/restaurant.dart';

import 'app.dart';


class ProviderTree {
  static List<SingleChildWidget> get(BuildContext context) {
    return [
      ChangeNotifierProvider.value(value: AppProvider()),
      ChangeNotifierProvider.value(value: RestaurantProvider()),
    ];
  }
}
