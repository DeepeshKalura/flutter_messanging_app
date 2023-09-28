import 'dart:developer' as developer;
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

import 'connectivity_controller.dart';

class StorageFirebaseController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ConnectivityController _connectivityController;
  StorageFirebaseController(this._connectivityController);

  // Upload a file to Firebase Storage
  Future<String> uploadFile(
    String fileName,
    Uint8List file,
    String? fileType,
  ) async {
    developer.log("uploadFile: $fileName, $file, $fileType");

    try {
      bool hasInternet =
          await _connectivityController.checkInternetConnectivity();
      if (!hasInternet) {
        developer.log("No internet connection");
        throw Exception("No internet connection");
      }
      final Reference ref = _storage.ref().child(fileName);
      final UploadTask uploadTask = ref.putFile(File.fromRawPath(file));
      final TaskSnapshot taskSnapshot = await uploadTask;
      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      developer.log("Error during file upload: $error");
      return error.toString();
    }
  }

  // Download a file from Firebase Storage
  Future<String?> downloadFile(String url) async {
    try {
      bool hasInternet =
          await _connectivityController.checkInternetConnectivity();
      if (!hasInternet) {
        developer.log("No internet connection");
        throw Exception("No internet connection");
      }
      final http.Response response = await http.get(Uri.parse(url));
      return response.body;
    } catch (error) {
      developer.log("Error during file download: $error");
      return null;
    }
  }
}
