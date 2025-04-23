import 'package:books_collection/utils/snackbar.dart';
import 'package:books_collection/Services/book_api_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BookListController extends GetxController {
  RxList<Map<String, dynamic>> books = <Map<String, dynamic>>[].obs;
  RxBool isLoading = false.obs;
  RxInt currentPage = 0.obs; // Page number for pagination
  RxMap<String, RxBool> favourites = <String, RxBool>{}.obs;
  final storage = GetStorage();
  final BookApiService _bookApiService = BookApiService();

  @override
  void onInit() {
    super.onInit();
    final storedFavourites =
        storage.read<List>('favourites')?.cast<String>() ?? [];
    for (var key in storedFavourites) {
      favourites[key] = true.obs;
    }
    fetchBooks(); // Load the first batch of books
  }

  void fetchBooks() async {
    if (isLoading.value) return;

    isLoading.value = true;

    // Call the BookApiService to fetch books
    final newBooks = await _bookApiService.fetchBooks(
      offset: currentPage.value * 10,
    );

    if (newBooks.isNotEmpty) {
      books.addAll(newBooks); // Append the new books to the existing list
    }

    isLoading.value = false;
  }

  // Load more books when scrolled to the bottom
  void loadMore() {
    if (!isLoading.value) {
      currentPage.value++; // Increment page number for the next batch
      fetchBooks();
    }
  }

  void toggleFavourite(String key) {
    final isFav = favourites[key]?.value ?? false;

    if (isFav) {
      favourites[key]!.value = false;
      SnackbarMessage.show('Removed from favourites');
    } else {
      favourites[key] = true.obs;
      SnackbarMessage.show('Added to favourites');
    }

    // Persist favourites to local storage
    storage.write(
      'favourites',
      favourites.entries.where((e) => e.value.value).map((e) => e.key).toList(),
    );
  }

  bool isFavourite(String key) {
    return favourites[key]?.value ?? false;
  }
}
