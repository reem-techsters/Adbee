import 'package:flutter/material.dart';
import 'package:newadbee/core/colors/colors.dart';

customDropValidation({
  required String dropval,
  required String message,
}) {
  return dropval == message
      ? Padding(
          padding: const EdgeInsets.only(top: 5.0, left: 30.0, right: 30.0),
          child: Row(
            children: [
              Text(
                message,
                style: TextStyle(
                  color: kvalidationColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        )
      : SizedBox();
}
