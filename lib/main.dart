import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'controller/rive/auth_rive_controller.dart';
import 'controller/route/routes_controller.dart';
import 'controller/route/routes_name_controller.dart';
import 'firebase_options.dart';

late Size globalAppSize;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// enter full - screen
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then(
    (value) {
      _initializeFirebase();
      runApp(
        const MyApp(),
      );
    },
  );
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthRiveController(),
        ),
      ],
      child: MaterialApp(
        title: 'FlutterChat',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        onGenerateRoute: RoutesController.onGenerateRoute,
        initialRoute: RoutesNameController.register,
      ),
    );
  }
}
