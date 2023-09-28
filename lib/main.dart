import 'dart:developer';

import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:flutter/services.dart';

import 'controller/route/routes_controller.dart';
import 'controller/route/routes_name_controller.dart';
import 'firebase_options.dart';

// import './screen/chat_screen.dart';
// import 'screen/auth_screen.dart';
// import 'screen/splash_screen.dart';

late Size globalAppSize;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// enter full - screen
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) {
    _initializeFirebase();
    runApp(const MyApp());
  });
}

_initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var result = await FlutterNotificationChannel.registerNotificationChannel(
    description: 'For Showing Message Notification',
    id: 'chats',
    importance: NotificationImportance.IMPORTANCE_HIGH,
    name: 'Chats',
  );
  log(
    '\nNotification Channel Result: $result',
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterChat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      onGenerateRoute: RoutesController.onGenerateRoute,
      initialRoute: RoutesNameController.register,
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final Future<FirebaseApp> initialization = Firebase.initializeApp();
//     return FutureBuilder(
//       // Initialize FlutterFire:
//       future: initialization,
//       builder: (context, appSnapshot) {
//         return MaterialApp(
//           title: 'FlutterChat',
//           debugShowCheckedModeBanner: false,
//           theme: ThemeData(
//             useMaterial3: false,
//             canvasColor: const Color.fromRGBO(155, 253, 180, 1),
//             primaryColor: const Color.fromRGBO(2, 141, 64, 1),
//             cardColor: const Color.fromRGBO(165, 158, 169, 0.9),
//             iconTheme: const IconThemeData(color: Colors.black),
//             textTheme: const TextTheme(
//                 bodySmall: TextStyle(
//                   color: Colors.black,
//                   fontSize: 13,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 bodyMedium: TextStyle(
//                   color: Color.fromRGBO(31, 29, 32, 1),
//                   fontSize: 13,
//                   fontWeight: FontWeight.bold,
//                 )),
//             appBarTheme: const AppBarTheme().copyWith(
//               color: const Color.fromRGBO(5, 241, 64, 1),
//               titleTextStyle:
//                   const TextStyle().copyWith(color: Colors.black, fontSize: 23),
//             ),
//             buttonTheme: ButtonTheme.of(context).copyWith(
//               buttonColor: const Color.fromRGBO(217, 207, 67, 1),
//               textTheme: ButtonTextTheme.primary,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//             ),
//           ),
//           home: appSnapshot.connectionState != ConnectionState.done
//               ? SplashScreen()
//               : StreamBuilder(
//                   stream: FirebaseAuth.instance.authStateChanges(),
//                   builder: (ctx, userSnapshot) {
//                     if (userSnapshot.connectionState ==
//                         ConnectionState.waiting) {
//                       return SplashScreen();
//                     }
//                     if (userSnapshot.hasData) {
//                       return ChatScreen();
//                     }
//                     return AuthScreen();
//                   },
//                 ),
//         );
//       },
//     );
//   }
// }
