import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newadbee/controller/sharedprefs_prov.dart';
import 'package:newadbee/model/closed_ticket_model.dart';
import 'package:newadbee/model/open_ticket_model.dart';
import 'package:newadbee/model/ticket_conversion_model.dart';
import 'package:newadbee/widgets/custom_snackbar.dart';
import 'package:provider/provider.dart';

class TicketServices {
  Future<void> createticket({
    required BuildContext context,
    required String subject,
    required String query,
  }) async {
    final provider = Provider.of<SharedPrefsProv>(context, listen: false);
    final userUniqueId = await provider.getString('user_id');

    try {
      final Map<String, String> requestBody = {
        "user_unique_id": userUniqueId!,
        "subject": subject,
        "query": query,
      };
      log(requestBody.toString());
      final response = await http.post(
          Uri.parse(
              'https://api.adbee.biz/api/set_data.php?action=create_ticket'),
          body: jsonEncode(requestBody));
      log('createticket response --> ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        dynamic decodedbody = json.decode(response.body);
        if (decodedbody['status'] == true) {
          if (context.mounted) {
            showCustomSnackbar(context, decodedbody['message'], true);
          }
        }
      } else {
        log('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Caught an exception: $e');
    }
  }

  Future<TicketDetailsModel?> getTicketDetails({
    required BuildContext context,
    required String ticketID,
  }) async {
    final provider = Provider.of<SharedPrefsProv>(context, listen: false);
    final userUniqueId = await provider.getString('user_id');
    log(userUniqueId.toString());

    try {
      final Map<String, String> requestBody = {
        'user_unique_id': userUniqueId!,
        "ticket_id": ticketID,
      };

      final response = await http.post(
          Uri.parse(
              'https://api.adbee.biz/api/get_data.php?action=ticket_details'),
          body: jsonEncode(requestBody));
      log('getTicketDetails response --> ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        dynamic decodedbody = json.decode(response.body);
        if (decodedbody['status'] == true) {
          return TicketDetailsModel.fromJson(json.decode(response.body));
        }
      } else {
        log('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Caught an exception: $e');
    }
    return null;
  }

  Future<OpenTicketModel?> getOpenTicket({
    required BuildContext context,
  }) async {
    final provider = Provider.of<SharedPrefsProv>(context, listen: false);
    final userUniqueId = await provider.getString('user_id');
    log(userUniqueId.toString());

    try {
      final Map<String, String> requestBody = {
        'user_unique_id': userUniqueId!,
      };

      final response = await http.post(
          Uri.parse(
              'https://api.adbee.biz/api/get_data.php?action=open_tickets'),
          body: jsonEncode(requestBody));
      log('getOpenTicket response --> ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        dynamic decodedbody = json.decode(response.body);
        if (decodedbody['status'] == true) {
          return OpenTicketModel.fromJson(json.decode(response.body));
        }
      } else {
        log('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Caught an exception: $e');
    }
    return null;
  }

  Future<ClosedTicketModel?> getClosedTicket({
    required BuildContext context,
  }) async {
    final provider = Provider.of<SharedPrefsProv>(context, listen: false);
    final userUniqueId = await provider.getString('user_id');
    log(userUniqueId.toString());

    try {
      final Map<String, String> requestBody = {
        'user_unique_id': userUniqueId!,
      };

      final response = await http.post(
          Uri.parse(
              'https://api.adbee.biz/api/get_data.php?action=close_tickets'),
          body: jsonEncode(requestBody));
      log('getClosedTicket response --> ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        dynamic decodedbody = json.decode(response.body);
        if (decodedbody['status'] == true) {
          return ClosedTicketModel.fromJson(json.decode(response.body));
        }
      } else {
        log('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Caught an exception: $e');
    }
    return null;
  }

  Future<TicketDetailsModel?> replyTicket({
    required BuildContext context,
    required String ticketID,
    required String query,
  }) async {
    final provider = Provider.of<SharedPrefsProv>(context, listen: false);
    final userUniqueId = await provider.getString('user_id');
    log(userUniqueId.toString());

    try {
      final Map<String, String> requestBody = {
        'user_unique_id': userUniqueId!,
        "ticket_id": ticketID,
        "query": query,
      };

      final response = await http.post(
          Uri.parse(
              'https://api.adbee.biz/api/set_data.php?action=reply_ticket'),
          body: jsonEncode(requestBody));
      log('replyTicket response --> ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        dynamic decodedbody = json.decode(response.body);
        if (decodedbody['status'] == true) {
          if (context.mounted) {
            showCustomSnackbar(context, decodedbody['message'], true);
          }
          return TicketDetailsModel.fromJson(json.decode(response.body));
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
