import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:newadbee/model/look_up_model.dart';
import 'package:newadbee/services/look_up_services.dart';
import 'package:newadbee/services/registration_services.dart';
import 'package:newadbee/view/registration/referral_code_screen.dart';

class RegistrationProv extends ChangeNotifier {
  final GlobalKey<FormState> createaccountformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> completeprofileformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> bankaddformKey = GlobalKey<FormState>();

  RegistrationProv() {
    //------------- CREATE ACCOUNT
    nameController.addListener(updateProgress);
    emailController.addListener(updateProgress);
    createpasswordController.addListener(updateProgress);
    confirmPasswordController.addListener(updateProgress);
    //------------- COMPLETE PROFILE
    dobController.addListener(updateProgress);
    genderController.addListener(updateProgress);
    professionController.addListener(updateProgress);
    stateController.addListener(updateProgress);
    cityController.addListener(updateProgress);
    pincodeController.addListener(updateProgress);
  }
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController createpasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  TextEditingController referralCodeController = TextEditingController();
//-----
  bool _genderVisible = false;
  bool _professionVisible = false;

  bool get genderVisible => _genderVisible;
  bool get professionVisible => _professionVisible;

  void toggleValidationVisibility() {
    _genderVisible = !_genderVisible;
    _professionVisible = !_professionVisible;
    notifyListeners();
  }

//-------------------------------------------* Update Progress
  double _progress = 0.0;

  double get progress => _progress;

  void updateProgress() {
    double newProgress = 0.0;
    if (nameController.text.isNotEmpty) newProgress += 0.1;
    if (emailController.text.isNotEmpty) newProgress += 0.1;
    if (createpasswordController.text.isNotEmpty) newProgress += 0.1;
    if (confirmPasswordController.text.isNotEmpty) newProgress += 0.1;
    if (dobController.text.isNotEmpty) newProgress += 0.1;
    if (selectedGender != null) newProgress += 0.1;
    if (selectedProfession != null && selectedProfession!.isNotEmpty) {
      newProgress += 0.1;
    }
    if (selectedState != null && selectedState!.isNotEmpty) {
      newProgress += 0.1;
    }
    if (selectedDistrict != null && selectedDistrict!.isNotEmpty) {
      newProgress += 0.1;
    }
    if (pincodeController.text.isNotEmpty) newProgress += 0.1;
    if (_progress != newProgress) {
      _progress = newProgress;
      notifyListeners();
    }
  }

//-------------------------------------------* DropDown
  List<Gender> gender = [];
  List<Profession> profession = [];
  List<StateLookUp> statemain = [];
  List<District> district = [];
  Future<void> getLookUps() async {
    final response = await LookUpServices().getLookUps();
    if (response != null) {
      if (response.genders != null) {
        gender =
            response.genders!.map((g) => Gender.fromJson(g.toJson())).toList();
        genderList = [...gender.map((g) => g.gender!)];
      } else {}
      if (response.professions != null) {
        profession = response.professions!
            .map((g) => Profession.fromJson(g.toJson()))
            .toList();
        professionList = [...profession.map((g) => g.name!)];
      } else {}
      if (response.states != null) {
        for (var state in response.states!) {
          statemain = response.states ?? [];
          stateList.add(state.stateName!);
          if (state.districts != null) {
            for (District district in state.districts!) {
              debugPrint(
                  'District ID: ${district.districtId}, District Name: ${district.districtName}, State ID: ${district.stateId}');
            }
          }
        }
      }

      notifyListeners();
    } else {
      debugPrint('null');
    }
  }

//* GENDER
  String? selectedGender;
  List<String> genderList = [];
  String genderID = '';

  genderValue(String newValue) {
    selectedGender = newValue;

    for (var i in gender) {
      if (i.gender == newValue) {
        if (i.id != null) {
          genderID = i.id.toString();
          log(i.id.toString());
        }
      }
    }
    notifyListeners();
    notifyListeners();
  }

//* PROFESSION
  String? selectedProfession;
  List<String> professionList = [];
  String professionID = '';

  professionValue(String newValue) {
    selectedProfession = newValue;
    notifyListeners();
    log('ctrl pro -->${professionController.text}');
    notifyListeners();
    for (var i in profession) {
      if (i.name == newValue) {
        if (i.id != null) {
          professionID = i.id.toString();
          log(i.id.toString());
        }
      }
    }

    notifyListeners();
  }

//* STATE
  String? selectedState;
  List<String> stateList = [];
  String stateID = '';

