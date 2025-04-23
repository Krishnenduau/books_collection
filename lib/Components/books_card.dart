import 'package:books_collection/Views/Book_details/book_details.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BookCard extends StatelessWidget {
  final Map<String, dynamic> book; // Now using Map instead of BookWork
  final bool isFav;
  final VoidCallback onFavToggle;

  const BookCard({
    required this.book,
    required this.isFav,
    required this.onFavToggle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    double imageWidth;
    double imageHeight;
    EdgeInsets padding;

    if (screenWidth < 600) {
      imageWidth = 70;
      imageHeight = 70;
      padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 8);
    } else if (screenWidth < 1200) {
      imageWidth = 70;
      imageHeight = 90;
      padding = const EdgeInsets.symmetric(horizontal: 6, vertical: 6);
    } else {
      imageWidth = 80;
      imageHeight = 90;
      padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 8);
    }

    final coverUrl =
        book['cover_id'] != null
            ? 'https://covers.openlibrary.org/b/id/${book['cover_id']}-L.jpg'
            : '';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookDetailScreen(book: book)),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: padding,
          child: Row(
            children: [
              // Shimmer effect for image loading, with fallback asset image
              SizedBox(
                width: imageWidth,
                height: imageHeight,
                child:
                    coverUrl.isNotEmpty
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            coverUrl,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) => Image.asset(
                                  'assets/empty_image.jpg', // Fallback image
                                  fit: BoxFit.cover,
                                ),
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;

                              // Show shimmer effect while loading
                              return Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  color: Colors.grey[200],
                                  width: imageWidth,
                                  height: imageHeight,
                                ),
                              );
                            },
                          ),
                        )
                        : Image.asset(
                          'assets/empty_image.jpg', // Fallback image
                          fit: BoxFit.cover,
                        ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  book['title'] ?? 'No Title',
                  maxLines: screenWidth < 600 ? 1 : 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.red : Colors.grey,
                ),
                onPressed: onFavToggle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
