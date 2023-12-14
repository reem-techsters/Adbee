import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:newadbee/controller/ticket_prov.dart';
import 'package:newadbee/core/colors/colors.dart';
import 'package:newadbee/core/constants/constants.dart';
import 'package:newadbee/core/fonts/fonts.dart';
import 'package:newadbee/widgets/create_ticket_tab.dart';
import 'package:newadbee/widgets/custom_menu.dart';
import 'package:newadbee/widgets/my_tickets_tab.dart';
import 'package:provider/provider.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({Key? key}) : super(key: key);

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<TicketProv>(context, listen: false);

    provider.getProfileDetails(context);
    provider.getOpenTicket(context);
    provider.getClosedTicket(context);

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   final provider = Provider.of<TicketProv>(context, listen: false);
    //   provider.selectedOpenTicket =
    //       List.generate(provider.listOpenTicket.length, (index) => false);
    //   provider.selectedClosedTicket =
    //       List.generate(provider.listClosedTicket.length, (index) => false);
    // });
    return SafeArea(
      child: Scaffold(
        body: Consumer<TicketProv>(builder: (context, value, child) {
          return value.listProfile.isEmpty
              ? Center(child: CircularProgressIndicator())
              : Column(
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
                          Text('Profile'),
                          CustomPopupMenuButton()
                        ],
                      ),
                    ),
                    kheight30,
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: kButtonColorOrange,
                        child: CircleAvatar(
                          radius: 57.5,
                          backgroundColor: Colors.grey,
                          backgroundImage: MemoryImage(base64.decode(
                              value.listProfile[0].uImage!.split(',').last)),
                        ),
                      ),
                    ]),
                    kheight15,
                    Text(
                      value.listProfile[0].uName.toString(),
                      style: KFont()
                          .fieldHeading
                          .copyWith(fontSize: 15.0, letterSpacing: .5),
                    ),
                    kheight7,
                    Text(
                      '+91 ${value.listProfile[0].uMobno.toString()}',
                      style: KFont().fieldNameStyle.copyWith(
                          color: kHeavyGreyColor,
                          fontSize: 12.0,
                          letterSpacing: .5),
                    ),
                    kheight7,
                    Text(
                      value.listProfile[0].uEmail.toString(),
                      style: KFont().fieldNameStyle.copyWith(
                          color: kHeavyGreyColor,
                          fontSize: 15.0,
                          letterSpacing: .3),
                    ),
                    kheight30,
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: kCallTabColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ClipRRect(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.5,
                            height: MediaQuery.of(context).size.height / 17,
                            child: TabBar(
                              controller: _tabController,
                              labelColor: kPrimaryColor,
                              unselectedLabelColor: kHeavyGreyColor,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: BoxDecoration(
                                color: kWhite,
                                borderRadius: BorderRadius.circular(5.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    offset: Offset(0, 4),
                                    blurRadius: 6.0,
                                  ),
                                ],
                              ),
                              onTap: (index) async {},
                              tabs: const [
                                Tab(
                                  child: Text(
                                    "Create Ticket",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'Roboto',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    "My Tickets",
                                    style: TextStyle(
                                        fontSize: 13, fontFamily: 'Roboto'),
                                    textAlign: TextAlign.center,
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
                          createTicketTab(),
                          myTicketsTab(),
                        ],
                      ),
                    ),
                  ],
                );
        }),
      ),
    );
  }
}
