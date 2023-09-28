import 'package:flutter/material.dart';

import '../../view/screen/register_screen.dart';
import 'routes_name_controller.dart';

class RoutesController {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case (RoutesNameController.register):
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          ),
        );
    }
  }
}
