import 'dart:developer';
import 'package:newadbee/widgets/custom_dropdown2.dart';
import 'package:newadbee/controller/registration_prov.dart';
import 'package:newadbee/core/constants/constants.dart';
import 'package:newadbee/core/fonts/fonts.dart';
import 'package:newadbee/core/icons/icons.dart';
import 'package:newadbee/widgets/custom_bottomappbar.dart';
import 'package:newadbee/widgets/custom_dropdown_widget.dart';
import 'package:newadbee/widgets/custom_field_name.dart';
import 'package:newadbee/widgets/custom_textform_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompleteProfileScreen extends StatelessWidget {
  final String mobile;
  final String name;
  final String email;
  final String password;
  const CompleteProfileScreen({
    super.key,
    required this.name,
    required this.email,
    required this.password,
    required this.mobile,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Consumer<RegistrationProv>(
            builder: (context, value, child) {
              return Form(
                key: value.completeprofileformKey,
                child: Column(
                  children: [
                    kheight30,
                    Row(
                      children: [
                        kWidth30,
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back),
                        ),
                      ],
                    ),
                    kheight30,
                    Text(
                      'Complete your profile',
                      style: KFont().h1BoldStyle,
                    ),
                    kheight10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                name,
                                style: TextStyle(fontSize: 13.0),
                              ),
                              Text(
                                "+91 $mobile",
                                style: TextStyle(fontSize: 13.0),
                              ),
                              Text(
                                email,
                                style: TextStyle(fontSize: 13.0),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        kWidth20,
                        Text(
                          "Personal Details",
                          style: KFont().fieldNameStyle.copyWith(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    kheight10,
                    customFieldName(fieldname: 'Date of birth'),
                    kheight7,
                    InkWell(
                      onTap: () {
                        value.selectDob(context);
                      },
                      child: CustomTextFormField(
                        enabled: false,
                        controller: value.dobController,
                        validator: (val) => value.validateDateOfBirth(val!),
                        hintText: 'YYYY/MM/DD',
                        prefixIcon: Transform.scale(
                          scale: 0.55,
                          child: KIcon.cake,
                        ),
                      ),
                    ),
                    kheight15,
                    customFieldName(fieldname: 'Gender'),
                    kheight7,
                    customDropdownWidget(
                      dropdownvalue: value.selectedGender,
                      dropdownList: value.genderList,
                      hintText: 'Select your gender',
                      icon: Transform.scale(scale: 0.55, child: KIcon.gender),
                      onChanged: (newValue) {
                        if (newValue != null) {
                          value.genderValue(newValue);
                          value.updateProgress();
                        } else {
                          value.selectedGender = 'null';
                        }
                      },
                      errorText: 'Please select your gender',
                    ),
                    kheight15,
                    customFieldName(fieldname: 'Profession'),
                    kheight7,
                    customSearchDropDown(
                      title: 'Enter your profession',
                      prefix: true,
                      context: context,
                      items: value.professionList,
                      textEditingController: value.professionController,
                      selectedValue: value.selectedProfession,
                      onChanged: (String? newValue) {
                        value.professionValue(newValue!);
                        value.updateProgress();
                        log(value.selectedProfession.toString());
                      },
                      icon: KIcon.profession,
                      errorText: 'Please select your profession',
                    ),
                    kheight15,
                    customFieldName(fieldname: 'State'),
                    kheight7,
                    customSearchDropDown(
                      title: 'Select state',
                      isDistrict: true,
                      context: context,
                      items: value.stateList,
                      textEditingController: value.stateController,
                      selectedValue: value.selectedState,
                      onChanged: (String? newValue) {
                        value.stateValue(newValue!);
                        value.updateProgress();
                      },
                      icon: KIcon.profession,
                      errorText: 'Please select your state',
                    ),
                    kheight15,
                    customFieldName(fieldname: 'District'),
                    kheight7,
                    customSearchDropDown(
                      title: 'Select District',
                      context: context,
                      items: value.districtList,
                      textEditingController: value.cityController,
                      selectedValue: value.selectedDistrict,
                      onChanged: (String? newValue) {
                        value.selectedDistrict = '';
                        value.districtValue(newValue!);
                        value.updateProgress();
                      },
                      icon: KIcon.profession,
                      errorText: 'Please select your district',
                    ),
                    kheight15,
                    customFieldName(fieldname: 'Pincode'),
                    kheight7,
                    CustomTextFormField(
                      controller: value.pincodeController,
                      validator: (val) => value.textFormValidation(val!),
                      hintText: 'Enter pincode',
                      prefixIcon: null,
                    ),
                    kheight20,
                  ],
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: Consumer<RegistrationProv>(
          builder: (BuildContext context, value, Widget? child) {
            return customBottomAppBar(
              backonPressed: () => Navigator.pop(context),
              forwardonPressed: () {
                value.toReferalScreen(
                  context: context,
                  mobile: mobile,
                );
              },
              progress: value.progress,
            );
          },
        ),
      ),
    );
  }
}
