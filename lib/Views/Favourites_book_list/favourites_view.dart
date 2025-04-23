import 'package:books_collection/Components/favourite_card.dart';
import 'package:books_collection/Views/Books_list/book_list_viewmodel.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouritesScreen extends StatelessWidget {
  final BookListController controller = Get.find<BookListController>();

  FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favourites')),
      body: Obx(() {
        final favouriteBooks =
            controller.favourites.entries
                .where((entry) => entry.value.value)
                .map((entry) {
                  final book = controller.books.firstWhere(
                    (book) => book['key'] == entry.key,
                    orElse: () => {},
                  );
                  return book.isNotEmpty ? book : null;
                })
                .whereType<Map<String, dynamic>>()
                .toList();

        return favouriteBooks.isEmpty
            ? const Center(child: Text('No favourites yet'))
            : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: favouriteBooks.length,
              itemBuilder: (context, index) {
                final book = favouriteBooks[index];
                return FavBookCard(book: book, isFav: true);
              },
            );
      }),
    );
  }
}
