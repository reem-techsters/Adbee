import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newadbee/controller/authentication_prov.dart';
import 'package:newadbee/controller/sharedprefs_prov.dart';
import 'package:newadbee/view/authentication/verification_screen.dart';
import 'package:newadbee/view/registration/create_account_screen.dart';
import 'package:newadbee/view/calls/call_screen.dart';
import 'package:newadbee/widgets/custom_snackbar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService {
  Future<void> signupSendOTP(
      {required String mobile,
      required BuildContext context,
      bool? resendotp}) async {
    try {
      final Map<String, String> requestBody = {
        'action': 'send_otp',
        'mobile': mobile,
      };

      // Map data = {
      //   'action': 'send_otp',
      //   'mobile': mobile,
      // };
      // var body = json.encode(data);

      final response = await http.post(
          Uri.parse('https://api.adbee.biz/api/signup_otp.php'),
          body: jsonEncode(requestBody));

      log('signupSendOTP response --> \n ${response.body}');
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        var decodedbody = json.decode(response.body);

        if (decodedbody['message'] == 'OTP sent successfully.') {
          if (context.mounted) {
            if (resendotp == null) {
              if (context.mounted) {
                showCustomSnackbar(context, 'OTP sent Successfully', true);
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => VerificationScreen(
                          phonenumber: mobile,
                          directedfrom: 'registration',
                        )),
              );
            }
          }
        } else {
          if (context.mounted) {
            showCustomSnackbar(context, 'Number already Registered', false);
          }
          log('Already Registered');
        }

        log('Successful');
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

  Future<void> verifyOTP({
    required String mobile,
    required String otp,
    required BuildContext context,
  }) async {
    try {
      Map data = {
        'action': 'verify_otp',
        'mobile': mobile,
        'otp': otp,
      };
      var body = json.encode(data);
      final response = await http.post(
          Uri.parse('https://api.adbee.biz/api/signup_otp.php'),
          body: body);
      log('verifyOTP response --> \n ${response.body}');
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        dynamic decodedbody = json.decode(response.body);
        if (decodedbody['message'] == 'OTP verified Successfully.') {
          if (context.mounted) {
            showCustomSnackbar(context, 'OTP verified Successfully', true);

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => CreateAccountScreen()),
              (Route<dynamic> route) => false,
            );
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            prefs.setBool('isOtpVerified', true);
          }
        }
        log('Successful');
      } else {
        if (context.mounted) {
          showCustomSnackbar(context, 'OTP verification Failed', false);
        }
        log('INVALID OTP');

        log('failed');
      }
    } catch (e) {
      debugPrint('catche is $e');
      return;
    }
    return;
  }

  Future<void> login({
    required String mobile,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final Map<String, dynamic> data = {
        'mobileNumber': mobile,
        'password': password,
      };

      final String jsonData = jsonEncode(data);
      log('before send --> $jsonData');

      final response = await http.post(
        Uri.parse('https://api.adbee.biz/api/register_view.php?action=login'),
        body: jsonData,
      );
      log('Login response --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        dynamic decodedbody = json.decode(response.body);
        if (decodedbody['status'] == true) {
          final authProvider = Provider.of<AuthProv>(context, listen: false);
          var sharedprefs =
              Provider.of<SharedPrefsProv>(context, listen: false);
          if (authProvider.remembermeVisibleVar == true) {
            // saved_mobile
            await sharedprefs.setString(
                'saved_mobile', authProvider.mobileController.text);
            await sharedprefs.setString(
                'set_phone', authProvider.mobileController.text);
            await sharedprefs.setString(
                'set_password', authProvider.passwordController.text);
            sharedprefs.setBool('isRememberme', true);
          } else {
            authProvider.remembermeVisibleVar = false;
            sharedprefs.setBool('isRememberme', false);
            await sharedprefs.setString(
                'saved_mobile', authProvider.mobileController.text);
            await sharedprefs.deleteDataFromSharedPreferences('set_phone');
            await sharedprefs.deleteDataFromSharedPreferences('set_password');
            // clearFields();
          }
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('isLoggedIn', true);
          prefs.setString('user_id', decodedbody['data']['user_unique_id']);
          if (context.mounted) {
            showCustomSnackbar(context, 'Successfully logged in.', true);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => CallScreen()),
              (Route<dynamic> route) => false,
            );
          }
        } else {
          if (context.mounted) {
            showCustomSnackbar(context, decodedbody['message'], false);
          }
        }
      } else {
        if (context.mounted) {
          showCustomSnackbar(context, 'Failed to Login', false);
        }
        log('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Caught an exception: $e');
    }
  }
}
