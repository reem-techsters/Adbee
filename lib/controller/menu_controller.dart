import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:newadbee/controller/sharedprefs_prov.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuProv extends ChangeNotifier {
  bool isMenu = false;

  var textValue = 'Switch is OFF';

  void toggleMenu(bool value) {
    if (isMenu == false) {
      isMenu = true;

      notifyListeners();
      log('ON');
    } else {
      isMenu = false;

      notifyListeners();
      log('OFF');
    }
    notifyListeners();
  }

  bool? isDND;
  bool isSwitched = false;
  Future<void> toggleSwitch(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final sharedProvider = Provider.of<SharedPrefsProv>(context, listen: false);

    isSwitched = !isSwitched;
    await sharedProvider.setBool('isDND', isSwitched);
    notifyListeners();
    isDND = prefs.getBool('isDND') ?? false;
    log('isDND menun --> ${isDND.toString()}');
    notifyListeners();
  }

  // void toggleSwitch(bool value, BuildContext context) async {
  //   var sharedprovider = Provider.of<SharedPrefsProv>(context, listen: false);

  //   if (isSwitched == false) {
  //     isSwitched = true;
  //     sharedprovider.setBool('isDND', true);

  //     notifyListeners();
  //     log('Switch Button is ON');
  //   } else {
  //     isSwitched = false;
  //     sharedprovider.setBool('isDND', false);

  //     notifyListeners();
  //     log('Switch Button is OFF');
  //   }
  //   notifyListeners();
  // }
}
