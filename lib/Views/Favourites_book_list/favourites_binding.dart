import 'package:books_collection/Views/Favourites_book_list/favourites_viewmodel.dart';
import 'package:get/get.dart';


class FavouritesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FavouritesController());
  }
}