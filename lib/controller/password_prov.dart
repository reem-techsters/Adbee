import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:newadbee/controller/sharedprefs_prov.dart';
import 'package:newadbee/services/password_services.dart';
import 'package:newadbee/widgets/custom_transparent_dialogue.dart';
import 'package:provider/provider.dart';

class PasswordProv extends ChangeNotifier {
  final GlobalKey<FormState> forgotpasswordformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> resetpasswordformKey = GlobalKey<FormState>();

  TextEditingController forgotmobileController = TextEditingController();
  TextEditingController forgotOTPController = TextEditingController();

  TextEditingController resetPasswordController = TextEditingController();
  TextEditingController resetConfirmPassController = TextEditingController();

  Future<void> forgotPasswordSendOTP(
      {required BuildContext context, bool? resendotp}) async {
    log(resendotp.toString());
    resendotp = resendotp;
    if (forgotpasswordformKey.currentState!.validate()) {
      await PasswordService().forgotPasswordSendOTP(
          mobile: forgotmobileController.text,
          context: context,
          resendotp: resendotp);
      forgotOTPController.clear();
    }
  }

  Future<void> verifyForgotPasswordOTP({
    required BuildContext context,
  }) async {
    await PasswordService().forgotPasswordVerifyOTP(
        otp: forgotOTPController.text, context: context);
    forgotOTPController.clear();
  }

  Future<void> resetPassword({
    required BuildContext context,
  }) async {
    final sharedprovider = Provider.of<SharedPrefsProv>(context, listen: false);
    if (resetpasswordformKey.currentState!.validate()) {
      final mobile = await sharedprovider.getString('saved_mobile');
      if (context.mounted) {
        showDialogTransperent(context);
        await PasswordService().resetPassword(
            newPassword: resetPasswordController.text,
            confirmPassword: resetConfirmPassController.text,
            mobile: mobile!,
            context: context);
      }
      resetPasswordController.clear();
      resetConfirmPassController.clear();
    }
  }

  //-------------------------------------------* Validator
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

  String? validateConfirmPassword(String confirmPassword, String password) {
    if (confirmPassword.isEmpty) {
      return 'Please confirm your password';
    } else if (confirmPassword != password) {
      return 'Passwords do not match';
    }

    return null;
  }
}
