import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:newadbee/controller/registration_prov.dart';
import 'package:newadbee/controller/sharedprefs_prov.dart';
import 'package:newadbee/core/constants/constants.dart';
import 'package:newadbee/core/fonts/fonts.dart';
import 'package:newadbee/core/icons/icons.dart';
import 'package:newadbee/view/registration/complete_profile_screen.dart';
import 'package:newadbee/widgets/custom_bottomappbar.dart';
import 'package:newadbee/widgets/custom_field_name.dart';
import 'package:newadbee/widgets/custom_textform_widget.dart';
import 'package:provider/provider.dart';

class CreateAccountScreen extends StatelessWidget {
  final String? fullname;
  final String? email;

  const CreateAccountScreen({
    super.key,
    this.fullname,
    this.email,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<RegistrationProv>(context, listen: false);
      provider.getLookUps();
      if (fullname != null && email != null) {
        provider.nameController.text = fullname!;
        provider.emailController.text = email!;
      }
    });
    return SafeArea(
      child: Scaffold(
        body: Consumer<RegistrationProv>(
          builder: (context, value, child) {
            return SingleChildScrollView(
              child: Form(
                key: value.createaccountformKey,
                child: Column(children: [
                  kheight30,
                  kheight40,
                  Text(
                    'Create Account',
                    style: KFont().h1BoldStyle,
                  ),
                  kheight30,
                  customFieldName(fieldname: 'Full Name'),
                  kheight7,
                  CustomTextFormField(
                    controller: value.nameController,
                    validator: (val) => value.validateUsername(val!),
                    hintText: 'Enter your full name',
                    prefixIcon: Transform.scale(
                      scale: 0.37,
                      child: KIcon.uname,
                    ),
                  ),
                  kheight15,
                  customFieldName(fieldname: 'Email Address'),
                  kheight7,
                  CustomTextFormField(
                    controller: value.emailController,
                    validator: (val) => value.validateEmail(val!),
                    hintText: 'Enter your email address',
                    prefixIcon: Transform.scale(
                      scale: 0.37,
                      child: KIcon.mail,
                    ),
                  ),
                  kheight15,
                  customFieldName(fieldname: 'Create Password'),
                  kheight7,
                  CustomTextFormField(
                    controller: value.createpasswordController,
                    validator: (val) => value.validatePassword(val!),
                    obscureText: true,
                    hintText: 'Create password',
                    prefixIcon: Transform.scale(
                      scale: 0.37,
                      child: KIcon.key,
                    ),
                  ),
                  kheight15,
                  customFieldName(fieldname: 'Confirm Password'),
                  kheight7,
                  CustomTextFormField(
                    controller: value.confirmPasswordController,
                    validator: (val) => value.validateConfirmPassword(
                        val!, value.createpasswordController.text),
                    obscureText: true,
                    hintText: 'Confirm password',
                    prefixIcon: Transform.scale(
                      scale: 0.37,
                      child: KIcon.key,
                    ),
                  ),
                ]),
              ),
            );
          },
        ),
        bottomNavigationBar: Consumer<RegistrationProv>(
          builder: (BuildContext context, value, Widget? child) {
            return customBottomAppBar(
              backonPressed: () => Navigator.pop(context),
              forwardonPressed: () async {
                final sharedprovider =
                    Provider.of<SharedPrefsProv>(context, listen: false);
                final mobile = await sharedprovider.getString('saved_mobile');
                if (value.createaccountformKey.currentState!.validate()) {
                  if (value.createpasswordController.text ==
                      value.confirmPasswordController.text) {
                    if (context.mounted) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CompleteProfileScreen(
                              name: value.nameController.text,
                              email: value.emailController.text,
                              password: value.confirmPasswordController.text,
                              mobile: mobile!)));
                    }
                  } else {
                    log('Complete fields');
                  }
                }
              },
              progress: value.progress,
            );
          },
        ),
      ),
    );
  }
}
