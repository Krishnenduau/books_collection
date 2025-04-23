import 'package:get/get.dart';

class FavouritesController extends GetxController {
  RxList<Map<String, dynamic>> books = <Map<String, dynamic>>[].obs;
  RxMap<String, RxBool> favourites = <String, RxBool>{}.obs;

  bool isFavourite(String key) {
    return favourites[key]?.value ?? false;
  }

  void toggleFavourite(String key) {
    final isFav = favourites[key]?.value ?? false;
    if (isFav) {
      favourites[key]!.value = false;
    } else {
      favourites[key] = true.obs;
    }
  }
}
