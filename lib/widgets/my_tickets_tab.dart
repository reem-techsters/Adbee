import 'package:newadbee/controller/ticket_prov.dart';
import 'package:newadbee/core/colors/colors.dart';
import 'package:newadbee/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:newadbee/core/fonts/fonts.dart';
import 'package:newadbee/widgets/close_ticket_card_widget.dart';
import 'package:newadbee/widgets/open_ticket_card_widget.dart';
import 'package:provider/provider.dart';

Padding myTicketsTab() {
  return Padding(
    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
    child: Consumer<TicketProv>(builder: (context, value, child) {
      return SingleChildScrollView(
        child: Column(
          children: [
            kheight10,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Open Tickets",
                  style: KFont().fieldNameStyle.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.lerp(
                          FontWeight.w500, FontWeight.w600, 0.5)),
                ),
              ],
            ),
            kheight5,
            value.listOpenTicket.isEmpty
                ? SizedBox(
                    height: 70,
                    child: Center(
                      child: Text(
                        'No Open Tickets',
                        style: KFont().welcomeTextStyle,
                      ),
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: value.listOpenTicket.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                          onTap: () {},
                          child: value.listOpenTicket.isEmpty
                              ? Center(
                                  child: Text(
                                    'No Open Tickets',
                                    style: TextStyle(color: kRed),
                                  ),
                                )
                              : openTicketCard(context, value, index));
                    },
                  ),
            kheight30,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Closed Tickets",
                  style: KFont().fieldNameStyle.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.lerp(
                            FontWeight.w500, FontWeight.w600, 0.5),
                      ),
                ),
              ],
            ),
            kheight5,
            value.listClosedTicket.isEmpty
                ? SizedBox(
                    height: 70,
                    child: Center(
                      child: Text(
                        'No Closed Tickets',
                        style: KFont().welcomeTextStyle,
                      ),
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: value.listClosedTicket.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                    itemBuilder: (BuildContext context, int index) {
                      return closeTicketCard(context, value, index);
                    },
                  ),
            kheight15,
            kheight15,
          ],
        ),
      );
    }),
  );
}
