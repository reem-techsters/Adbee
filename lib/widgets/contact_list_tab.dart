import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:newadbee/controller/calls_prov.dart';
import 'package:newadbee/core/constants/constants.dart';
import 'package:newadbee/core/icons/icons.dart';
import 'package:newadbee/view/calls/contact_details_screen.dart';

contactListTab({
  required List<Contact> contacts,
  required CallsFetchProv provider,
}) {
  return Column(
    children: [
      kheight10,
      Expanded(
        child: contacts.isEmpty
            ? Center(child: Text('No Contacts'))
            : ListView.separated(
                padding: EdgeInsets.zero,
                separatorBuilder: (context, index) {
                  return kheight20;
                },
                itemCount: provider.searchController.text.isEmpty
                    ? contacts.length
                    : provider.searchData.length,
                itemBuilder: (context, index) {
                  final contact = provider.searchController.text.isEmpty
                      ? contacts[index]
                      : provider.searchData[index];

                  return contact.displayName == null
                      ? SizedBox.shrink()
                      : Container(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () async {
                              await FlutterPhoneDirectCaller.callNumber(
                                  contact.phones!.first.value.toString());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                kWidth20,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      contact.displayName.toString(),
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w300),
                                    ),
                                    kheight7,
                                    Text(
                                      contact.phones?.isNotEmpty ?? false
                                          ? contact.phones!.first.value ?? ''
                                          : '',
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                Expanded(child: SizedBox()),
                                IconButton(
                                  onPressed: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ContactDetailsScreen(
                                            index: index,
                                          ),
                                        ));
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
