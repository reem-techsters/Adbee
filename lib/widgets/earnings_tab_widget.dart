import 'package:flutter/material.dart';
import 'package:newadbee/core/colors/colors.dart';
import 'package:newadbee/core/constants/constants.dart';
import 'package:newadbee/core/fonts/fonts.dart';
import 'package:newadbee/core/formats/date_format.dart';
import 'package:newadbee/core/formats/time_format.dart';
import 'package:newadbee/core/icons/icons.dart';
import 'package:newadbee/model/earnings_model.dart';

earningsTab({
  required List<EarningsDatum> listEarnings,
}) {
  return listEarnings.isEmpty
      ? Center(
          child: Text(
            'No Recent Earnings',
            style: KFont().welcomeTextStyle,
          ),
        )
      : Column(
          children: [
            kheight7,
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return SizedBox();
                },
                itemCount: listEarnings.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 0,
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 7.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: kLightBlue,
                            child: KIcon.creditcard,
                          ),
                          kWidth20,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                listEarnings[index].campType == "video/mp4"
                                    ? 'Video Ad Reward'
                                    : 'Image Ad Reward',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              kheight7,
                              Text(
                                '${listEarnings[index].coins} Coins',
                                style: KFont().fieldNameStyle.copyWith(
                                    fontSize: 13, color: kWelcomeTextColor),
                              ),
                            ],
                          ),
                          Expanded(child: SizedBox()),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${formatDateTime(listEarnings[index].viewDate.toString()).split(' ')[0]} ${formatDateTime(listEarnings[index].viewDate.toString()).split(' ')[1]}',
                                style: KFont().fieldNameStyle.copyWith(
                                    fontSize: 13, color: kWelcomeTextColor),
                              ),
                              Text(
                                formatDateTime(
                                        listEarnings[index].viewDate.toString())
                                    .split(' ')[2],
                                style: KFont().fieldNameStyle.copyWith(
                                    fontSize: 13, color: kWelcomeTextColor),
                              ),
                              Text(
                                formatTimeString(
                                    listEarnings[0].viewDate!.split(' ')[1]),
                                style: KFont().fieldNameStyle.copyWith(
                                    fontSize: 13, color: kWelcomeTextColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        );
}
