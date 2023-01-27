import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

import './screen/chat_screen.dart';
import 'screen/auth_screen.dart';
import 'screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> initialization = Firebase.initializeApp();
    return FutureBuilder(
        // Initialize FlutterFire:
        future: initialization,
        builder: (context, appSnapshot) {
          return MaterialApp(
            title: 'FlutterChat',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              canvasColor: Color.fromRGBO(155, 253, 180, 1),
              primaryColor: Color.fromRGBO(2, 141, 64, 1),
              cardColor: Color.fromRGBO(165, 158, 169, 0.9),
              iconTheme: IconThemeData(color: Colors.black),
              textTheme: TextTheme(
                  bodySmall: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  bodyMedium: TextStyle(
                    color: Color.fromRGBO(31, 29, 32, 1),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  )),
              appBarTheme: AppBarTheme().copyWith(
                color: Color.fromRGBO(5, 241, 64, 1),
                titleTextStyle:
                    TextStyle().copyWith(color: Colors.black, fontSize: 23),
              ),
              buttonTheme: ButtonTheme.of(context).copyWith(
                buttonColor: Color.fromRGBO(217, 207, 67, 1),
                textTheme: ButtonTextTheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            home: appSnapshot.connectionState != ConnectionState.done
                ? SplashScreen()
                : StreamBuilder(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (ctx, userSnapshot) {
                      if (userSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return SplashScreen();
                      }
                      if (userSnapshot.hasData) {
                        return ChatScreen();
                      }
                      return AuthScreen();
                    }),
          );
        });
  }
}
