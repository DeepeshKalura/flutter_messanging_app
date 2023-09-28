import 'dart:typed_data';

import 'package:http/http.dart' as http;

class RandomImageAPIController {
  static Future<Uint8List> getRandomAvator() async {
    //API URL
    const String url =
        'https://api.dicebear.com/7.x/avataaars/svg?seed=Felix&scale=100';

    //API call
    final http.Response response = await http.get(Uri.parse(url));

    //returning image URL
    return response.bodyBytes;
  }
}
