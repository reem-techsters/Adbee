import 'dart:developer';

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
        value.listTicketConversion.clear();
        value.getTicketDetails(context,
            ticketID: value.listClosedTicket[index].ticketId.toString());
        value.saveTicketIndex(index);
        log('savedd inndex = ${value.savedIndex.toString()}');
      },
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Ticket'),
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
        value.listTicketConversion.isEmpty
            ? SizedBox()
            : ListView.separated(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                        subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name',
                          style: KFont().welcomeTextStyle.copyWith(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: kHeavyGreyColor),
                        ),
                        Text(value.listTicketConversion[index].name,
                            style: KFont().welcomeTextStyle),
                        kheight5,
                        Text(
                          'Query',
                          style: KFont().welcomeTextStyle.copyWith(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: kHeavyGreyColor),
                        ),
                        Text(value.listTicketConversion[index].query.toString(),
                            style: KFont().welcomeTextStyle),
                        kheight10,
                        value.listTicketConversion[index].isReplyEnable == 0
                            ? SizedBox()
                            : Form(
                                key: value.myTicketformKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Reply',
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                    kheight7,
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: TextFormField(
                                        controller: value
                                            .replyTicketCLOSEDController[index],
                                        validator: (val) =>
                                            value.textFormValidation(val),
                                        maxLines: 4,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: kmissedColor,
                                          contentPadding:
                                              const EdgeInsets.all(10),
                                          hintText: 'Write your reply',
                                          hintStyle: const TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 13,
                                              color: kGrey),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: const BorderSide(
                                                color: kBlack, width: 15),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: const BorderSide(
                                                color: kBlack, width: 1),
                                          ),
                                        ),
                                      ),
                                    ),
                                    kheight15,
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              log(value
                                                  .listOpenTicket[
                                                      value.savedIndex!]
                                                  .ticketId
                                                  .toString());
                                              value.replyTicketClosed(
                                                  context: context,
                                                  ticketID: value
                                                      .listOpenTicket[
                                                          value.savedIndex!]
                                                      .ticketId
                                                      .toString(),
                                                  txtfieldIndex: index);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: kPrimaryColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              fixedSize: const Size(200, 50),
                                            ),
                                            child: const Text(
                                              'Submit',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ),
                                        ]),
                                    kheight15,
                                  ],
                                ),
                              ),
                      ],
                    )),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(),
                itemCount: value.listTicketConversion.length)
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
