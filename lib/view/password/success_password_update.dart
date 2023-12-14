import 'package:flutter/material.dart';
import 'package:newadbee/core/colors/colors.dart';
import 'package:newadbee/core/constants/constants.dart';
import 'package:newadbee/core/icons/icons.dart';
import 'package:newadbee/view/authentication/authentication_screen.dart';

class SuccessPasswordScreen extends StatelessWidget {
  const SuccessPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // After a 2-second delay, navigate to the next screen
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => AuthenticationScreen()),
          (route) => false,
        );
      });
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform.scale(
              scale: 0.9,
              child: KIcon.success,
            ),
            kheight15,
            const Text(
              'Password Succesfully',
              style: TextStyle(
                fontFamily: 'Roboto',
                color: kPrimaryColor,
                fontSize: 23,
                fontWeight: FontWeight.bold,
                letterSpacing: .3,
              ),
            ),
            const Text(
              'Updated',
              style: TextStyle(
                fontFamily: 'Roboto',
                color: kPrimaryColor,
                fontSize: 23,
                fontWeight: FontWeight.bold,
                letterSpacing: .3,
              ),
            )
          ],
        ),
      ),
    );
  }
}
