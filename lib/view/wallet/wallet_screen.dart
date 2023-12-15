import 'package:flutter/material.dart';
import 'package:newadbee/controller/wallet_prov.dart';
import 'package:newadbee/core/colors/colors.dart';
import 'package:newadbee/core/constants/constants.dart';
import 'package:newadbee/core/fonts/fonts.dart';
import 'package:newadbee/core/icons/icons.dart';
import 'package:newadbee/core/images/images.dart';
import 'package:newadbee/widgets/custom_menu.dart';
import 'package:newadbee/widgets/earnings_tab_widget.dart';
import 'package:newadbee/widgets/refer_earn_tab_widget.dart';
import 'package:newadbee/widgets/transactions_tab_widget.dart';
import 'package:newadbee/widgets/withdrawal_alertdialog.dart';
import 'package:provider/provider.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    final provider = Provider.of<WalletProv>(context, listen: false);

    provider.getReferral(context);
    provider.getProfileDetails(context);
    provider.getEarnings(context);
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Consumer<WalletProv>(builder: (context, value, child) {
        return Column(
          children: [
            kheight30,
            Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.arrow_back)),
                    Text('Wallet'),
                    CustomPopupMenuButton()
                  ]),
            ),
            kheight30,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                KIcon.wallet,
              ],
            ),
            kheight5,
            Text(
              '${value.listProfile[0].coinPrice} Coins = 1 Rs',
              style: KFont().welcomeTextStyle,
            ),
            Text(
              'Your Wallet',
              style: KFont().walletStyle,
            ),
            kheight20,
            Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Container(
                decoration: BoxDecoration(
                  color: kCardColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ListTile(
                    title: Row(children: [
                      KImage.coins,
                      kWidth5,
                      value.listProfile.isEmpty
                          ? SizedBox()
                          : Text(' ${value.listProfile[0].walletBalance}',
                              style: KFont().coinStyle)
                    ]),
                    subtitle: const Text(
                      '  Total Balance',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: kLightGrey,
                      ),
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        value.selectedValue = 0;
                        value.withdrawalAmtController.clear();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomWithdrawalAlertDialog();
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          fixedSize: const Size(140, 40)),
                      child: const Text(
                        'Withdraw',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            kheight30,
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: 49,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 246, 245, 245),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 1.1,
                          height: MediaQuery.of(context).size.height / 17,
                          child: TabBar(
                            controller: _tabController,
                            labelColor: kPrimaryColor,
                            unselectedLabelColor: kWelcomeTextColor,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicator: BoxDecoration(
                              color: kWhite,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            onTap: (index) async {
                              // controller.selectedindexTab = index;
                            },
                            tabs: const [
                              Tab(
                                child: Text(
                                  "Transactions",
                                  style: TextStyle(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Tab(
                                child: Text(
                                  "Earnings",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  "Refer & Earn",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        transactionsTab(
                          context: context,
                          listTransactions: value.listTransactions,
                        ),
                        earningsTab(
                          listEarnings: value.listEarnings,
                        ),
                        referAndEarnTab(
                            context: context,
                            listReferral: value.listReferral,
                            coins: value.coins.toString(),
                            counts: value.count.toString(),
                            provi: value,
                            min: value.minEarnedCoins.toString(),
                            refbonus: value.referralBonus.toString()),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      }),
    ));
  }
}
