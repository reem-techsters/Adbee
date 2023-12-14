import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:newadbee/controller/calls_prov.dart';
import 'package:newadbee/core/formats/timestamp.dart';
import 'package:newadbee/core/colors/colors.dart';
import 'package:newadbee/core/constants/constants.dart';
import 'package:newadbee/core/icons/icons.dart';

Column recentCallsTab({
  required List<CallLogEntry> recentcalls,
  required CallsFetchProv provider,
}) {
  return Column(
    children: [
      kheight10,
      Expanded(
        child: recentcalls.isEmpty
            ? Center(
                child: InkWell(
                    onTap: () async {
                      await provider
                          .openContactDetailsScreen('8891240830')
                          .then((value) async {
                        provider.isSuccess == true
                            ? await provider.fetchContacts(update: true)
                            : null;
                        await provider.fetchContacts(update: true);
                      });
                    },
                    child: Text('No Recents')))
            : ListView.separated(
                separatorBuilder: (context, index) {
                  return kheight20;
                },
                itemCount: provider.searchController.text.isEmpty
                    ? recentcalls.length
                    : provider.searchData.length,
                itemBuilder: (context, index) {
                  final call = provider.searchController.text.isEmpty
                      ? recentcalls[index]
                      : provider.searchData[index];
                  final timestamp =
                      convertTimestampToFormattedDate(call.timestamp!);

                  return InkWell(
                    onTap: () async {
                      await FlutterPhoneDirectCaller.callNumber(
                          call.number.toString());
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: call.callType == CallType.incoming
                                ? kIncomingColor
                                : call.callType == CallType.outgoing
                                    ? kOutgoingColor
                                    : call.callType == CallType.missed
                                        ? kmissedColor
                                        : null,
                            child: call.callType == CallType.incoming
                                ? KIcon.incoming
                                : call.callType == CallType.outgoing
                                    ? KIcon.outgoing
                                    : call.callType == CallType.missed
                                        ? KIcon.missed
                                        : null,
                          ),
                          kWidth20,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                call.name == ''
                                    ? call.number!
                                    : call.name ?? call.number!,
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: call.name == ''
                                        ? FontWeight.w300
                                        : FontWeight.bold),
                              ),
                              kheight7,
                              Text(
                                timestamp,
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 11,
                                    color: Color.fromARGB(255, 151, 150, 150)),
                              ),
                            ],
                          ),
                          Expanded(child: SizedBox()),
                          IconButton(
                            onPressed: () async {
                              if (call.name.toString().isEmpty) {
                                provider.openContactForm();
                              } else {
                                await provider.openContactDetailsScreen(
                                    call.number.toString());
                              }
                              if (provider.isSuccess) {
                                await provider.fetchRecentCalls(update: true);
                              }
                            },
                            icon: Transform.scale(
                              scale: 0.85,
                              child: KIcon.arrowRight,
                            ),
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
