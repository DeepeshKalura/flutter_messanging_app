import 'dart:developer' as developer;

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityController {
  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    developer.log('connectivityResult: $connectivityResult');
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }
}
