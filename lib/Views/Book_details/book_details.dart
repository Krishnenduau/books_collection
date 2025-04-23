import 'package:books_collection/Components/conts.dart';
import 'package:books_collection/Views/Book_details/book_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookDetailScreen extends StatelessWidget {
  final Map<String, dynamic> book;

  const BookDetailScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final BookDetailController controller = Get.put(BookDetailController());
    controller.setBookDetails(book);

    return Scaffold(
      appBar: AppBar(title: const Text('Book Details')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 600;

          return Obx(() {
            final cover = ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child:
                  controller.coverUrl.value.isNotEmpty
                      ? Image.network(
                        controller.coverUrl.value,
                        height: 200,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) => Image.asset(
                              'assets/empty_image.jpg',
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                      )
                      : Image.asset(
                        'assets/empty_image.jpg',
                        height: 200,
                        fit: BoxFit.cover,
                      ),
            );

            final metadata = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kHeight15,
                Text(
                  controller.title.value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                kHeight8,
                Text(
                  'By ${controller.authorList.join(', ')}',
                  style: const TextStyle(fontSize: 16),
                ),
                kHeight8,
                Text('First Published: ${controller.year.value}'),
                kHeight8,
                if (controller.isForChildren.value)
                  const Text(
                    'For Children',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                kHeight8,
                Text(
                  'Genre: ${controller.genre.value}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );

            final classifications = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kHeight15,
                Text(
                  'Classifications',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                kHeight8,
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children:
                      controller.classifications
                          .map(
                            (classification) =>
                                Chip(label: Text(classification)),
                          )
                          .toList(),
                ),
              ],
            );

            final subjects = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kHeight15,
                const Text(
                  'Subjects',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                kHeight8,
                Text(
                  controller.subjects.isNotEmpty
                      ? controller.subjects.join(', ')
                      : 'No subjects available',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            );

            // Scrollable layout
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  if (isWide)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Left Column
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [Center(child: cover), metadata],
                          ),
                        ),
                        const SizedBox(width: 32),

                        /// Right Column
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [classifications, subjects],
                          ),
                        ),
                      ],
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: cover),
                        metadata,
                        const Divider(),
                        classifications,
                        subjects,
                      ],
                    ),
                ],
              ),
            );
          });
        },
      ),
    );
  }
}
