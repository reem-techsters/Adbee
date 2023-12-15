import 'package:newadbee/core/colors/colors.dart';
import 'package:newadbee/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:newadbee/core/fonts/fonts.dart';
import 'package:newadbee/core/formats/date_format.dart';
import 'package:newadbee/core/icons/icons.dart';
import 'package:newadbee/core/images/images.dart';
import 'package:newadbee/model/payments_model.dart';

transactionsTab({
  required BuildContext context,
  required List<TransactionsDatum> listTransactions,
}) {
  return listTransactions.isEmpty
      ? Center(
        child: Text(
          'No Recent Transactions',
          style: KFont().welcomeTextStyle,
        ),
      )
      : Column(
          children: [
            kheight7,
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                separatorBuilder: (context, index) {
                  return kheight10;
                },
                itemCount: listTransactions.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 0,
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: kLightBlue,
                            child: KIcon.creditcard,
                          ),
                          kWidth20,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                    text: 'Withdrawal ',
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            '${listTransactions[index].amountRs.toString()} Rs',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: kPrimaryColor,
                                            fontSize: 15),
                                      )
                                    ]),
                              ),
                              RichText(
                                text: TextSpan(
                                    text: 'Status: ',
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Colors.black,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            listTransactions[index].transStatus,
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: kAddressTextColor,
                                            fontSize: 11,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      TextSpan(
                                        text: '  Date: ',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: kBlack,
                                            fontSize: 11),
                                      ),
                                      TextSpan(
                                        text: formatDateTime(
                                            listTransactions[index]
                                                .transDate
                                                .toString()),
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: kAddressTextColor,
                                            fontSize: 11,
                                            fontWeight: FontWeight.normal),
                                      )
                                    ]),
                              ),
                              kheight5,
                            ],
                          ),
                          const Expanded(child: SizedBox()),
                          KImage.download,
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
