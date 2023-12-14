import 'package:newadbee/core/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:newadbee/core/fonts/fonts.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final dynamic prefixIcon;
  final dynamic suffixIcon;
  final TextStyle? hintStyle;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final bool? obscureText;
  final bool? enabled;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.hintStyle,
    this.controller,
    this.textInputType,
    this.obscureText,
    this.enabled,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
      child: TextFormField(
        enabled: enabled,
        style: const TextStyle(
          fontFamily: 'Roboto',
          color: kFieldNameGreyBlackColor,
          fontSize: 14,
        ),
        controller: controller,
        textAlign: TextAlign.justify,
        decoration: InputDecoration(
          filled: true,
          fillColor: kWhite,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding: prefixIcon == null
              ? const EdgeInsets.only(left: 38.0)
              : const EdgeInsets.all(10),
          hintText: hintText,
          hintStyle: KFont().hintTextStyle,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: kGreyBlackColor, width: 15),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: kGreyBlackColor, width: 1),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: kGreyBlackColor, width: 1),
          ),
        ),
        obscureText: obscureText ?? false,
        keyboardType: textInputType,
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}
