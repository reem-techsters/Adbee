import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newadbee/controller/password_prov.dart';
import 'package:newadbee/core/colors/colors.dart';
import 'package:newadbee/core/constants/constants.dart';
import 'package:newadbee/core/fonts/fonts.dart';
import 'package:newadbee/widgets/custom_circle_button_widget.dart';
import 'package:newadbee/widgets/custom_textform_widget.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: Consumer<PasswordProv>(
        builder: (context, value, child) {
          return Form(
            key: value.resetpasswordformKey,
            child: Column(
              children: [
                kheight30,
                Row(
                  children: const [kWidth30, Icon(Icons.arrow_back)],
                ),
                kheight30,
                Text(
                  'Change Password',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                kheight80,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    kWidth30,
                    Text(
                      "New Password",
                      style: KFont().fieldNameStyle,
                    ),
                  ],
                ),
                kheight7,
                CustomTextFormField(
                  obscureText: true,
                  controller: value.resetPasswordController,
                  validator: (val) => value.validatePassword(val!),
                  hintText: 'Enter New Password',
                  prefixIcon: Transform.scale(
                    scale: 0.37,
                    child: SvgPicture.asset('assets/svg/key.svg'),
                  ),
                ),
                kheight15,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    kWidth30,
                    Text(
                      "Confirm Password",
                      style: KFont().fieldNameStyle,
                    ),
                  ],
                ),
                kheight7,
                CustomTextFormField(
                  obscureText: true,
                  controller: value.resetConfirmPassController,
                  validator: (val) => value.validateConfirmPassword(
                    val!,
                    value.resetPasswordController.text,
                  ),
                  hintText: 'Confirm Password',
                  prefixIcon: Transform.scale(
                    scale: 0.37,
                    child: SvgPicture.asset('assets/svg/key.svg'),
                  ),
                ),
                kheight30,
                CircleButtonWidget(
                  color: kPrimaryColor,
                  onPressed: () {
                    value.resetPassword(context: context);
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) => const SuccessPasswordScreen(),
                    // ));
                  },
                ),
              ],
            ),
          );
        },
      )),
    );
  }
}
