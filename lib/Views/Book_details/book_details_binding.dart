import 'package:books_collection/Views/Book_details/book_details_viewmodel.dart';
import 'package:get/get.dart';


class BookDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BookDetailController());
  }
}
