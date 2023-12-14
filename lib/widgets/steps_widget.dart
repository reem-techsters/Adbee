import 'package:flutter/material.dart';
import 'package:newadbee/core/colors/colors.dart';
import 'package:newadbee/core/constants/constants.dart';

class GetrewardSteps extends StatelessWidget {
  final String min;
  const GetrewardSteps({super.key, required this.min});

  @override
  Widget build(BuildContext context) {
    double rOut = 20;
    double rIn = 18;
    return Row(children: [
      Column(
        children: [
          CircleAvatar(
            radius: rOut,
            backgroundColor: kPrimaryColor,
            child: CircleAvatar(
                radius: rIn,
                backgroundColor: kWhite,
                child: Text('1', style: TextStyle(color: kBlack))),
          ),
          Text(
            '┊',
            style: TextStyle(fontSize: 25),
          ),
          CircleAvatar(
            radius: rOut,
            backgroundColor: kPrimaryColor,
            child: CircleAvatar(
                radius: rIn,
                backgroundColor: kWhite,
                child: Text('2', style: TextStyle(color: kBlack))),
          ),
          Text(
            '┊',
            style: TextStyle(fontSize: 25),
          ),
          CircleAvatar(
            radius: rOut,
            backgroundColor: kPrimaryColor,
            child: CircleAvatar(
                radius: rIn,
                backgroundColor: kWhite,
                child: Text(
                  '3',
                  style: TextStyle(color: kBlack),
                )),
          ),
        ],
      ),
      kWidth5,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Invite Your Friend',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            'just Share your link',
            style: TextStyle(fontSize: 11, color: kWelcomeTextColor),
          ),
          Text(
            '┊',
            style: TextStyle(fontSize: 25, color: Colors.transparent),
          ),
          //
          Text(
            'There signup at Adbee',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            "Make sure your friend enter's your referral code",
            style: TextStyle(fontSize: 11, color: kWelcomeTextColor),
          ),
          Text(
            '┊',
            style: TextStyle(fontSize: 25, color: Colors.transparent),
          ),
          //
          Text(
            'You get Rewards',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            'Earn Rewards once your referred friend earns $min Coins',
            style: TextStyle(fontSize: 11, color: kWelcomeTextColor),
          ),
        ],
      )
    ]);
  }
}
