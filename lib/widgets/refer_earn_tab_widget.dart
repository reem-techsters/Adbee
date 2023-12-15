import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newadbee/controller/wallet_prov.dart';
import 'package:newadbee/core/colors/colors.dart';
import 'package:newadbee/core/constants/constants.dart';
import 'package:newadbee/core/fonts/fonts.dart';
import 'package:newadbee/core/formats/date_format.dart';
import 'package:newadbee/core/icons/icons.dart';
import 'package:newadbee/core/images/images.dart';
import 'package:newadbee/model/referral_model.dart';
import 'package:newadbee/widgets/custom_textform_widget.dart';
import 'package:newadbee/widgets/referral_earn_card_widget.dart';
import 'package:newadbee/widgets/steps_widget.dart';
import 'package:share_plus/share_plus.dart';

referAndEarnTab({
  required BuildContext context,
  required WalletProv provi,
  required List<Referral> listReferral,
  required String coins,
  required String counts,
  required String min,
  required String refbonus,
}) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Refer and Earn',
                      style: KFont()
                          .h1BoldStyle
                          .copyWith(fontSize: 23, letterSpacing: .5)),
                  Text('Get $refbonus coins on Each referal',
                      style: KFont().welcomeTextStyle),
                  kheight15,
                  Text('How it works?', style: TextStyle(color: kPrimaryColor)),
                ],
              ),
            ]),
          ),
          kheight10,
          GetrewardSteps(
            min: min,
          ),
          kheight10,
          // KImage.steps,
          kheight10,
          Container(
            decoration: BoxDecoration(
              color: kSizedBoxColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kheight10,
                  InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(
                          text: provi.listProfile[0].referralCode!));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Text copied to clipboard'),
                        ),
                      );
                    },
                    child: CustomTextFormField(
                      enabled: false,
                      controller: provi.linkController,
                      hintText: 'Link',
                      prefixIcon: null,
                      suffixIcon: Icon(
                        Icons.file_copy,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                  kheight10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Share.share(
                              provi.listProfile[0].referralCode.toString());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          fixedSize: const Size(220, 50),
                        ),
                        child: Row(
                          children: [
                            KIcon.share,
                            kWidth10,
                            Text(
                              'Refer Friends Now',
                              style: KFont()
                                  .h1BoldStyle
                                  .copyWith(fontSize: 18, color: kWhite),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  kheight10,
                ],
              ),
            ),
          ),
          kheight15,
          Row(children: [
            Text(
              'Your Referral Earns',
              style: KFont()
                  .h1BoldStyle
                  .copyWith(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ]),
          kheight5,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              referralEarnsCard(
                text1: 'You Reffered',
                text2: coins,
                text3: 'Last updated 2min ago',
                widgeticon: KIcon.refpeople,
                widgetimage: KIcon.referalgift,
              ),
              referralEarnsCard(
                text1: 'Rewards Earned',
                text2: counts,
                text3: 'Last updated 2min ago',
                widgeticon: KIcon.ruppee,
                widgetimage: KIcon.earning,
              ),
            ],
          ),
          kheight10,
          Row(children: [
            Text(
              'Referral history',
              style: KFont()
                  .h1BoldStyle
                  .copyWith(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ]),
          kheight5,
          listReferral.isEmpty
              ? SizedBox(
                  height: 70,
                  child: Center(
                    child: Text(
                      'No History',
                      style: KFont().welcomeTextStyle,
                    ),
                  ),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return kheight10;
                  },
                  itemCount: listReferral.length,
                  itemBuilder: (context, index) {
                    return Card(
                        elevation: 0,
                        color: kreferralhistory,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundColor: kGrey,
                                child: KImage.userprofile,
                              ),
                              kWidth20,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: KFont().fieldHeading.copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: kGreyBlackColor),
                                      children: [
                                        TextSpan(
                                            text: listReferral[index].uName),
                                        TextSpan(
                                          text:
                                              ' ( ${listReferral[index].uMobno} )',
                                          style: KFont().fieldHeading.copyWith(
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal,
                                              color: kGreyBlackColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                  kheight3,
                                  RichText(
                                    text: TextSpan(
                                      style: KFont().welcomeTextStyle.copyWith(
                                          color: kFieldNameGreyBlackColor),
                                      children: [
                                        TextSpan(text: 'Referred on '),
                                        TextSpan(
                                            text: formatDateTime(
                                                listReferral[index]
                                                    .uDob
                                                    .toString()),
                                            style: KFont().welcomeTextStyle),
                                      ],
                                    ),
                                  ),
                                  kheight3,
                                  listReferral[index].isRedeemed == 0
                                      ? Text('Pending',
                                          style: KFont().welcomeTextStyle)
                                      : RichText(
                                          text: TextSpan(
                                            style: KFont()
                                                .welcomeTextStyle
                                                .copyWith(
                                                    color: kGreyBlackColor),
                                            children: [
                                              TextSpan(text: 'Reached '),
                                              TextSpan(
                                                  text:
                                                      '[100 milestone on ${formatDateTime(listReferral[index].redeemedDate.toString())}]',
                                                  style:
                                                      KFont().welcomeTextStyle),
                                            ],
                                          ),
                                        ),
                                ],
                              ),
                            ],
                          ),
                        ));
                  },
                )
        ],
      ),
    ),
  );
}
