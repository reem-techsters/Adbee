import 'package:flutter/material.dart';
import 'package:newadbee/core/colors/colors.dart';
import 'package:newadbee/core/constants/constants.dart';
import 'package:newadbee/core/fonts/fonts.dart';

class LogoutAlertWidget extends StatelessWidget {
  final String title;
  final String btnTitle;
  final void Function()? onPressed;
  const LogoutAlertWidget(
      {super.key,
      required this.title,
      required this.btnTitle,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: KFont().fieldHeading.copyWith(fontSize: 15)),
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                  onPressed: onPressed,
                  child: Text(btnTitle)),
              kWidth20,
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kGreyBlackColor),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel')),
            ],
          ),
        )
      ],
    );
  }
}
