import 'dart:developer' as developer;

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:rive/rive.dart';

class AuthRiveController extends ChangeNotifier {
  final riveLoginAnimationLink =
      "assets/rive/3645-7621-remix-of-login-machine.riv";

  StateMachineController? stateController;
  late SMITrigger triggerSuccess, triggerFail;
  late SMIBool isChecking, isHandUp;
  SMIInput<double>? numLook;

  Artboard? artboard;

  Future<void> intialArtBoard() async {
    rootBundle.load(riveLoginAnimationLink).then((riveFile) async {
      final file = RiveFile.import(riveFile);
      final art = file.mainArtboard;
      stateController =
          StateMachineController.fromArtboard(art, "Login Machine");
      if (stateController != null) {
        art.addController(stateController!);
        for (var element in stateController!.inputs) {
          switch (element.name) {
            case "isChecking":
              isChecking = element as SMIBool;
              break;
            case "isHandsUp":
              isHandUp = element as SMIBool;
              break;
            case "trigSuccess":
              triggerSuccess = element as SMITrigger;
              break;
            case "trigFail":
              triggerFail = element as SMITrigger;
              break;
            case "numLook":
              numLook = element as SMIInput<double>;
              break;
            default:
          }
        }
      } else {
        developer.log("Error in the controller");
      }
      artboard = art;
      notifyListeners();
    });
  }

  void checking() {
    isChecking.change(true);
    isHandUp.change(false);
    numLook?.change(0);
    notifyListeners();
  }

  void movesEyes(String value) {
    numLook?.change(value.length.toDouble());
    notifyListeners();
  }

  void hanpUp() {
    isChecking.change(false);
    isHandUp.change(true);
    notifyListeners();
  }

  void success() {
    isChecking.value = false;
    isHandUp.value = false;
    triggerSuccess.fire();
    notifyListeners();
  }

  void failure() {
    isChecking.value = false;
    isHandUp.value = false;
    triggerFail.fire();
    notifyListeners();
  }
}
