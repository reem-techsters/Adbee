import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:newadbee/view/authentication/verification_screen.dart';
import 'package:newadbee/view/password/change_password_screen.dart';
import 'package:newadbee/view/password/success_password_update.dart';
import 'package:newadbee/widgets/custom_snackbar.dart';

class PasswordService {
  Future<void> forgotPasswordSendOTP({
    required String mobile,
    required BuildContext context,
    required bool? resendotp,
  }) async {
    log(mobile);
    try {
      Map data = {
        'mobile': mobile,
        'action': "forget",
      };
      var body = json.encode(data);

      final response = await http.post(
          Uri.parse('https://api.adbee.biz/api/forget_password_api.php'),
          body: body);

      log('forgotPassword - SendOTP response --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        var decodedbody = json.decode(response.body);
        if (decodedbody['status'] == 'otp_success') {
          if (context.mounted) {
            showCustomSnackbar(context, decodedbody['message'], true);
            if (resendotp == null) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VerificationScreen(
                            phonenumber: mobile,
                            directedfrom: 'forgotpassword',
                          )));
            }
          }
        } else {
          if (context.mounted) {
            showCustomSnackbar(context, decodedbody['message'], false);
          }
        }
      } else {
        if (context.mounted) {
          showCustomSnackbar(context, 'Failed to sent OTP', false);
        }
        log('failed');
      }
    } catch (e) {
      debugPrint('catche is $e');
      return;
    }
    return;
  }

  Future<void> forgotPasswordVerifyOTP({
    required String otp,
    required BuildContext context,
  }) async {
    try {
      Map data = {
        'otp': otp,
        'action': "verify_otp",
      };
      var body = json.encode(data);

      final response = await http.post(
          Uri.parse('https://api.adbee.biz/api/forget_password_api.php'),
          body: body);

      log('forgotPassword - VerifyOTP response --> \n ${response.body}');
      if (context.mounted) Navigator.of(context).pop();
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        var decodedbody = json.decode(response.body);
        if (decodedbody['success'] == 'true') {
          if (context.mounted) {
            showCustomSnackbar(context, decodedbody['message'], true);

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangePasswordScreen()));
          }

          log('Successful');
        } else {
          if (context.mounted) {
            showCustomSnackbar(context, decodedbody['message'], false);
          }
        }
      } else {
        if (context.mounted) {
          showCustomSnackbar(context, 'Failed to sent OTP', false);
        }
        log('failed');
      }
    } catch (e) {
      debugPrint('catche is $e');
      return;
    }
    return;
  }

  Future<void> resetPassword({
    required String newPassword,
    required String confirmPassword,
    required String mobile,
    required BuildContext context,
  }) async {
    try {
      Map data = {
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
        'action': "reset_password",
        'mobile': mobile,
      };
      var body = json.encode(data);

      final response = await http.post(
          Uri.parse('https://api.adbee.biz/api/forget_password_api.php'),
          body: body);

      log('resetPassword response --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        var decodedbody = json.decode(response.body);
        if (decodedbody['success'] == 'true') {
          if (context.mounted) {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SuccessPasswordScreen()));
          }
        } else {
          if (context.mounted) {
            Navigator.pop(context);
            showCustomSnackbar(context, decodedbody['message'], false);
          }
        }
      } else {
        if (context.mounted) {
          Navigator.pop(context);
          showCustomSnackbar(context, 'Failed to sent OTP', false);
        }
        log('failed');
      }
    } catch (e) {
      debugPrint('catche is $e');
      return;
    }
    return;
  }
}
