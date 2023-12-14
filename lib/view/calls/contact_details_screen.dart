import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:newadbee/controller/advertisement_prov.dart';
import 'package:newadbee/controller/calls_prov.dart';
import 'package:newadbee/controller/menu_controller.dart';
import 'package:newadbee/core/colors/colors.dart';
import 'package:newadbee/core/constants/constants.dart';
import 'package:newadbee/core/fonts/fonts.dart';
import 'package:newadbee/core/icons/icons.dart';
import 'package:newadbee/view/advertisement/advertisement_screen.dart';
import 'package:newadbee/view/advertisement/image_adv_screen.dart';
import 'package:phone_state/phone_state.dart';
import 'package:provider/provider.dart';

class ContactDetailsScreen extends StatelessWidget {
  final int index;

  const ContactDetailsScreen({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<CallsFetchProv>(context, listen: false);
      provider.fetchContacts();
    });
    return SafeArea(
      child: StreamBuilder<PhoneState>(
          stream: PhoneState.stream,
          initialData: PhoneState.nothing(),
          builder: (context, snapshot) {
            var menuProv = Provider.of<MenuProv>(context, listen: false);
            bool? dndMode = menuProv.isDND;
            log('checked ${dndMode.toString()}');
            final callStatus = snapshot.data;
            if (callStatus!.status == PhoneStateStatus.CALL_ENDED) {
              final advprovider =
                  Provider.of<AdvertisementProv>(context, listen: false);
              dndMode == false ? advprovider.getCampaignDetails(context) : null;
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
                }
              });
              callStatus.status = PhoneStateStatus.NOTHING;
            }
            return Scaffold(
              backgroundColor: kScaffoldColor,
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<CallsFetchProv>(builder: (context, val, child) {
                  return Column(
                    children: [
                      kheight30,
                      Padding(
                        padding: EdgeInsets.only(left: 30.0, right: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Icon(Icons.arrow_back)),
                            kWidth90,
                            Text('Contact Details'),
                          ],
                        ),
                      ),
                      kheight30,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 55,
                            backgroundColor: Colors.grey,
                            backgroundImage: val.contacts[index].avatar !=
                                        null &&
                                    val.contacts[index].avatar!.isNotEmpty
                                ? MemoryImage(val.contacts[index].avatar!)
                                : AssetImage('assets/images/userprofile.png')
                                    as ImageProvider<Object>,
                          ),
                        ],
                      ),
                      kheight30,
                      Text(
                        val.contacts[index].displayName.toString(),
                        style: TextStyle(fontSize: 15),
                      ),
                      // kheight5,
                      // Text(
                      //   'Sukabumi, Indonesia',
                      //   style: KFont().welcomeTextStyle.copyWith(fontSize: 12),
                      // ),
                      kheight30,
                      Card(
                        elevation: 0,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Phone Number',
                                        style: KFont().welcomeTextStyle),
                                    kheight10,
                                    Text(
                                        val.contacts[index].phones!.first.value
                                            .toString(),
                                        style: TextStyle(fontFamily: 'Roboto')),
                                  ]),
                              InkWell(
                                onTap: () async {
                                  await FlutterPhoneDirectCaller.callNumber(val
                                      .contacts[index].phones!.first.value
                                      .toString());
                                },
                                child: CircleAvatar(
                                    backgroundColor: kPrimaryColor,
                                    child: KIcon.call),
                              )
                            ],
                          ),
                        ),
                      ),
                      kheight15,
                      Card(
                        elevation: 0,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Email Address',
                                        style: KFont().welcomeTextStyle),
                                    kheight10,
                                    Text(
                                        val.contacts[index].emails
                                                    ?.isNotEmpty ??
                                                false
                                            ? val.contacts[index].emails!.first
                                                .value!
                                            : '- - - -',
                                        style: TextStyle(fontFamily: 'Roboto')),
                                  ]),
                            ],
                          ),
                        ),
                      ),
                      kheight15,
                      Card(
                        elevation: 0,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Date of Birth',
                                        style: KFont().welcomeTextStyle),
                                    kheight10,
                                    Text(
                                        val.contacts[index].birthday != null
                                            ? val.contacts[index].birthday
                                                .toString()
                                                .split(' ')[0]
                                            : '- - - -',
                                        style: TextStyle(fontFamily: 'Roboto')),
                                  ]),
                            ],
                          ),
                        ),
                      ),
                      kheight100,
                      ElevatedButton(
                        onPressed: () async {
                          var provider = Provider.of<CallsFetchProv>(context,
                              listen: false);
                          await provider
                              .openContactDetailsScreen(val
                                  .contacts[index].phones!.first.value
                                  .toString())
                              .then((value) async {
                            provider.isSuccess == true
                                ? await provider.fetchContacts(update: true)
                                : null;
                            await provider.fetchContacts(update: true);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          fixedSize: const Size(150, 50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            KIcon.editbuttonicon,
                            Text('Edit Now'),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ),
            );
          }),
    );
  }
}
