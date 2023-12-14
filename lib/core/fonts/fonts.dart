import 'package:flutter/material.dart';
import 'package:newadbee/core/colors/colors.dart';

class KFont {
  TextStyle welcomeTextStyle = const TextStyle(
    fontFamily: 'Roboto',
    color: kWelcomeTextColor,
    fontSize: 11.0,
  );

  TextStyle hintTextStyle = const TextStyle(
    fontFamily: 'Roboto',
    color: kHintTextGreyColor,
    fontSize: 13,
  );

  TextStyle fieldNameStyle = const TextStyle(
    fontFamily: 'Roboto',
    color: kFieldNameGreyBlackColor,
    fontWeight: FontWeight.w400,
    fontSize: 11.0,
  );
  TextStyle fieldHeading = const TextStyle(
    fontFamily: 'Roboto',
    color: kFieldNameGreyBlackColor,
    fontWeight: FontWeight.bold,
    fontSize: 13.0,
  );
  TextStyle orStyle = const TextStyle(
    fontFamily: 'Roboto',
    color: kWelcomeTextColor,
    height: 1.5,
  );

  TextStyle googleStyle = const TextStyle(
    fontFamily: 'Roboto',
    color: kPrimaryColor,
  );

  TextStyle forgotpassStyle = const TextStyle(
    fontFamily: 'Roboto',
    color: kFieldNameGreyBlackColor,
    fontWeight: FontWeight.w500,
    fontSize: 13.0,
  );

  TextStyle tealStyle = const TextStyle(
    fontFamily: 'Roboto',
    color: kTealColor,
    fontWeight: FontWeight.w500,
    fontSize: 13.0,
  );

  TextStyle h1BoldStyle = const TextStyle(
      fontFamily: 'Roboto',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: kGreyBlackColor);

  TextStyle robotoSemiBold = const TextStyle(
      color: kWhite,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w600,
      fontSize: 22.0,
      letterSpacing: .2);

  TextStyle poppinsRegular = const TextStyle(
    color: kWhite,
    fontFamily: 'Roboto',
    fontSize: 15.0,
  );

  TextStyle walletStyle = const TextStyle(
    fontFamily: 'Roboto',
    color: kGreyBlackColor,
    fontSize: 25,
    fontWeight: FontWeight.w600,
  );

  TextStyle coinStyle = const TextStyle(
    fontFamily: 'Roboto',
    fontSize: 25,
    color: kGreyBlackColor,
    fontWeight: FontWeight.w600,
  );
}
