import 'dart:async';
import 'package:flutter/material.dart';
import 'package:newadbee/model/earnings_model.dart';
import 'package:newadbee/model/payments_model.dart';
import 'package:newadbee/model/profile_model.dart';
import 'package:newadbee/model/referral_model.dart';
import 'package:newadbee/services/profile_services.dart';
import 'package:newadbee/services/referral_services.dart';
import 'package:newadbee/services/wallet_services.dart';
import 'package:newadbee/widgets/custom_snackbar.dart';

class WalletProv extends ChangeNotifier {
  final GlobalKey<FormState> walletformKey = GlobalKey<FormState>();

  TextEditingController withdrawalAmtController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  int selectedValue = 0;

  void handleRadioValueChange(int? value) {
    if (value != null) {
      selectedValue = value;
      notifyListeners();
    }
  }

  List<PDatum> listProfile = [];
  Future<void> getProfileDetails(BuildContext context) async {
    if (context.mounted) {
      final response =
          await ProfileServices().getProfileDetails(context: context);
      if (response != null) {
        listProfile = response.data ?? [];
        linkController =
            TextEditingController(text: listProfile[0].referralCode);
        notifyListeners();
      } else {
        debugPrint('nully');
      }
    }
  }

  List<TransactionsDatum> listTransactions = [];
  Future<void> getTransactions(BuildContext context) async {
    if (context.mounted) {
      final response = await WalletServices().getTransactions(context: context);
      if (response != null && response.data != null) {
        listTransactions = response.data ?? [];
        notifyListeners();
      } else {
        debugPrint('null');
      }
    }
  }

  List<EarningsDatum> listEarnings = [];
  Future<void> getEarnings(BuildContext context) async {
    if (context.mounted) {
      final response = await WalletServices().getEarnings(context: context);
      if (response != null && response.data != null) {
        listEarnings = response.data ?? [];
        notifyListeners();
      } else {
        debugPrint('null');
      }
    }
  }

  Future<void> paymentWithdrawal({
    required BuildContext context,
  }) async {
    notifyListeners();
    if (walletformKey.currentState!.validate()) {
      if (selectedValue != 0) {
        await WalletServices().paymentWithdrawal(
          context: context,
          coins: withdrawalAmtController.text,
          paymentType: selectedValue == 1
              ? 'Bank Transfer'
              : selectedValue == 2
                  ? 'UPI Transfer'
                  : '',
        );
        if (context.mounted) {
          getProfileDetails(context);
          getTransactions(context);
        }
      } else {
        showCustomSnackbar(context, 'Choose payment option', false);
      }
    }
  }

  List<Referral> listReferral = [];
  int coins = 0;
  int count = 0;
  String? minEarnedCoins;
  String? referralBonus;
  Future<void> getReferral(BuildContext context) async {
    if (context.mounted) {
      final response = await ReferralServices().getReferral(context: context);
      if (response != null && response.data != null) {
        if (response.data!.referrals != null) {
          listReferral = response.data!.referrals ?? [];
          coins = response.data!.coins ?? 0;
          count = response.data!.count ?? 0;
          minEarnedCoins = response.data!.mincoinsearned ?? '';
          referralBonus = response.data!.refbonus ?? '';
        }
        notifyListeners();
      } else {
        debugPrint('nully');
      }
    }
  }

  textFormValidation(String? value) {
    if (value!.isEmpty) {
      notifyListeners();
      return 'This is required';
    }
    return null;
  }
//  textFormValidation(String? value) {
//     if (value!.isEmpty || value == '0') {
//       notifyListeners();
//       return 'This is required';
//     } else if (double.parse(listProfile[0].walletBalance!) == 0.00) {
//       return 'Cannot withdraw.Your balance is zero.';
//     } else if (double.parse(value) >
//         double.parse(listProfile[0].walletBalance!)) {
//       return 'Withdrawal amount exceeds your\navailable balance. Please check\nyour balance and try again.';
//     }
//     return null;
//   }
}
