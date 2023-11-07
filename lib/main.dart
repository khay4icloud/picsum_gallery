import 'package:flutter/material.dart';
import 'package:picsum_gallery/login_page.dart';

void main() {
  runApp(const PicSumGallery());
}

class PicSumGallery extends StatelessWidget {
  const PicSumGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lorem Picsum',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.blue,
        ),
      ),
      home: LoginPage(),
      routes: const {},
    );
  }
}
