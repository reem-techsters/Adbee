import 'package:flutter/material.dart';
import 'package:newadbee/core/constants/constants.dart';
import 'package:newadbee/core/fonts/fonts.dart';

customFieldName({required String fieldname}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      kWidth30,
      Text(
        fieldname,
        style: KFont().fieldNameStyle,
      ),
    ],
  );
}
