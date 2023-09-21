import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../main.dart';

//splash screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      //exit full-screen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          statusBarColor: Colors.white));

      //   if (APIs.auth.currentUser != null) {
      //     log('\nUser: ${APIs.auth.currentUser}');
      //     //navigate to home screen
      //     Navigator.pushReplacement(
      //         context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      //   } else {
      //     //navigate to login screen
      //     Navigator.pushReplacement(
      //         context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      //   }
    });
  }

  @override
  Widget build(BuildContext context) {
    //initializing media query (for getting device screen size)
    globalAppSize = MediaQuery.of(context).size;

    return Scaffold(
      //body
      body: Stack(
        children: [
          //app logo
          Positioned(
              top: globalAppSize.height * .15,
              right: globalAppSize.width * .25,
              width: globalAppSize.width * .5,
              child: Image.asset('images/app_logo.png')),

          //google login button
          Positioned(
            bottom: globalAppSize.height * .15,
            width: globalAppSize.width,
            child: const Text(
              'MADE IN INDIA WITH ❤️',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                letterSpacing: .5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
