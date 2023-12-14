import 'package:flutter/material.dart';
import 'package:newadbee/core/colors/colors.dart';
import 'package:newadbee/core/fonts/fonts.dart';

Padding customDropdownWidget({
  Function(String?)? onChanged,
  required String? dropdownvalue,
  required List<String> dropdownList,
  required String hintText,
  String? errorText,
  dynamic icon,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
    child: SizedBox(
      child: DropdownButtonFormField(
        isDense: true,
        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
            hintText: hintText,
            hintStyle: KFont().hintTextStyle,
            prefixIcon: icon,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(color: kGreyBlackColor)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(color: kGreyBlackColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(color: kGreyBlackColor),
            )),
        isExpanded: true,
        value: dropdownvalue,
        icon: Padding(
          padding: const EdgeInsets.only(right: 22.0),
          child: const Icon(
            Icons.keyboard_arrow_down,
            color: kGrey,
          ),
        ),
        items: dropdownList.map((String item) {
          return DropdownMenuItem(
            value: item,
            child: Text(
              item,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 13,
                color: item == 'Select your gender' ||
                        item == 'Enter your profession'
                    ? kHintTextGreyColor
                    : kFieldNameGreyBlackColor,
              ),
            ),
          );
        }).toList(),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return errorText;
          }
          return null;
        },
        onChanged: onChanged,
      ),
    ),
  );
}
