import 'package:flutter/material.dart';
import 'package:newadbee/controller/password_prov.dart';
import 'package:newadbee/core/colors/colors.dart';
import 'package:newadbee/core/constants/constants.dart';
import 'package:newadbee/core/fonts/fonts.dart';
import 'package:newadbee/core/icons/icons.dart';
import 'package:newadbee/widgets/custom_circle_button_widget.dart';
import 'package:newadbee/widgets/custom_textform_widget.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<PasswordProv>(builder: (context, value, child) {
          return Form(
            key: value.forgotpasswordformKey,
            child: Column(
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
                  'Forgot Password',
                  style: KFont().h1BoldStyle,
                ),
                kheight15,
                Text(
                  'Please enter your registered mobile number',
                  style: KFont().forgotpassStyle,
                ),
                kheight5,
                Text(
                  'to verify you?',
                  style: KFont().tealStyle,
                ),
                kheight50,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    kWidth30,
                    Text(
                      "Your Number",
                      style: KFont().fieldNameStyle,
                    ),
                  ],
                ),
                kheight7,
                CustomTextFormField(
                  hintText: 'Enter your mobile number',
                  controller: value.forgotmobileController,
                  validator: (val) => value.validateMobile(val!),
                  prefixIcon: Transform.scale(
                    scale: 0.37,
                    child: KIcon.phone,
                  ),
                ),
                kheight30,
                CircleButtonWidget(
                    onPressed: () {
                      value.forgotPasswordSendOTP(context: context);
                    },
                    color: kPrimaryColor),
              ],
            ),
          );
        }),
      ),
    );
  }
}
