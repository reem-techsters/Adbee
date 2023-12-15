import 'package:flutter/material.dart';
import 'package:newadbee/controller/registration_prov.dart';
import 'package:newadbee/core/colors/colors.dart';
import 'package:newadbee/core/constants/constants.dart';
import 'package:newadbee/core/fonts/fonts.dart';
import 'package:newadbee/core/icons/icons.dart';
import 'package:newadbee/view/authentication/authentication_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountCreatedSuccessScreen extends StatelessWidget {
  const AccountCreatedSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: KIcon.success,
            ),
          ),
          kheight130,
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  kheight30,
                  Text('Adbee Accoount', style: KFont().robotoSemiBold),
                  Text('Successfully Created!', style: KFont().robotoSemiBold),
                  kheight30,
                  const Text(
                    '        Congratulations, your account has been\nsuccessfully created! You can now log in to start\n earning the money by making calls in our platform.\n                      Thank you for joining us!',
                    style: TextStyle(
                      color: kWhite,
                      fontFamily: 'Roboto',
                      fontSize: 14.0,
                    ),
                  ),
                  kheight50,
                  ElevatedButton(
                    onPressed: () async {
                      var provider =
                          Provider.of<RegistrationProv>(context, listen: false);
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool('isRegistered', true);
                      provider.clearRegistrationFields();
                      if (context.mounted) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AuthenticationScreen()),
                          (Route<dynamic> route) => false,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kBlack,
                        fixedSize: const Size(320, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )),
                    child: const Text('Take Me To Login'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
