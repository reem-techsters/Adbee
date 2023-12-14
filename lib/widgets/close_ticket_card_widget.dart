import 'package:flutter/material.dart';
import 'package:newadbee/controller/ticket_prov.dart';
import 'package:newadbee/core/colors/colors.dart';
import 'package:newadbee/core/constants/constants.dart';
import 'package:newadbee/core/fonts/fonts.dart';
import 'package:newadbee/core/icons/icons.dart';

closeTicketCard(BuildContext context, TicketProv value, int index) {
  return Card(
    child: ExpansionTile(
      onExpansionChanged: (val) {
        value.toggleClosedTicket(index);
        value.getTicketDetails(context,
            ticketID: value.listClosedTicket[index].ticketId.toString());
      },
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Ticket: main title here'),
          Text(value.listClosedTicket[index].subject!,
              style: KFont().welcomeTextStyle),
          kheight5,
          Text(
            'Query',
            style: KFont().welcomeTextStyle.copyWith(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: kHeavyGreyColor),
          ),
          kheight3,
          Text(value.listClosedTicket[index].query!,
              style: KFont().welcomeTextStyle),
          kheight5,
          Text(
            'Adbee Reply',
            style: KFont().welcomeTextStyle.copyWith(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: kHeavyGreyColor),
          ),
          kheight3,
          Text('Adbee reply detail description over here',
              style: KFont().welcomeTextStyle),
          kheight5,
        ],
      ),
      trailing:
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        value.selectedClosedTicket![index] ? KIcon.arrowup : KIcon.arrowdown,
        kheight5,
        Text('id: ${value.listClosedTicket[index].ticketId!}'),
      ]),
      children: [
        value.listTicketConversion.isNotEmpty
            ? Card(
                child: ListTile(
                    title: Text(
                        'Subject - ${value.listTicketConversion[0].subject!}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Query - ${value.listTicketConversion[0].query!}'),
                        Text(
                            'is_reply_enable - ${value.listTicketConversion[0].isReplyEnable!}'),
                        Text(
                            'created_timestamp - ${value.listTicketConversion[0].createdTimestamp!}'),
                        Text(
                            'is_replied - ${value.listTicketConversion[0].isReplied!}'),
                      ],
                    )),
              )
            : SizedBox(),
      ],
    ),
  );
}

Card closeeeTicketCard(TicketProv value, int index) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Ticket: main title here'),
              Text(value.listClosedTicket[index].subject!),
            ]),
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              KIcon.arrowup,
              kheight5,
              Text('id: ${value.listClosedTicket[index].ticketId!}'),
            ]),
          ]),
          Text('Query'),
          Text(value.listClosedTicket[index].query!),
          Text('Adbee Reply'),
          Text('Adbee reply detail description over here'),
        ],
      ),
    ),
  );
}
