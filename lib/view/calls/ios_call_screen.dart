import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:newadbee/controller/advertisement_prov.dart';
import 'package:newadbee/controller/calls_prov.dart';
import 'package:newadbee/controller/menu_controller.dart';
import 'package:newadbee/controller/wallet_prov.dart';
import 'package:newadbee/core/colors/colors.dart';
import 'package:newadbee/core/constants/constants.dart';
import 'package:newadbee/core/icons/icons.dart';
import 'package:newadbee/view/advertisement/advertisement_screen.dart';
import 'package:newadbee/view/advertisement/image_adv_screen.dart';
import 'package:newadbee/widgets/contact_list_tab.dart';
import 'package:phone_state/phone_state.dart';
import 'package:provider/provider.dart';

iosRecentcallsScreen({required FocusNode? focusNode}) {
  return Scaffold(
    body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Consumer<CallsFetchProv>(
          builder: (context, value, child) {
            return StreamBuilder(
                stream: PhoneState.stream,
                initialData: PhoneState.nothing(),
                builder: (context, snapshot) {
                  var menuProv = Provider.of<MenuProv>(context, listen: false);
                  bool? dndMode = menuProv.isDND;
                  log('checked ${dndMode.toString()}');
                  final callStatus = snapshot.data;
                  if (callStatus!.status == PhoneStateStatus.CALL_STARTED) {
                    value.isAnswered = true;
                    print(
                        '\n\n\n isAnswered is ${value.isAnswered.toString()}');
                  }
                  if (value.isAnswered == true &&
                      callStatus!.status == PhoneStateStatus.CALL_ENDED) {
                    final advprovider =
                        Provider.of<AdvertisementProv>(context, listen: false);
                    dndMode == false
                        ? advprovider.getCampaignDetails(context)
                        : null;
                    Future.delayed(Duration(seconds: 3), () {
                      if (dndMode == false) {
                        advprovider.listCampaign[0].campType == "video/mp4"
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AdvertisementScreen(),
                                ))
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImageAdvertisement(),
                                ));
                      } else {
                        log('DND is ON');
                        log('because ${value.isAnswered.toString()}');
                      }
                    });
                    callStatus.status = PhoneStateStatus.NOTHING;
                    value.isAnswered = false;
                  }
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                              backgroundColor: kPrimaryColor,
                              child: Transform.scale(
                                  scale: 0.9, child: KIcon.person)),
                          Card(
                            color: kPrimaryColor,
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Total Balance ',
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              color: kWhite,
                                              fontSize: 13),
                                        ),
                                        Row(
                                          children: [
                                            KIcon.whiteCoin,
                                            kWidth3,
                                            Consumer<WalletProv>(builder:
                                                (context, walletProv, child) {
                                              return walletProv
                                                      .listProfile.isEmpty
                                                  ? SizedBox()
                                                  : Text(
                                                      walletProv.listProfile[0]
                                                          .walletBalance
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          color: kWhite,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    );
                                            }),
                                          ],
                                        )
                                      ]),
                                  kWidth5,
                                  KIcon.whiteWallet,
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      kheight15,
                      Container(
                        decoration: BoxDecoration(
                          color: kCallTabColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextFormField(
                          controller: value.searchController,
                          focusNode: focusNode,
                          autofocus: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Search calls',
                            hintStyle:
                                TextStyle(color: kGreyBlackColor, fontSize: 14),
                            prefixIcon: Transform.scale(
                              scale: 0.37,
                              child: KIcon.search,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 8),
                          ),
                          onChanged: (value) {
                            var provider = Provider.of<CallsFetchProv>(context,
                                listen: false);
                            provider.getSearchResult(value,
                                listname: 'Contacts');
                          },
                        ),
                      ),
                      kheight7,
                      Expanded(
                          child: contactListTab(
                              contacts: value.contacts, provider: value)),
                    ],
                  );
                });
          },
        )),
  );
}
