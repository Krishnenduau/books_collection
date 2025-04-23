import 'package:books_collection/Components/books_card.dart';
import 'package:books_collection/Components/common_button.dart';
import 'package:books_collection/Components/shimmer_effect.dart';
import 'package:books_collection/Constant/app_routs.dart';
import 'package:books_collection/Views/Books_list/book_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookListView extends StatelessWidget {
  final BookListController controller = Get.put(BookListController());
  final ScrollController _scrollController = ScrollController();

  BookListView({super.key}) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        controller.loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Lists'),

        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CommonButton(
              text: 'Favourite List',
              onPressed: () {
                Get.toNamed(AppRoutes.favouriteList);
              },
              backgroundColor: Colors.blueGrey,
              textColor: Colors.white,
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.books.isEmpty && controller.isLoading.value) {
          return LayoutBuilder(
            builder: (context, constraints) {
              // Show shimmer effect 
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  itemCount: 10, // Show 10 shimmer items as placeholders
                  itemBuilder: (_, __) => const BookShimmerCard(),
                ),
              );
            },
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 600) {
                // Mobile view
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: controller.books.length + 1,
                  itemBuilder: (context, index) {
                    if (index == controller.books.length) {
                      return controller.isLoading.value
                          ? const BookShimmerCard()
                          : const SizedBox();
                    }

                    final book = controller.books[index];
                    return Obx(
                      () => BookCard(
                        book: book,
                        isFav: controller.isFavourite(book['key']),
                        onFavToggle:
                            () => controller.toggleFavourite(book['key']),
                      ),
                    );
                  },
                );
              } else if (constraints.maxWidth >= 600 &&
                  constraints.maxWidth < 1200) {
                // Tablet view
                return GridView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 2.5,
                  ),
                  itemCount: controller.books.length + 1,
                  itemBuilder: (context, index) {
                    if (index == controller.books.length) {
                      return controller.isLoading.value
                          ? const BookShimmerCard()
                          : const SizedBox();
                    }

                    final book = controller.books[index];
                    return Obx(
                      () => BookCard(
                        book: book,
                        isFav: controller.isFavourite(book['key']),
                        onFavToggle:
                            () => controller.toggleFavourite(book['key']),
                      ),
                    );
                  },
                );
              } else {
                // Desktop view
                return GridView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 2.5,
                  ),
                  itemCount: controller.books.length + 1,
                  itemBuilder: (context, index) {
                    if (index == controller.books.length) {
                      return controller.isLoading.value
                          ? const BookShimmerCard()
                          : const SizedBox();
                    }

                    final book = controller.books[index];
                    return Obx(
                      () => BookCard(
                        book: book,
                        isFav: controller.isFavourite(book['key']),
                        onFavToggle:
                            () => controller.toggleFavourite(book['key']),
                      ),
                    );
                  },
                );
              }
            },
          ),
        );
      }),
    );
  }
}
