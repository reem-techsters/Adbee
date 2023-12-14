import 'package:flutter/material.dart';
import 'package:newadbee/controller/registration_prov.dart';
import 'package:newadbee/core/colors/colors.dart';
import 'package:newadbee/core/constants/constants.dart';
import 'package:newadbee/core/icons/icons.dart';
import 'package:newadbee/core/images/images.dart';
import 'package:newadbee/widgets/custom_circle_button_widget.dart';
import 'package:newadbee/widgets/custom_textform_widget.dart';
import 'package:provider/provider.dart';

class ReferralCodeScreen extends StatelessWidget {
  final String mobile;
  const ReferralCodeScreen({super.key, required this.mobile});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          kheight30,
          Row(
            children: [
              kWidth30,
              InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back))
            ],
          ),
          kheight30,
          const Text(
            'Referral Code',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          kheight50,
          SizedBox(height: 170, child: KImage.referralgift),
          kheight50,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              kWidth30,
              Text(
                "Referral Code",
                style: TextStyle(fontSize: 13.0),
              ),
            ],
          ),
          kheight7,
          Consumer<RegistrationProv>(builder: (context, value, child) {
            return CustomTextFormField(
              controller: value.referralCodeController,
              hintText: 'Enter your referral friend mobile number',
              prefixIcon: Transform.scale(
                scale: 0.37,
                child: KIcon.gift,
              ),
            );
          }),
          kheight50,
          CircleButtonWidget(
            color: kPrimaryColor,
            onPressed: () {
              var provider =
                  Provider.of<RegistrationProv>(context, listen: false);
              provider.sendUserDetails(context: context, mobile: mobile);
            },
          ),
        ],
      ),
    ));
  }
}
