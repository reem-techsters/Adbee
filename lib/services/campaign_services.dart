import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:newadbee/controller/sharedprefs_prov.dart';
import 'package:newadbee/model/campaign_model.dart';
import 'package:newadbee/widgets/custom_snackbar.dart';
import 'package:provider/provider.dart';

class CampaignServices {
  Future<CampaignModel?> getCampaignDetails(
      {required BuildContext context}) async {
    final provider = Provider.of<SharedPrefsProv>(context, listen: false);
    final userUniqueId = await provider.getString('user_id');

    log(userUniqueId.toString());
    try {
      final Map<String, String> requestBody = {
        'user_unique_id': userUniqueId!,
      };

      final response = await http.post(
          Uri.parse('https://api.adbee.biz/api/get_data.php?action=campaign'),
          body: jsonEncode(requestBody));
      log('getCampaignDetails response --> ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        dynamic decodedbody = json.decode(response.body);
        if (decodedbody['status'] == true) {
          return CampaignModel.fromJson(json.decode(response.body));
        }
      } else {
        log('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Caught an exception: $e');
    }
    return null;
  }

  Future<void> viewedCampaign({
    required BuildContext context,
    required String campaignID,
  }) async {
    try {
      final provider = Provider.of<SharedPrefsProv>(context, listen: false);
      final userUniqueId = await provider.getString('user_id');
      log(userUniqueId.toString());

      final Map<String, String> requestBody = {
        'user_unique_id': userUniqueId!,
        "campaign_id": campaignID
      };

      log('Request Body --> ${jsonEncode(requestBody)}');
      final response = await http.post(
          Uri.parse(
              'https://api.adbee.biz/api/set_data.php?action=user_viewed_campaign'),
          body: jsonEncode(requestBody));
      log('viewedCampaign response --> ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        dynamic decodedbody = json.decode(response.body);
        if (decodedbody['status'] == true) {
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
