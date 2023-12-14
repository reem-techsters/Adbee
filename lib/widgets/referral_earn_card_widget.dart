import 'package:flutter/material.dart';
import 'package:newadbee/core/colors/colors.dart';
import 'package:newadbee/core/fonts/fonts.dart';

Container referralEarnsCard({
  required String text1,
  required String text2,
  required String text3,
  required dynamic widgetimage,
  required dynamic widgeticon,
}) {
  return Container(
    width: 170,
    margin: EdgeInsets.all(4.0),
    child: Card(
      color: kSizedBoxColor,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Transform.scale(scale: 0.77, child: widgetimage),
                // KIcon.earning),
              ),
              SizedBox(width: 15.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text1,
                    style: KFont().welcomeTextStyle.copyWith(
                          fontSize: 12,
                          color: kGreyBlackColor,
                        ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text2,
                        style: KFont().h1BoldStyle.copyWith(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      widgeticon,
                    ],
                  ),
                  Text(
                    text3,
                    style: KFont().welcomeTextStyle.copyWith(
                          fontSize: 8.8,
                        ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}