  stateValue(String newValue) {
    selectedDistrict = null;
    districtList.clear();
    selectedState = newValue;
    notifyListeners();
    for (var i in statemain) {
      if (i.stateName == newValue) {
        if (i.districts != null) {
          for (District x in i.districts!) {
            districtList.add(x.districtName!);
            log('distlist --> ${districtList.toString()}');
          }
          if (i.stateId != null) {
            stateID = i.stateId.toString();
            log('stateId --> ${i.stateId.toString()}');
          }
        }
      }
    }
    notifyListeners();
  }

//* DISTRICT
  String? selectedDistrict;
  List<String> districtList = [];
  String districtID = '';

  districtValue(String newValue) async {
    selectedDistrict = newValue;
    for (var i in statemain) {
      if (i.districts != null) {
        for (District x in i.districts!) {
          if (x.districtId != null && x.districtName == newValue) {
            districtID = x.districtId.toString();
          }
        }
      }
    }
    notifyListeners();
  }

  //-------------------------------------------* Validator
  String? validateUsername(String username) {
    if (username.isEmpty) {
      return 'Please enter a username';
    } else if (username.length < 3) {
      return 'Username must be at least 3 characters long';
    }
    return null;
  }

  String? validateEmail(String email) {
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (email.isEmpty) {
      return 'Please enter an email address';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Please enter password';
    } else if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    } else if (password.contains('@') ||
        password.contains('"') ||
        password.contains("'")) {
      return 'Password cannot contain "@", double quotes, or single quotes';
    }

    return null;
  }

  String? validateConfirmPassword(String confirmPassword, String password) {
    if (confirmPassword.isEmpty) {
      return 'Please confirm your password';
    } else if (confirmPassword != password) {
      return 'Passwords do not match';
    }

    return null;
  }

  String? validateDateOfBirth(String dob) {
    if (dob.isEmpty) return 'Please enter your date of birth';

    final RegExp datePattern = RegExp(r'^\d{4}/\d{2}/\d{2}$');

    if (!datePattern.hasMatch(dob)) {
      return 'Please enter a valid date in YYYY/MM/DD format';
    }

    final List<int?> parts = dob.split('/').map(int.tryParse).toList();

    if (parts.length != 3 || parts.any((part) => part == null)) {
      return 'Please enter a valid date of birth';
    }

    try {
      final currentDate = DateTime.now();
      final parsedDate = DateTime(parts[0]!, parts[1]!, parts[2]!);
      final minDate = currentDate.subtract(Duration(days: 365 * 100));

      if (parsedDate.isAfter(currentDate) || parsedDate.isBefore(minDate)) {
        return 'Please enter a valid date of birth';
      }
    } catch (e) {
      return 'Please enter a valid date of birth';
    }

    return null;
  }

  textFormValidation(String? value) {
    if (value!.isEmpty) {
      notifyListeners();
      return 'Please enter the pincode';
    }
    return null;
  }

  String? dropdownValidator(String value) {
    if (value.isEmpty) {
      return 'Please select an option';
    }
    return null;
  }

  void clearRegistrationFields() {
    nameController.clear();
    emailController.clear();
    createpasswordController.clear();
    confirmPasswordController.clear();
    dobController.clear();
    genderController.clear();
    professionController.clear();
    stateController.clear();
    cityController.clear();
    pincodeController.clear();
    referralCodeController.clear();
    selectedGender = null;
    selectedProfession = null;
    selectedState = null;
    selectedDistrict = null;
  }

  Future<void> toReferalScreen({
    required BuildContext context,
    required String mobile,
  }) async {
    if (completeprofileformKey.currentState!.validate()) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReferralCodeScreen(
              mobile: mobile,
            ),
          ));
    }
  }

  Future<void> sendUserDetails({
    required BuildContext context,
    required String mobile,
  }) async {
    await RegisterAndLoginServices().sendUserDetails(
        context: context,
        mobile: mobile,
        name: nameController.text,
        email: emailController.text,
        password: confirmPasswordController.text,
        dob: dobController.text,
        gender: genderID,
        profession: professionID,
        state: stateID,
        district: districtID,
        pincode: pincodeController.text,
        referral: referralCodeController.text);
  }
}


  // //-------------------------------------------* Navigation
  // int count = 0;
  // void gotoBankDetailsScreen(BuildContext context, {required String mobile}) {
  //   if (completeprofileformKey.currentState!.validate()) {
  //     if (progress >= 0.9960000000000001) {
  //     } else {
  //       log('Complete fields');
  //     }
  //   }

  //   if (_selectedGender == 'Select your gender' ||
  //       selectedProfession == 'Enter your profession') {
  //     if (count == 0) {
  //       toggleValidationVisibility();
  //       count = count + 1;
  //       notifyListeners();
  //       log(count.toString());
  //     }
  //   }
  //   if (_selectedGender != 'Select your gender' &&
  //       selectedProfession != 'Enter your profession' &&
  //       count > 0) {
  //     count = 0;
  //     notifyListeners();
  //   }
  // }