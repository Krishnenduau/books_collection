import 'package:get/get.dart';

class BookDetailController extends GetxController {
  var title = ''.obs;
  var authorList = <String>[].obs;
  var subjects = <String>[].obs;
  var genre = ''.obs;
  var classifications = <String>[].obs;
  var isForChildren = false.obs;
  var year = 'Unknown'.obs;
  var coverUrl = ''.obs;
  var book = {}.obs;

  void setBookDetails(Map<String, dynamic> bookData) {
    book.value = bookData;

    title.value = bookData['title'] ?? 'No title';
    authorList.value =
        (bookData['authors'] as List?)
            ?.map((e) => e['name']?.toString() ?? '')
            .toList() ??
        [];

    subjects.value =
        (bookData['subject'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];

    year.value = bookData['first_publish_year']?.toString() ?? 'Unknown';

    coverUrl.value =
        bookData['cover_id'] != null
            ? 'https://covers.openlibrary.org/b/id/${bookData['cover_id']}-L.jpg'
            : 'https://via.placeholder.com/150x200';

    _classifyData();
  }

  // Classify Genre and Subjects into Tags
  void _classifyData() {
    _classifyGenre();
    _classifyTags();
  }

  // Classify the genre based on subjects
  void _classifyGenre() {
    final lowerSubjects = subjects.map((s) => s.toLowerCase()).toList();

    if (lowerSubjects.any(
      (s) => s.contains('science fiction') || s.contains('sci-fi'),
    )) {
      genre.value = 'Science Fiction';
    } else if (lowerSubjects.any(
      (s) =>
          s.contains('fantasy') || s.contains('magic') || s.contains('fairy'),
    )) {
      genre.value = 'Fantasy';
    } else if (lowerSubjects.any(
      (s) =>
          s.contains('mystery') ||
          s.contains('detective') ||
          s.contains('thriller'),
    )) {
      genre.value = 'Mystery';
    } else if (lowerSubjects.any(
      (s) =>
          s.contains('biography') ||
          s.contains('memoir') ||
          s.contains('autobiography'),
    )) {
      genre.value = 'Biography';
    } else if (lowerSubjects.any(
      (s) => s.contains('history') || s.contains('war'),
    )) {
      genre.value = 'History';
    } else if (lowerSubjects.any(
      (s) => s.contains('romance') || s.contains('love'),
    )) {
      genre.value = 'Romance';
    } else if (lowerSubjects.any(
      (s) =>
          s.contains('nonfiction') ||
          s.contains('essay') ||
          s.contains('philosophy'),
    )) {
      genre.value = 'Non-Fiction';
    } else {
      genre.value = 'General';
    }

    // Detect if it's for children
    isForChildren.value = subjects.any(
      (s) =>
          s.toLowerCase().contains('children') ||
          s.toLowerCase().contains('juvenile') ||
          s.toLowerCase().contains('kids'),
    );
  }

  // Classify tags like 'Science Fiction', 'Fantasy', etc.
  void _classifyTags() {
    final lowerSubjects = subjects.map((s) => s.toLowerCase()).toList();
    final tags = <String>{};

    if (lowerSubjects.any(
      (s) => s.contains('science fiction') || s.contains('sci-fi'),
    )) {
      tags.add('Science Fiction');
    }
    if (lowerSubjects.any(
      (s) =>
          s.contains('fantasy') || s.contains('magic') || s.contains('fairy'),
    )) {
      tags.add('Fantasy');
    }
    if (lowerSubjects.any(
      (s) =>
          s.contains('mystery') ||
          s.contains('detective') ||
          s.contains('thriller'),
    )) {
      tags.add('Mystery');
    }
    if (lowerSubjects.any(
      (s) =>
          s.contains('biography') ||
          s.contains('memoir') ||
          s.contains('autobiography'),
    )) {
      tags.add('Biography');
    }
    if (lowerSubjects.any((s) => s.contains('history') || s.contains('war'))) {
      tags.add('History');
    }
    if (lowerSubjects.any((s) => s.contains('romance') || s.contains('love'))) {
      tags.add('Romance');
    }
    if (lowerSubjects.any(
      (s) =>
          s.contains('nonfiction') ||
          s.contains('essay') ||
          s.contains('philosophy'),
    )) {
      tags.add('Non-Fiction');
    }
    if (lowerSubjects.any(
      (s) =>
          s.contains('education') ||
          s.contains('textbook') ||
          s.contains('curriculum'),
    )) {
      tags.add('Educational');
    }
    if (lowerSubjects.any(
      (s) =>
          s.contains('religion') ||
          s.contains('bible') ||
          s.contains('spiritual'),
    )) {
      tags.add('Religion & Spirituality');
    }
    if (lowerSubjects.any(
      (s) =>
          s.contains('philosophy') ||
          s.contains('ethics') ||
          s.contains('logic'),
    )) {
      tags.add('Philosophy');
    }
    if (lowerSubjects.any(
      (s) => s.contains('poetry') || s.contains('verse') || s.contains('rhyme'),
    )) {
      tags.add('Poetry');
    }
    if (lowerSubjects.any(
      (s) => s.contains('drama') || s.contains('play') || s.contains('theatre'),
    )) {
      tags.add('Drama');
    }
    if (lowerSubjects.any(
      (s) =>
          s.contains('self-help') ||
          s.contains('motivational') ||
          s.contains('inspirational'),
    )) {
      tags.add('Self Help');
    }
    if (lowerSubjects.any(
      (s) =>
          s.contains('technology') ||
          s.contains('computer') ||
          s.contains('software'),
    )) {
      tags.add('Technology');
    }
    if (lowerSubjects.any(
      (s) =>
          s.contains('business') ||
          s.contains('economics') ||
          s.contains('finance'),
    )) {
      tags.add('Business & Economics');
    }
    if (lowerSubjects.any(
      (s) =>
          s.contains('art') ||
          s.contains('design') ||
          s.contains('architecture'),
    )) {
      tags.add('Art & Design');
    }
    if (lowerSubjects.any(
      (s) =>
          s.contains('travel') ||
          s.contains('exploration') ||
          s.contains('adventure'),
    )) {
      tags.add('Travel');
    }

    classifications.value = tags.isEmpty ? ['General'] : tags.toList();
  }
}
