import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:picsum_gallery/Services/auth_service.dart';
import 'package:picsum_gallery/gallery_page.dart';
import 'package:picsum_gallery/login_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.init();
  runApp(Provider(
    create: (BuildContext context) => AuthService(),
    child: PicSumGallery(),
  ));
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
        nextScreen: FutureBuilder<bool>(
            future: context.read<AuthService>().isLoggedIn(),
            builder: (context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData && snapshot.data!) {
                  return GalleryPage();
                } else {
                  return LoginPage();
                }
              }
              return CircularProgressIndicator();
            }),
        splashTransition: SplashTransition.rotationTransition,
      ),
      routes: {
        '/gallery': (context) => GalleryPage(),
      },
    );
  }
}
