import 'package:flutter/material.dart';
import 'package:newadbee/model/bank_ifsc_model.dart';
import 'package:newadbee/model/bank_model.dart';
import 'package:newadbee/services/bank_services.dart';

class BankProv extends ChangeNotifier {
  final GlobalKey<FormState> bankaddformKey = GlobalKey<FormState>();

  TextEditingController accNumberController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController banknameController = TextEditingController();
  TextEditingController branchnameController = TextEditingController();
  TextEditingController upiController = TextEditingController();
  List<BDatum> listBank = [];
  Future<void> getBankDetails(BuildContext context) async {
    if (context.mounted) {
      final response = await BankServices().getBankDetails(context: context);
      if (response != null) {
        listBank = response.data ?? [];
        notifyListeners();
        accNumberController =
            TextEditingController(text: listBank[0].uBankAccNo);
        ifscController = TextEditingController(text: listBank[0].uIfsc);
        listBank[0].uIfsc != null
            ? getBankAndBranchDetails(listBank[0].uIfsc)
            : null;
        upiController = TextEditingController(text: listBank[0].uupi);
        notifyListeners();
      } else {
        debugPrint('nully');
      }
    }
  }

  Future<void> getBankAndBranchDetails(String ifsccode) async {
    BankIfscModel? response =
        await BankServices().getBankAndBranchDetails(ifsccode);
    if (response != null) {
      banknameController = TextEditingController(text: response.bank);
      branchnameController = TextEditingController(text: response.branch);
      notifyListeners();
    } else {
      debugPrint('null');
    }
  }

  Future<void> saveBank({required BuildContext context}) async {
    if (bankaddformKey.currentState!.validate()) {
      await BankServices().editBank(
          context: context,
          accnum: accNumberController.text,
          ifsc: ifscController.text,
          upi: upiController.text,
          bankname: banknameController.text,
          branch: branchnameController.text);
    }
    if (context.mounted) getBankDetails(context);
  }

  //-------------------------------------------* Validator
  String? validateAccNumber(String value) {
    if (value.length < 5) {
      return 'Please enter appropriate account number';
    }
    return null;
  }

  textFormValidation(String? value) {
    if (value!.isEmpty) {
      notifyListeners();
      return 'This is required';
    }
    return null;
  }
}
