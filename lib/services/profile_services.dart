import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:newadbee/controller/sharedprefs_prov.dart';
import 'package:newadbee/model/profile_model.dart';
import 'package:newadbee/widgets/custom_snackbar.dart';
import 'package:provider/provider.dart';

class ProfileServices {
  Future<ProfileModel?> getProfileDetails(
      {required BuildContext context}) async {
    final provider = Provider.of<SharedPrefsProv>(context, listen: false);
    final userUniqueId = await provider.getString('user_id');
    log(userUniqueId.toString());
    log(provider.getString('user_id').toString());
    try {
      final Map<String, String> requestBody = {
        'user_unique_id': userUniqueId!,
      };

      final response = await http.post(
          Uri.parse('https://api.adbee.biz/api/get_data.php?action=profile'),
          body: jsonEncode(requestBody));
      log('getProfileDetails response --> ${json.decode(response.body)['status']}');
       log('getProfileDetails response --> ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        dynamic decodedbody = json.decode(response.body);
        if (decodedbody['status'] == true) {
          return ProfileModel.fromJson(json.decode(response.body));
        }
      } else {
        log('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Caught an exception: $e');
    }
    return null;
  }

  Future<void> editProfile({
    required BuildContext context,
    required String name,
    required String email,
    required String profession,
    required dynamic image,
  }) async {
    final provider = Provider.of<SharedPrefsProv>(context, listen: false);
    final userUniqueId = await provider.getString('user_id');

    log(userUniqueId.toString());

    try {
      final Map<String, String> requestBody = {
        "user_unique_id": userUniqueId!,
        "name": name,
        "email": email,
        "profession": profession,
        "image": image
      };
      final response = await http.post(
          Uri.parse('https://api.adbee.biz/api/set_data.php?action=profile'),
          body: jsonEncode(requestBody));
      log('editProfile response --> ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        dynamic decodedbody = json.decode(response.body);
        if (decodedbody['status'] == true) {
          if (context.mounted) {
            showCustomSnackbar(context, 'Profile Update Successful', true);
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
