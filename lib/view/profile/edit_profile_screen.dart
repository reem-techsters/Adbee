import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newadbee/controller/profile_prov.dart';
import 'package:newadbee/controller/ticket_prov.dart';
import 'package:newadbee/core/colors/colors.dart';
import 'package:newadbee/core/constants/constants.dart';
import 'package:newadbee/core/icons/icons.dart';
import 'package:newadbee/widgets/custom_dropdown2.dart';
import 'package:newadbee/widgets/custom_field_name.dart';
import 'package:newadbee/widgets/custom_textform_widget.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    final provider = Provider.of<ProfileProv>(context, listen: false);
    provider.getProfileDetails(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Consumer<ProfileProv>(
        builder: (context, value, child) {
          return Form(
            key: value.editprofileformKey,
            child: value.showloader
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        kheight30,
                        Padding(
                          padding: EdgeInsets.only(left: 30.0, right: 30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    final provider = Provider.of<TicketProv>(
                                        context,
                                        listen: false);
                                    provider.getProfileDetails(context);
                                  },
                                  child: Icon(Icons.arrow_back)),
                              kWidth110,
                              Text('Edit Profile'),
                            ],
                          ),
                        ),
                        kheight30,
                        kheight10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 55,
                                  backgroundColor: Colors.grey,
                                  backgroundImage: value.image == null &&
                                          value.listProfile[0].uImage != null
                                      ? MemoryImage(base64.decode(value
                                          .listProfile[0].uImage!
                                          .split(',')
                                          .last))
                                      : FileImage(value.image!)
                                          as ImageProvider<Object>,
                                ),
                                // CircleAvatar(
                                //   radius: 55,
                                //   backgroundColor: kGrey,
                                //   backgroundImage: value.image == null &&
                                //           value.listProfile[0].uImage != null
                                //       ? Image.memory(base64.decode(value
                                //           .listProfile[0].uImage!
                                //           .split(',')
                                //           .last))
                                //       : (value.image != null
                                //               ? FileImage(value.image!)
                                //               : AssetImage(
                                //                   'assets/images/userprofile.png'))
                                //           as ImageProvider<Object>,
                                // ),
                                // Text(value.image!.path.split('/').last.toString(),style: TextStyle(fontSize: 6),),
                                Positioned(
                                  top: 60.0,
                                  left: 70.0,
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: kPrimaryColor,
                                    child: Center(
                                      child: IconButton(
                                        onPressed: () {
                                          dialogues(context, onPressed: () {
                                            Navigator.pop(context);
                                            value
                                                .pickImage(ImageSource.gallery);
                                          }, onPressed2: () {
                                            Navigator.pop(context);
                                            value.pickImage(ImageSource.camera);
                                          });
                                        },
                                        icon: const Icon(Icons.add_a_photo),
                                        iconSize: 23,
                                        color: kWhite,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        kheight50,
                        customFieldName(fieldname: 'Full Name'),
                        kheight7,
                        CustomTextFormField(
                          controller: value.fullnameController,
                          validator: (val) => value.validateUsername(val!),
                          hintText: 'Enter your full name',
                          prefixIcon: Transform.scale(
                            scale: 0.37,
                            child: KIcon.uname,
                          ),
                        ),
                        kheight30,
                        customFieldName(fieldname: 'Email Address'),
                        kheight7,
                        CustomTextFormField(
                          controller: value.emailController,
                          validator: (val) => value.validateEmail(val!),
                          hintText: 'Enter your email address',
                          prefixIcon: Transform.scale(
                            scale: 0.37,
                            child: KIcon.mail,
                          ),
                        ),
                        kheight30,
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
                            log(value.selectedProfession.toString());
                          },
                          icon: KIcon.profession,
                          errorText: 'Please select your profession',
                        ),
                        kheight30,
                        kheight50,
                        ElevatedButton(
                          onPressed: () {
                            value.saveProfile(context: context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            fixedSize: const Size(150, 50),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Icon(Icons.save),
                              Text('Save Now'),
                            ],
                          ),
                        ),
                        kheight15
                      ],
                    ),
                  ),
          );
        },
      ),
    ));
  }
}

dialogues(BuildContext context,
    {required void Function()? onPressed,
    required void Function()? onPressed2}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text('Pick an Image'),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: onPressed,
            child: Text('Pick Image from Gallery'),
          ),
          SimpleDialogOption(
            onPressed: onPressed2,
            child: Text('Pick Image from Camera'),
          ),
        ],
      );
    },
  );
}
