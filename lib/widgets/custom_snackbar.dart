import 'package:flutter/material.dart';

void showCustomSnackbar(BuildContext context, String message, bool isSuccess,
    {Widget? additionalContent}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message),
          if (additionalContent != null) SizedBox(height: 8),
          if (additionalContent != null) additionalContent,
        ],
      ),
      backgroundColor: isSuccess ? Colors.green : Colors.red,
    ),
  );
}
