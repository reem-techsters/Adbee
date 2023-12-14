import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart' show BuildContext, debugPrint;
import 'package:http/http.dart' as http;
import 'package:newadbee/controller/sharedprefs_prov.dart';
import 'package:newadbee/model/bank_ifsc_model.dart';
import 'package:newadbee/model/bank_model.dart';
import 'package:newadbee/widgets/custom_snackbar.dart';
import 'package:provider/provider.dart';

// https://api.adbee.biz/api/bank.php?ifsc_code=$ifsccode
class BankServices {
  Future<BankIfscModel?> getBankAndBranchDetails(String ifsccode) async {
    try {
      final response =
          await http.get(Uri.parse('https://ifsc.razorpay.com/$ifsccode'));
      log('IFSC Lookup reponse --> ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return BankIfscModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<BankModel?> getBankDetails({required BuildContext context}) async {
    final provider = Provider.of<SharedPrefsProv>(context, listen: false);
    final userUniqueId = await provider.getString('user_id');
    log(userUniqueId.toString());

    try {
      final Map<String, String> requestBody = {
        'user_unique_id': userUniqueId!,
      };

      final response = await http.post(
          Uri.parse('https://api.adbee.biz/api/get_data.php?action=profile'),
          body: jsonEncode(requestBody));
      log('getBankDetails response --> ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        dynamic decodedbody = json.decode(response.body);
        if (decodedbody['status'] == true) {
          return BankModel.fromJson(json.decode(response.body));
        }
      } else {
        log('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Caught an exception: $e');
    }
    return null;
  }

  Future<void> editBank({
    required BuildContext context,
    required String accnum,
    required String ifsc,
    required String upi,
  }) async {
    final provider = Provider.of<SharedPrefsProv>(context, listen: false);
    final userUniqueId = await provider.getString('user_id');
    log(userUniqueId.toString());

    try {
      final Map<String, String> requestBody = {
        "user_unique_id": userUniqueId!,
        "account_number": accnum,
        "ifsc_code": ifsc,
        "upi": upi
      };

      log('Request Body --> ${jsonEncode(requestBody)}');
      final response = await http.post(
          Uri.parse('https://api.adbee.biz/api/set_data.php?action=profile'),
          body: jsonEncode(requestBody));
      log('editBank response --> ${response.body}');

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
