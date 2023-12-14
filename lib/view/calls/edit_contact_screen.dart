import 'package:flutter/material.dart';
import 'package:newadbee/core/colors/colors.dart';
import 'package:newadbee/core/constants/constants.dart';
import 'package:newadbee/core/icons/icons.dart';
import 'package:newadbee/widgets/custom_field_name.dart';
import 'package:newadbee/widgets/custom_textform_widget.dart';

class EditContactDetailsScreen extends StatelessWidget {
  const EditContactDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            kheight30,
            const Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.arrow_back),
                  kWidth110,
                  Text('Edit Contact'),
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
                    const CircleAvatar(
                      radius: 55,
                      backgroundColor: kGrey,
                    ),
                    Positioned(
                      top: 60.0,
                      left: 70.0,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: kPrimaryColor,
                        child: Center(
                          child: IconButton(
                            onPressed: () {},
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
              hintText: 'Enter your full name',
              prefixIcon: Transform.scale(
                scale: 0.37,
                child: KIcon.uname,
              ),
            ),
            kheight30,
            customFieldName(fieldname: 'Your Number'),
            kheight7,
            CustomTextFormField(
              hintText: 'Enter your phone number',
              prefixIcon: Transform.scale(
                scale: 0.37,
                child: KIcon.phone,
              ),
            ),
            kheight30,
            customFieldName(fieldname: 'Email Address'),
            kheight7,
            CustomTextFormField(
              hintText: 'Enter your email address',
              prefixIcon: Transform.scale(
                scale: 0.37,
                child: KIcon.mail,
              ),
            ),
            kheight30,
            customFieldName(fieldname: 'Date of birth'),
            kheight7,
            CustomTextFormField(
              hintText: 'DD/MM/YYYY',
              prefixIcon: Transform.scale(
                scale: 0.55,
                child: KIcon.cake,
              ),
            ),
            kheight50,
            ElevatedButton(
              onPressed: () {},
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
    ));
  }
}
