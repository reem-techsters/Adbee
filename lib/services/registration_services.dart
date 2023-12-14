import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:newadbee/view/registration/success_account_created_screen.dart';
import 'package:newadbee/widgets/custom_snackbar.dart';

class RegisterAndLoginServices {
  Future<void> sendUserDetails(
      {required BuildContext context,
      required String mobile,
      required String name,
      required String email,
      required String password,
      required String dob,
      required String gender,
      required String profession,
      required String state,
      required String district,
      required String pincode,
      required dynamic referral}) async {
    try {
      final Map<String, String> requestBody = {
        'name': name,
        'email': email,
        'mobileNumber': mobile,
        'password': password,
        'dob': dob,
        'gender': gender,
        'profession': profession,
        'state': state,
        'district': district,
        'pincode': pincode,
        'referral_code': referral
      };

      log('Request Body --> ${jsonEncode(requestBody)}');
      final response = await http.post(
          Uri.parse(
              'https://api.adbee.biz/api/register_view.php?action=signup'),
          body: jsonEncode(requestBody));
      log('sendUserDetails response --> ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        dynamic decodedbody = json.decode(response.body);
        if (decodedbody['status'] == true) {
          if (context.mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => AccountCreatedSuccessScreen()),
              (Route<dynamic> route) => false,
            );
          }
        } else {
          if (context.mounted) {
            showCustomSnackbar(context, decodedbody['message'], false);
          }
        }
      } else {
        log('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Caught an exception: $e');
    }
  }
}
