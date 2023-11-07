import 'package:flutter/material.dart';
import 'package:picsum_gallery/widgets/login_text_field.dart';
import 'package:social_media_buttons/social_media_button.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formkey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final Uri _url = Uri.parse('https://picsum.photos/');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: LayoutBuilder(builder: (
            BuildContext context,
            BoxConstraints constraints,
          ) {
            if (constraints.maxWidth > 1000) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: _buildHeader()),
                  const SizedBox(width: 20),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildForm(),
                      const SizedBox(height: 50),
                      _buildFooter(),
                    ],
                  )),
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildForm(),
                  const SizedBox(height: 24),
                  _buildFooter(),
                ],
              );
            }
          }),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Welcome to PicSum!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const Text(
          'Let\'s sign you in.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 24),
        Image.asset(
          'assets/picsum_loginImg.jpeg',
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            if (!await launchUrl(_url)) {
              throw Exception('Could not launch URL');
            }
          },
          child: Column(
            children: [
              const Text('Find us on'),
              Text('$_url'),
            ],
          ),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialMediaButton.linkedin(url: 'https://linkedin.com'),
            SocialMediaButton.twitter(url: 'https://twitter.com'),
            SocialMediaButton.github(url: 'https://github.com'),
          ],
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Form(
          key: _formkey,
          child: Column(
            children: [
              LoginTextField(
                validator: (value) {
                  if (value != null && value.isNotEmpty && value.length < 5) {
                    return "Your username should be more than 5 characters";
                  } else if (value != null && value.isEmpty) {
                    return "Please type your username";
                  } else {
                    return null;
                  }
                },
                controller: usernameController,
                hintText: 'Enter your username',
              ),
              const SizedBox(height: 20),
              LoginTextField(
                controller: passwordController,
                hintText: 'Enter your password',
                maskText: true,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        ElevatedButton(
            onPressed: loginUser,
            child: const Text(
              'Login',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ))
      ],
    );
  }

  void loginUser() {
    if (_formkey.currentState != null && _formkey.currentState!.validate()) {
      print(usernameController.text);
      print(passwordController.text);
      print('Login Successful!');
    } else {
      print('Login not Successful');
    }
  }
}
