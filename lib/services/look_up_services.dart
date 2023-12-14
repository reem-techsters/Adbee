import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart' show debugPrint;
import 'package:http/http.dart' as http;
import 'package:newadbee/model/look_up_model.dart';

class LookUpServices {
  Future<LookUpModel?> getLookUps() async {
    try {
      final response =
          await http.get(Uri.parse('https://api.adbee.biz/api/lookups.php'));
      log('getLookUps response --> ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return LookUpModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }
}
