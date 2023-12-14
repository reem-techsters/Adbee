import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:newadbee/controller/sharedprefs_prov.dart';
import 'package:newadbee/model/earnings_model.dart';
import 'package:newadbee/model/payments_model.dart';
import 'package:newadbee/widgets/custom_snackbar.dart';
import 'package:provider/provider.dart';

class WalletServices {
  Future<TransactionsModel?> getTransactions(
      {required BuildContext context}) async {
    final provider = Provider.of<SharedPrefsProv>(context, listen: false);
    final userUniqueId = await provider.getString('user_id');

    log(userUniqueId.toString());

    try {
      final Map<String, String> requestBody = {
        'user_unique_id': userUniqueId!,
      };

      final response = await http.post(
          Uri.parse(
              'https://api.adbee.biz/api/get_data.php?action=payment_logs'),
          body: jsonEncode(requestBody));
      log('Transactions response --> ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        dynamic decodedbody = json.decode(response.body);
        if (decodedbody['status'] == true) {
          return TransactionsModel.fromJson(json.decode(response.body));
        }
      } else {
        log('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Caught an exception: $e');
    }
    return null;
  }

  Future<EarningsModel?> getEarnings({required BuildContext context}) async {
    final provider = Provider.of<SharedPrefsProv>(context, listen: false);
    final userUniqueId = await provider.getString('user_id');

    log(userUniqueId.toString());

    try {
      final Map<String, String> requestBody = {
        'user_unique_id': userUniqueId!,
      };

      final response = await http.post(
          Uri.parse(
              'https://api.adbee.biz/api/get_data.php?action=viewed_campaign'),
          body: jsonEncode(requestBody));
      log('Earnings response --> ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        dynamic decodedbody = json.decode(response.body);
        if (decodedbody['status'] == true) {
          return EarningsModel.fromJson(json.decode(response.body));
        }
      } else {
        log('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Caught an exception: $e');
    }
    return null;
  }

  Future<void> paymentWithdrawal({
    required BuildContext context,
    required String coins,
    required String paymentType,
  }) async {
    try {
      final provider = Provider.of<SharedPrefsProv>(context, listen: false);
      final userUniqueId = await provider.getString('user_id');
      log(userUniqueId.toString());

      final Map<String, String> requestBody = {
        'user_unique_id': userUniqueId!,
        "coins": coins,
        "paymenttype": paymentType
      };
      log('Request Body --> ${jsonEncode(requestBody)}');
      final response = await http.post(
          Uri.parse(
              'https://api.adbee.biz/api/set_data.php?action=create_withdraw'),
          body: jsonEncode(requestBody));
      log('paymentWithdrawalﬁ response --> ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        dynamic decodedbody = json.decode(response.body);
        if (decodedbody['status'] == true) {
          if (context.mounted) {
            showCustomSnackbar(context, decodedbody['message'], true);
            Navigator.pop(context);
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
