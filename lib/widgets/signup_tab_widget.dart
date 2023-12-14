import 'package:newadbee/controller/authentication_prov.dart';
import 'package:newadbee/core/colors/colors.dart';
import 'package:newadbee/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:newadbee/core/fonts/fonts.dart';
import 'package:newadbee/core/icons/icons.dart';
import 'package:newadbee/widgets/custom_circle_button_widget.dart';
import 'package:newadbee/widgets/custom_field_name.dart';
import 'package:provider/provider.dart';
import 'custom_textform_widget.dart';

Consumer signUpWidget() {
  return Consumer<AuthProv>(builder: (context, value, child) {
    return Form(
      key: value.authenticationformKey,
      child: Column(children: [
        kheight5,
        Text(
          "Let's get started with creating your account.",
          style: KFont().welcomeTextStyle,
        ),
        kheight80,
        customFieldName(fieldname: 'Mobile Number'),
        kheight7,
        CustomTextFormField(
          controller: value.mobileSignUpController,
          validator: (val) {
            return value.validateMobile(val!);
          },
          textInputType: TextInputType.phone,
          hintText: 'Enter your mobile number',
          prefixIcon: Transform.scale(
            scale: 0.37,
            child: KIcon.phone,
          ),
        ),
        kheight15,
        CircleButtonWidget(
            onPressed: () {
              value.signupSendOTP(context: context);
            },
            color: kPrimaryColor),
        Expanded(child: SizedBox()),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'By creating an account, you agree to our ',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 11.5,
                color: Colors.black,
              ),
            ),
            Text(
              'terms and conditions',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 11.5,
                color: Colors.blue,
              ),
            ),
            Text(
              ' and',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 11.5,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const Text(
          'privacy policy.',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 11.5,
            color: Colors.blue,
          ),
        ),
        kheight30
      ]),
    );
  });
}
 // kheight50,
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Container(
          //       height: 1,
          //       width: 150,
          //       color: kGrey,
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Text(
          //         'OR',
          //         style: KFont().orStyle,
          //       ),
          //     ),
          //     Container(
          //       height: 1,
          //       width: 150,
          //       color: kGrey,
          //     ),
          //   ],
          // ),
          // kheight10,
          // ElevatedButton(
          //   onPressed: () {
          //     final provider = Provider.of<AuthProv>(context, listen: false);
          //     provider.googleLogin();
          //   },
          //   style: ElevatedButton.styleFrom(
          //       backgroundColor: kWhite,
          //       shadowColor: kBlack,
          //       elevation: 5,
          //       fixedSize: const Size(340, 40),
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(30),
          //           side: const BorderSide(color: kPrimaryColor, width: 2))),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Transform.scale(
          //         scale: 0.8,
          //         child: KIcon.google,
          //       ),
          //       Text(
          //         '   Continue with Google',
          //         style: KFont().googleStyle,
          //       ),
          //     ],
          //   ),
          // ),