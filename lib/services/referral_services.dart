import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:newadbee/controller/sharedprefs_prov.dart';
import 'package:newadbee/model/referral_model.dart';
import 'package:provider/provider.dart';

class ReferralServices {
  Future<ReferModel?> getReferral({required BuildContext context}) async {
    final provider = Provider.of<SharedPrefsProv>(context, listen: false);
    final userUniqueId = await provider.getString('user_id');
    log(userUniqueId.toString());

    try {
      final Map<String, String> requestBody = {
        'user_unique_id': userUniqueId!,
      };

      final response = await http.post(
          Uri.parse(
              'https://api.adbee.biz/api/get_data.php?action=get_referral'),
          body: jsonEncode(requestBody));
      log('getReferral response --> ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        dynamic decodedbody = json.decode(response.body);
        if (decodedbody['status'] == true) {
          return ReferModel.fromJson(json.decode(response.body));
        }
      } else {
        log('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Caught an exception: $e');
    }
    return null;
  }
}
