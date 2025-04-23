
import 'package:books_collection/Constant/app_routs.dart';
import 'package:books_collection/Views/Book_details/book_details.dart';
import 'package:books_collection/Views/Books_list/book_list_view.dart';
import 'package:books_collection/Views/Favourites_book_list/favourites_view.dart';

import 'package:books_collection/Views/Splash_view/splash_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init(); // Initialize local storage
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner:
          false, // Optional: If you're using EasyLoading
      initialRoute: AppRoutes.splash,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        snackBarTheme: const SnackBarThemeData(backgroundColor: Colors.white),
      ),
      getPages: [
        GetPage(name: AppRoutes.splash, page: () => SplashView()),
        GetPage(name: AppRoutes.home, page: () => BookListView()),
         GetPage(name: AppRoutes.favouriteList, page: () => FavouritesScreen()),
        GetPage(
          name: AppRoutes.bookDetails,
          page: () => BookDetailScreen(book: {}),
        ),
      ],
    );
  }
}
