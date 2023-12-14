import 'package:flutter/material.dart';
import 'package:newadbee/controller/wallet_prov.dart';
import 'package:newadbee/core/colors/colors.dart';
import 'package:newadbee/core/constants/constants.dart';
import 'package:newadbee/core/fonts/fonts.dart';
import 'package:newadbee/widgets/custom_radio_button.dart';
import 'package:provider/provider.dart';

class CustomWithdrawalAlertDialog extends StatefulWidget {
  const CustomWithdrawalAlertDialog({super.key});

  @override
  State<CustomWithdrawalAlertDialog> createState() =>
      _CustomWithdrawalAlertDialogState();
}

class _CustomWithdrawalAlertDialogState
    extends State<CustomWithdrawalAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WalletProv>(builder: (context, value, child) {
      return Form(
        key: value.walletformKey,
        child: AlertDialog(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Withdrawal Amount',
                    style: TextStyle(fontSize: 13.0),
                  ),
                  kheight7,
                  TextFormField(
                    controller: value.withdrawalAmtController,
                    validator: (String? val) {
                      return value.textFormValidation(val);
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 38.0),
                      hintText: 'Enter Amount',
                      hintStyle: KFont().hintTextStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: kBlack),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: kBlack),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: kBlack),
                      ),
                    ),
                  ),
                  kheight15,
                  Row(
                    children: [
                      CustomRadioButton(
                        value: 1,
                        groupValue: value.selectedValue,
                        onChanged: value.handleRadioValueChange,
                        outerColor:
                            value.selectedValue == 1 ? kWhite : kPrimaryColor,
                        innerColor:
                            value.selectedValue == 1 ? kPrimaryColor : kWhite,
                      ),
                      kWidth10,
                      Text('Bank Transfer', style: TextStyle(fontSize: 13.0)),
                      kWidth25,
                      CustomRadioButton(
                        value: 2,
                        groupValue: value.selectedValue,
                        onChanged: value.handleRadioValueChange,
                        outerColor:
                            value.selectedValue == 2 ? kWhite : kPrimaryColor,
                        innerColor:
                            value.selectedValue == 2 ? kPrimaryColor : kWhite,
                      ),
                      kWidth10,
                      Text('UPI Transfer', style: TextStyle(fontSize: 13.0)),
                    ],
                  ),
                  kheight15,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          value.paymentWithdrawal(context: context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          fixedSize: const Size(150, 45),
                        ),
                        child: const Text('Submit'),
                      ),
                      kheight30,
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
