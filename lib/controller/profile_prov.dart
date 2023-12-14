import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newadbee/model/look_up_model.dart';
import 'package:newadbee/model/profile_model.dart';
import 'package:newadbee/services/look_up_services.dart';
import 'package:newadbee/services/profile_services.dart';

class ProfileProv extends ChangeNotifier {
  final GlobalKey<FormState> editprofileformKey = GlobalKey<FormState>();
  List<PDatum> listProfile = [];
  List<Profession> profession = [];
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  bool showloader = true;

  Future<void> getLookUpss() async {
    final response = await LookUpServices().getLookUps();
    if (response != null) {
      if (response.professions != null) {
        profession = response.professions!
            .map((g) => Profession.fromJson(g.toJson()))
            .toList();
        professionList = [...profession.map((g) => g.name!)];
        notifyListeners();
      } else {}
      notifyListeners();
    } else {
      debugPrint('null');
    }
  }

  Future<void> getProfileDetails(BuildContext context) async {
    await getLookUpss();
    if (context.mounted) {
      final response =
          await ProfileServices().getProfileDetails(context: context);
      if (response != null) {
        listProfile = response.data ?? [];
        showloader = false;
        notifyListeners();

        fullnameController = TextEditingController(text: listProfile[0].uName);
        emailController = TextEditingController(text: listProfile[0].uEmail);
        await initialprofessionValue(listProfile[0].uProfession!);

        log('selscted profession --> ${selectedProfession.toString()}');
        notifyListeners();
      } else {
        debugPrint('nully');
      }
    }
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

  initialprofessionValue(int newValue) {
    log('newValue --> $newValue');
    for (var index in profession) {
      log('id --> ${index.name}');
      if (index.id == newValue) {
        selectedProfession = index.name;
        log(index.id.toString());
      }
    }
    notifyListeners();
  }

  String? base64Image;
  Future<dynamic> encodeToBase64() async {
    // path to your image file
    String filePath = image!.path.toString();

    // Read the image file as bytes
    List<int> imageBytes = await File(filePath).readAsBytes();

    // Encode the bytes to base64
    base64Image = base64Encode(imageBytes);

    // Print or use the base64-encoded string as needed
    log('Base64 Encoded Image: $base64Image');
  }

  Future<void> saveProfile({required BuildContext context}) async {
    if (editprofileformKey.currentState!.validate()) {
      showloader = true;
      encodeToBase64();
      notifyListeners();

      await ProfileServices().editProfile(
          context: context,
          name: fullnameController.text,
          email: emailController.text,
          profession: professionID.toString().isEmpty
              ? listProfile[0].uProfession.toString()
              : professionID.toString(),
          image: image != null ? base64Image : listProfile[0].uImage);
      getProfileDetails;
      showloader = false;
      notifyListeners();
    }
  }

  //--------------------------------------* FETCH IMAGE
  File? image;
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      this.image = imageTemporary;
      notifyListeners();
    } on PlatformException catch (e) {
      log('Failed to pick $e');
    }
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
}
