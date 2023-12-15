import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:newadbee/controller/advertisement_prov.dart';
import 'package:newadbee/controller/calls_prov.dart';
import 'package:newadbee/controller/menu_controller.dart';
import 'package:newadbee/controller/sharedprefs_prov.dart';
import 'package:newadbee/controller/wallet_prov.dart';
import 'package:newadbee/core/colors/colors.dart';
import 'package:newadbee/core/constants/constants.dart';
import 'package:newadbee/core/icons/icons.dart';
import 'package:newadbee/view/advertisement/advertisement_screen.dart';
import 'package:newadbee/view/advertisement/image_adv_screen.dart';
import 'package:newadbee/view/calls/ios_call_screen.dart';
import 'package:newadbee/view/calls/dialpad_screen.dart';
import 'package:newadbee/view/ticket/ticket_screen.dart';
import 'package:newadbee/view/wallet/wallet_screen.dart';
import 'package:newadbee/widgets/recent_calls_tab.dart';
import 'package:newadbee/widgets/contact_list_tab.dart';
import 'package:phone_state/phone_state.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late FocusNode myFocusNode;

  @override
  void initState() {
    final callsProvider = Provider.of<CallsFetchProv>(context, listen: false);
    final walletProvider = Provider.of<WalletProv>(context, listen: false);
    walletProvider.getProfileDetails(context);
    callsProvider.fetchContacts();
    callsProvider.fetchRecentCalls();
    super.initState();

    final provider = Provider.of<CallsFetchProv>(context, listen: false);
    if (Platform.isAndroid) {
      _tabController = TabController(length: 2, vsync: this);
    }
    if (Platform.isIOS) provider.init(context);
    if (Platform.isIOS) provider.setStream(context);
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var providerr = Provider.of<MenuProv>(context, listen: false);
      var sharedprovider = Provider.of<SharedPrefsProv>(context, listen: false);
      providerr.isDND = await sharedprovider.getBool('isDND');
      providerr.isSwitched = providerr.isDND ?? false;
      log('isDND --> ${providerr.isDND.toString()}');
      if (context.mounted) {
        final provider = Provider.of<CallsFetchProv>(context, listen: false);
        if (Platform.isAndroid) {
          await provider.fetchRecentCalls();
        }
        await provider.fetchContacts();
      }
    });

    return SafeArea(
      child: (Platform.isIOS)
          ? iosRecentcallsScreen(focusNode: myFocusNode)
          : Consumer<CallsFetchProv>(
              builder: (BuildContext context, provider, Widget? child) {
                return Scaffold(
                  body: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: StreamBuilder<PhoneState>(
                        stream: PhoneState.stream,
                        initialData: PhoneState.nothing(),
                        builder: (context, snapshot) {
                          var menuProv =
                              Provider.of<MenuProv>(context, listen: false);
                          bool? dndMode = menuProv.isDND;
                          log('checked ${dndMode.toString()}');
                          final callStatus = snapshot.data;
                          if (callStatus!.status ==
                              PhoneStateStatus.CALL_STARTED) {
                            provider.isAnswered = true;
                            print(
                                '\n\n\n isAnswered is ${provider.isAnswered.toString()}');
                          }
                          if (provider.isAnswered == true &&
                              callStatus!.status ==
                                  PhoneStateStatus.CALL_ENDED) {
                            final advprovider = Provider.of<AdvertisementProv>(
                                context,
                                listen: false);
                            dndMode == false
                                ? advprovider.getCampaignDetails(context)
                                : null;
                            Future.delayed(Duration(seconds: 3), () {
                              if (dndMode == false) {
                                advprovider.listCampaign[0].campType ==
                                        "video/mp4"
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AdvertisementScreen(),
                                        ))
                                    : Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ImageAdvertisement(),
                                        ));
                              } else {
                                log('DND is ON');
                                log('because ${provider.isAnswered.toString()}');
                              }
                            });
                            callStatus.status = PhoneStateStatus.NOTHING;
                            provider.isAnswered = false;
                            provider.fetchRecentCalls();
                          }
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TicketScreen(),
                                          ));
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: kPrimaryColor,
                                      child: Transform.scale(
                                          scale: 0.9, child: KIcon.person),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                WalletScreen(),
                                          ));
                                    },
                                    child: Card(
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
                                                      Consumer<WalletProv>(
                                                          builder: (context,
                                                              walletProv,
                                                              child) {
                                                        return walletProv
                                                                .listProfile
                                                                .isEmpty
                                                            ? SizedBox()
                                                            : Text(
                                                                walletProv
                                                                    .listProfile[
                                                                        0]
                                                                    .walletBalance
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    color:
                                                                        kWhite,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15),
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
                                    ),
                                  )
                                ],
                              ),
                              kheight15,
                              Container(
                                height: 55,
                                decoration: BoxDecoration(
                                  color: kCallTabColor,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    child: SizedBox(
                                      child: TabBar(
                                        controller: _tabController,
                                        indicatorSize: TabBarIndicatorSize.tab,
                                        indicator: BoxDecoration(
                                          color: kWhite,
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        onTap: (index) async {
                                          var menuProv = Provider.of<MenuProv>(
                                              context,
                                              listen: false);
                                          bool? dndMode = menuProv.isDND;
                                          log(dndMode.toString());
                                          //---

                                          await provider.fetchContacts();
                                          provider.searchController.clear();
                                          myFocusNode.unfocus();
                                        },
                                        tabs: const [
                                          Tab(
                                            child: Text(
                                              "Call Log",
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  color: kGreyBlackColor),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Tab(
                                            child: Text(
                                              "Contacts",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  color: kGreyBlackColor),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              kheight15,
                              Container(
                                decoration: BoxDecoration(
                                  color: kCallTabColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: TextFormField(
                                  controller: provider.searchController,
                                  focusNode: myFocusNode,
                                  autofocus: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide.none,
                                    ),
                                    hintText: 'Search calls',
                                    hintStyle: TextStyle(
                                        color: kGreyBlackColor, fontSize: 14),
                                    prefixIcon: Transform.scale(
                                      scale: 0.37,
                                      child: KIcon.search,
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 8),
                                  ),
                                  onChanged: (value) {
                                    log(_tabController.index.toString());
                                    _tabController.index == 0
                                        ? provider.getSearchResult(value,
                                            listname: 'Recents')
                                        : provider.getSearchResult(value,
                                            listname: 'Contacts');
                                  },
                                ),
                              ),
                              kheight7,
                              Consumer<CallsFetchProv>(
                                builder: (context, value, child) {
                                  return Expanded(
                                    child: TabBarView(
                                      controller: _tabController,
                                      children: [
                                        recentCallsTab(
                                          recentcalls: value.recentCalls,
                                          provider: value,
                                        ),
                                        contactListTab(
                                          contacts: value.contacts,
                                          provider: value,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        }),
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.endFloat,
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: kPrimaryColor,
                    child: KIcon.keypad,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DialPadScreen(),
                      ));
                    },
                  ),
                );
              },
            ),
    );
  }
}
