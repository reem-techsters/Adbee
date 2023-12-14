import 'package:flutter/material.dart';
import 'package:newadbee/controller/bank_prov.dart';
import 'package:newadbee/core/colors/colors.dart';
import 'package:newadbee/core/constants/constants.dart';
import 'package:newadbee/core/fonts/fonts.dart';
import 'package:newadbee/core/icons/icons.dart';
import 'package:newadbee/widgets/custom_field_name.dart';
import 'package:newadbee/widgets/custom_menu.dart';
import 'package:newadbee/widgets/custom_textform_widget.dart';
import 'package:provider/provider.dart';

class EditBankDetailsScreen extends StatefulWidget {
  const EditBankDetailsScreen({super.key});

  @override
  State<EditBankDetailsScreen> createState() => _EditBankDetailsScreenState();
}

class _EditBankDetailsScreenState extends State<EditBankDetailsScreen> {
  @override
  void initState() {
    final provider = Provider.of<BankProv>(context, listen: false);
    provider.getBankDetails(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        child: Consumer<BankProv>(builder: (context, value, child) {
          return Form(
            key: value.bankaddformKey,
            child: Column(
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
                      Text('Banking'),
                      CustomPopupMenuButton()
                    ],
                  ),
                ),
                kheight40,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    kWidth20,
                    Text(
                      "Bank Details",
                      style: KFont()
                          .fieldNameStyle
                          .copyWith(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                kheight15,
                customFieldName(fieldname: 'Bank Account Number'),
                kheight7,
                CustomTextFormField(
                  controller: value.accNumberController,
                  validator: (val) => value.textFormValidation(val!),
                  hintText: 'Enter your bank account number',
                  prefixIcon: null,
                ),
                kheight15,
                customFieldName(fieldname: 'Bank IFSC Code'),
                kheight7,
                CustomTextFormField(
                  controller: value.ifscController,
                  validator: (val) => value.textFormValidation(val!),
                  hintText: 'Enter your IFCS code',
                  prefixIcon: null,
                  onChanged: (val) {
                    if (val.length == 11) {
                      value.getBankAndBranchDetails(val);
                    }
                  },
                ),
                kheight15,
                customFieldName(fieldname: 'Bank Name'),
                kheight7,
                CustomTextFormField(
                  enabled: false,
                  controller: value.banknameController,
                  validator: (val) => value.textFormValidation(val!),
                  hintText: 'Enter your bank name',
                  prefixIcon: null,
                ),
                kheight15,
                customFieldName(fieldname: 'Branch Name'),
                kheight7,
                CustomTextFormField(
                  enabled: false,
                  controller: value.branchnameController,
                  validator: (val) => value.textFormValidation(val!),
                  hintText: 'Enter your branch name',
                  prefixIcon: null,
                ),
                kheight30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    kWidth20,
                    Text(
                      "UPI ID",
                      style: KFont()
                          .fieldNameStyle
                          .copyWith(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                kheight15,
                customFieldName(fieldname: 'UPI ID'),
                kheight7,
                CustomTextFormField(
                  controller: value.upiController,
                  hintText: 'Enter your UPI ID',
                  validator: (val) => value.textFormValidation(val!),
                  prefixIcon: null,
                  suffixIcon: Transform.scale(
                    scale: 0.37,
                    child: KIcon.verified,
                  ),
                ),
                kheight100,
                ElevatedButton(
                  onPressed: () {
                    value.saveBank(context: context);
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      backgroundColor: kPrimaryColor,
                      fixedSize: const Size(150, 55),
                      shadowColor: Colors.transparent),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      KIcon.editnow,
                      Text(value.listBank.isNotEmpty &&
                              value.listBank[0].uBankAccNo == null
                          ? 'Add Now'
                          : 'Edit Now'),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    ));
  }
}
