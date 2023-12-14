import 'package:flutter/material.dart';
import 'package:newadbee/core/colors/colors.dart';
import 'package:newadbee/widgets/custom_circle_button_widget.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

BottomAppBar customBottomAppBar({
  required void Function()? backonPressed,
  required void Function()? forwardonPressed,
  required double progress,
}) {
  return BottomAppBar(
    child: Container(
      height: 100,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleButtonWidget(
                  onPressed: backonPressed,
                  color: kGreyBlackColor,
                  arrowback: true,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: LinearPercentIndicator(
                    animation: true,
                    animateFromLastPercent: true,
                    width: 160.0,
                    lineHeight: 8.0,
                    percent: progress,
                    backgroundColor: kGrey,
                    progressColor: kPrimaryColor,
                    barRadius: const Radius.circular(10),
                  ),
                ),
                CircleButtonWidget(
                  color: kPrimaryColor,
                  onPressed: forwardonPressed,
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
