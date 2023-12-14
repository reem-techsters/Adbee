import 'package:newadbee/controller/onboard_prov.dart';
import 'package:newadbee/core/colors/colors.dart';
import 'package:newadbee/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:newadbee/core/fonts/fonts.dart';
import 'package:newadbee/core/images/images.dart';
import 'package:newadbee/view/authentication/authentication_screen.dart';
import 'package:newadbee/widgets/custom_circle_button_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardScreen extends StatelessWidget {
  const OnBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: KImage.onboard,
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                height: 270,
                width: 270,
                decoration: BoxDecoration(
                  border: Border.all(color: kWhite, width: 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Consumer<OnBoardProv>(
                  builder: (context, value, child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: Text(
                            value.heading1[value.currentIndex],
                            key: ValueKey<int>(value.currentIndex),
                            style: KFont().robotoSemiBold,
                          ),
                        ),
                        kheight5,
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: Text(
                            value.heading2[value.currentIndex],
                            key: ValueKey<int>(value.currentIndex),
                            style: KFont().robotoSemiBold,
                          ),
                        ),
                        kheight10,
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: Text(
                            value.heading3[value.currentIndex],
                            key: ValueKey<int>(value.currentIndex),
                            style: KFont().poppinsRegular,
                          ),
                        ),
                        kheight30,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: value.heading1.asMap().entries.map((entry) {
                            final index = entry.key;
                            return Container(
                              width: 22,
                              height: 7,
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(3)),
                                  color: index == value.currentIndex
                                      ? kWhite
                                      : kWhite.withOpacity(.7)),
                            );
                          }).toList(),
                        ),
                        kheight30,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleButtonWidget(
                              color: kGreyBlackColor,
                              arrowback: true,
                              onPressed: () {
                                if (value.currentIndex > 0) {
                                  value.changeText(value.currentIndex - 1);
                                }
                              },
                            ),
                            kWidth25,
                            CircleButtonWidget(
                              color: kButtonColorOrange,
                              onPressed: () async {
                                if (value.currentIndex == 2) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const AuthenticationScreen(),
                                      ),
                                      (route) => false);
                                  final SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setBool('isOnBoarded', true);
                                } else {
                                  value.changeText((value.currentIndex + 1));
                                }
                              },
                            )
                          ],
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
