import 'package:flutter/material.dart';
import 'package:newadbee/controller/authentication_prov.dart';
import 'package:newadbee/core/fonts/fonts.dart';
import 'package:newadbee/core/icons/icons.dart';
import 'package:newadbee/view/password/forgot_password_screen.dart';
import 'package:newadbee/widgets/custom_circle_button_widget.dart';
import 'package:newadbee/widgets/custom_field_name.dart';
import 'package:newadbee/widgets/custom_textform_widget.dart';
import 'package:provider/provider.dart';
import 'package:newadbee/core/colors/colors.dart';
import 'package:newadbee/core/constants/constants.dart';

Consumer loginWidget({required BuildContext context}) {
  return Consumer<AuthProv>(builder: (context, value, child) {
    return SingleChildScrollView(
      child: Form(
        key: value.loginformKey,
        child: Column(children: [
          kheight5,
          Text(
            "Hi, Glad to have you here.",
            style: KFont().welcomeTextStyle,
          ),
          kheight50,
          customFieldName(fieldname: 'Mobile Number'),
          kheight7,
          CustomTextFormField(
            controller: value.mobileController,
            validator: (val) => value.validateMobile(val!),
            textInputType: TextInputType.phone,
            hintText: 'Enter your mobile number',
            prefixIcon: Transform.scale(
              scale: 0.37,
              child: KIcon.phone,
            ),
          ),
          kheight15,
          customFieldName(fieldname: 'Password'),
          kheight7,
          CustomTextFormField(
            controller: value.passwordController,
            validator: (val) => value.validatePassword(val!),
            obscureText: true,
            hintText: 'Enter Password',
            prefixIcon: Transform.scale(
              scale: 0.37,
              child: KIcon.key,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ForgotPasswordScreen(),
                      ));
                      value.mobileController.clear();
                      value.passwordController.clear();
                    },
                    child: Text(
                      'Forgot Password?',
                      style: KFont().forgotpassStyle,
                    )),
                TextButton.icon(
                  onPressed: () {
                    value.toggleVisibility();
                  },
                  icon: value.remembermeVisible == false
                      ? Icon(
                          Icons.square_outlined,
                          color: kGreyBlackColor,
                          size: 17,
                        )
                      : Row(
                          children: [KIcon.rem, kWidth2],
                        ),
                  label: Text(
                    'Remember me?',
                    style: KFont().forgotpassStyle,
                  ),
                )
              ],
            ),
          ),
          kheight15,
          CircleButtonWidget(
            color: kPrimaryColor,
            onPressed: () {
              value.login(context: context);
            },
          ),
        ]),
      ),
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
            //     // final provider = Provider.of<AuthProv>(context, listen: false);
            //     // provider.googleLogin();
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