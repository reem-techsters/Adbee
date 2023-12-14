import 'package:flutter/material.dart';
import 'package:newadbee/controller/authentication_prov.dart';
import 'package:newadbee/controller/password_prov.dart';
import 'package:newadbee/core/colors/colors.dart';
import 'package:newadbee/core/constants/constants.dart';
import 'package:newadbee/core/fonts/fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class VerificationScreen extends StatefulWidget {
  final String phonenumber;
  final String directedfrom;
  const VerificationScreen({
    super.key,
    required this.phonenumber,
    required this.directedfrom,
  });

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 36,
      height: 36,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: kGreyBlackColor)),
      ),
    );
    return Scaffold(
      body: SafeArea(child: Consumer2<AuthProv, PasswordProv>(
          builder: (context, value, passwordvalue, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            kheight30,
            Row(
              children: [
                kWidth30,
                InkWell(
                    splashColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back)),
              ],
            ),
            kheight30,
            Text(
              "Phone Verification",
              style: KFont().h1BoldStyle,
            ),
            kheight20,
            Text(
              "We've sent you an SMS to",
              style: KFont().forgotpassStyle,
            ),
            kheight5,
            Text(
              '+91 ${widget.phonenumber}',
              style: KFont().tealStyle,
            ),
            kheight80,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Consumer2<AuthProv, PasswordProv>(
                    builder: (context, value, passwordvalue, child) {
                      return Pinput(
                        length: 6,
                        controller: widget.directedfrom == 'forgotpassword'
                            ? passwordvalue.forgotOTPController
                            : value.pinController,
                        focusNode: focusNode,
                        androidSmsAutofillMethod:
                            AndroidSmsAutofillMethod.smsUserConsentApi,
                        listenForMultipleSmsOnAndroid: true,
                        defaultPinTheme: defaultPinTheme,
                        separatorBuilder: (index) => const SizedBox(width: 12),
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        onCompleted: (pin) async {
                          debugPrint('onCompleted: $pin');
                          widget.directedfrom == 'forgotpassword'
                              ? passwordvalue.verifyForgotPasswordOTP(
                                  context: context)
                              : value.verifyOTP(
                                  context: context,
                                  mobile: widget.phonenumber,
                                );
                        },
                        onChanged: (value) {
                          debugPrint('onChanged: $value');
                        },
                        focusedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            border: Border(
                                bottom: BorderSide(color: kGreyBlackColor)),
                          ),
                        ),
                        submittedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            border: Border(
                                bottom: BorderSide(color: kGreyBlackColor)),
                          ),
                        ),
                        errorPinTheme: defaultPinTheme.copyBorderWith(
                          border: Border(bottom: BorderSide(color: kRed)),
                        ),
                      );
                    },
                  )),
            ),
            kheight15,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Didn't receive code? ",
                  style: KFont().forgotpassStyle,
                ),
                InkWell(
                  onTap: () {
                    widget.directedfrom == 'forgotpassword'
                        ? passwordvalue.forgotPasswordSendOTP(
                            context: context, resendotp: true)
                        : value.signupSendOTP(
                            context: context, resendotp: true);
                  },
                  child: Text(
                    "Request Again",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        );
      })),
    );
  }
}
