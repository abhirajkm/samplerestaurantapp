
import '../models/restaurant.dart';
import '../utils/api/api_methods.dart';
import '../utils/api/api_request.dart';

class RestaurantInterface{

  static Future<Restaurant?> fetchRestaurant() async {
    try {
      final response = await ApiRequest.send(
          method: ApiMethod.GET,
          route: "v2/5dfccffc310000efc8d2c1ad",
         );

      if (response != null) {

        return Restaurant.convertToList(response)[0];
      }
      return null;
    } catch (err) {
      print("Fetching  error: $err");

      return null;
    }
  }
}