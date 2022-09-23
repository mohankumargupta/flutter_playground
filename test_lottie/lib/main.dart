import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: [
            // Load a Lottie file from your assets
            //Lottie.asset('assets/LottieLogo1.json'),

            // Load a Lottie file from a remote url
            //Lottie.network(
            //    'https://github.com/xvrh/lottie-flutter/raw/master/example/assets/lottiefiles/material_wave_loading.json'),
            Lottie.network(
                'https://github.com/xvrh/lottie-flutter/raw/master/example/assets/lottiefiles/material_loading_2.json'),
            //Lottie.network(
            //    'https://github.com/xvrh/lottie-flutter/raw/master/example/assets/lottiefiles/preloader.json'),

            //Lottie.network(
            //    'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json'),

            // Load an animation and its images from a zip file
            //Lottie.asset('assets/lottiefiles/angel.zip'),
          ],
        ),
      ),
    );
  }
}
