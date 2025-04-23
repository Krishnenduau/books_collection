import 'package:books_collection/Components/conts.dart';
import 'package:books_collection/Views/Books_list/book_list_viewmodel.dart';
import 'package:books_collection/Views/Favourites_book_list/favourites_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavBookCard extends StatelessWidget {
  final Map<String, dynamic> book;
  final bool isFav;

  const FavBookCard({required this.book, required this.isFav, super.key});

  @override
  Widget build(BuildContext context) {
    final coverUrl =
        book['cover_id'] != null
            ? 'https://covers.openlibrary.org/b/id/${book['cover_id']}-M.jpg'
            : '';

    return Card(
      key: ValueKey(book['key']), // Use ValueKey here to ensure uniqueness
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Book cover with favorite icon on top
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: SizedBox(
                    width: 60,
                    height: 80,
                    child:
                        coverUrl.isNotEmpty
                            ? Image.network(
                              coverUrl,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (context, error, stackTrace) =>
                                      const Icon(Icons.broken_image),
                              loadingBuilder: (
                                context,
                                child,
                                loadingProgress,
                              ) {
                                if (loadingProgress == null) return child;
                                return Container(color: Colors.grey.shade300);
                              },
                            )
                            : Container(
                              color: Colors.grey.shade200,
                              child: const Icon(Icons.image_not_supported),
                            ),
                  ),
                ),
                const Positioned(
                  top: 4,
                  left: 4,
                  child: Icon(
                    Icons.favorite,
                    color: redColor,
                    size: 18,
                  ),
                ),
              ],
            ),

            const SizedBox(width: 12),

            // Title
            Expanded(
              child: Text(
                book['title'] ?? 'No Title',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),

            // Remove button
            IconButton(
              icon: const Icon(Icons.remove_circle, color: Colors.red),
              onPressed: () {
                final bookKey = book['key'];
                if (bookKey != null) {
                  final controller = Get.find<BookListController>();
                  controller.toggleFavourite(bookKey);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
