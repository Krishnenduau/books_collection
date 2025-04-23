import 'package:books_collection/Views/Books_list/book_list_viewmodel.dart';
import 'package:get/get.dart';


class BookListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BookListController());
  }
}