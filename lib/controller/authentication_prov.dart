import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:newadbee/controller/sharedprefs_prov.dart';
import 'package:newadbee/services/authentication_services.dart';
import 'package:newadbee/widgets/custom_transparent_dialogue.dart';
import 'package:provider/provider.dart';

class AuthProv extends ChangeNotifier {
  final GlobalKey<FormState> authenticationformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> loginformKey = GlobalKey<FormState>();
  late TabController tabController;

  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController mobileSignUpController = TextEditingController();
  TextEditingController forgotPasswordController = TextEditingController();
  final pinController = TextEditingController();

  bool remembermeVisibleVar = false;

  bool get remembermeVisible => remembermeVisibleVar;

  void toggleVisibility() {
    remembermeVisibleVar = !remembermeVisibleVar;
    log(remembermeVisibleVar.toString());
    notifyListeners();
  }

//-------------------------------------------* Sign Up
  Future<void> signupSendOTP(
      {required BuildContext context, bool? resendotp}) async {
    final sharedprovider = Provider.of<SharedPrefsProv>(context, listen: false);

    if (authenticationformKey.currentState!.validate()) {
      showDialogTransperent(context);
      sharedprovider.setString('saved_mobile', mobileSignUpController.text);
      Future.delayed(Duration(milliseconds: 500)).then((value) {
        pinController.clear();
        AuthenticationService().signupSendOTP(
            mobile: mobileSignUpController.text,
            context: context,
            resendotp: resendotp);
        if (context.mounted) Navigator.pop(context);
        // mobileSignUpController.clear();
      });
    }
  }

  Future<void> verifyOTP({
    required BuildContext context,
    required String mobile,
  }) async {
    await AuthenticationService().verifyOTP(
      mobile: mobile,
      otp: pinController.text,
      context: context,
    );
    pinController.clear();
  }

  //-------------------------------------------* Login
  Future<void> login({required BuildContext context}) async {
    if (loginformKey.currentState!.validate()) {
      showDialogTransperent(context);
      Future.delayed(Duration(milliseconds: 500)).then((value) {
        if (context.mounted) {
          AuthenticationService().login(
            mobile: mobileController.text,
            password: passwordController.text,
            context: context,
          );
          if (context.mounted) Navigator.pop(context);
        }
      });

      notifyListeners();
    }
  }
  // Future<void> login({required BuildContext context}) async {
  //   if (loginformKey.currentState!.validate()) {
  //     var sharedprefs = Provider.of<SharedPrefsProv>(context, listen: false);
  //     showDialogTransperent(context);
  //     if (remembermeVisibleVar == true) {
  //       // saved_mobile
  //       await sharedprefs.setString('saved_mobile', mobileController.text);
  //       await sharedprefs.setString('set_phone', mobileController.text);
  //       await sharedprefs.setString('set_password', passwordController.text);
  //       sharedprefs.setBool('isRememberme', true);
  //     } else {
  //       remembermeVisibleVar = false;
  //       sharedprefs.setBool('isRememberme', false);
  //       await sharedprefs.setString('saved_mobile', mobileController.text);
  //       await sharedprefs.deleteDataFromSharedPreferences('set_phone');
  //       await sharedprefs.deleteDataFromSharedPreferences('set_password');
  //       // clearFields();
  //     }

  //     if (context.mounted) {
  //       await AuthenticationService().login(
  //         mobile: mobileController.text,
  //         password: passwordController.text,
  //         context: context,
  //       );
  //       if (context.mounted) Navigator.pop(context);
  //     }

  //     notifyListeners();
  //   }
  // }

  //-------------------------------------------* Validator
  textFormValidation(String? value) {
    if (value!.isEmpty) {
      notifyListeners();
      return 'This is required';
    }
    return null;
  }

  String? validateMobile(String value) {
    String pattern = r'^(\+\d{1,3}\d{9}|\d{10})$';
    RegExp regExp = RegExp(pattern);

    if (value.isEmpty) {
      return 'Please enter a mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid mobile number';
    } else {
      return null;
    }
  }

  String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Please enter password';
    } else if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    } else if (password.contains('@') ||
        password.contains('"') ||
        password.contains("'")) {
      return 'Password cannot contain "@", double quotes, or single quotes';
    }

    return null;
  }

  void clearFields() {
    mobileController.clear();
    passwordController.clear();
    mobileSignUpController.clear();
    forgotPasswordController.clear();
  }

  rememberMe(BuildContext context) async {
    var sharedprefs = Provider.of<SharedPrefsProv>(context, listen: false);
    bool? isRememberme = await sharedprefs.getBool('isRememberme');
    // log(isRememberme.toString());
    if (isRememberme == true) {
      var remembermePhone = await sharedprefs.getString('set_phone');
      var remembermePass = await sharedprefs.getString('set_password');
      mobileController = TextEditingController(text: remembermePhone);
      passwordController = TextEditingController(text: remembermePass);
      remembermeVisibleVar = true;
    } else {
      mobileController = TextEditingController();
      passwordController = TextEditingController();
      remembermeVisibleVar = false;
    }
    notifyListeners();
  }
}
//-------------------------------------------* Google - SignIn
  // final googleSignIn = GoogleSignIn();
  // GoogleSignInAccount? _user;

  // GoogleSignInAccount get user => _user!;
  // Future googleLogin() async {
  //   try {
  //     final googleUser = await googleSignIn.signIn();
  //     if (googleUser == null) return;
  //     _user = googleUser;
  //     final googleAuth = await googleUser.authentication;
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     await FirebaseAuth.instance.signInWithCredential(credential);
  //   } catch (e) {
  //     log(e.toString());
  //   }

  //   notifyListeners();
  // }

  // Future googleLogout() async {
  //   await googleSignIn.disconnect();
  //   FirebaseAuth.instance.signOut();
  // }