import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:picsum_gallery/gallery_page.dart';
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
      home: AnimatedSplashScreen(
        splash: 'assets/camera.gif',
        nextScreen: LoginPage(),
        splashTransition: SplashTransition.rotationTransition,
      ),
      routes: {
        '/gallery': (context) => GalleryPage(),
      },
    );
  }
}
