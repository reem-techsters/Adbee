import 'package:flutter/material.dart';
import 'package:newadbee/controller/ticket_prov.dart';
import 'package:newadbee/core/colors/colors.dart';
import 'package:newadbee/core/constants/constants.dart';
import 'package:newadbee/core/fonts/fonts.dart';
import 'package:newadbee/widgets/custom_field_name.dart';
import 'package:newadbee/widgets/custom_textform_widget.dart';
import 'package:provider/provider.dart';

Consumer createTicketTab() {
  return Consumer<TicketProv>(builder: (context, value, child) {
    return Form(
      key: value.createTicketformKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            kheight15,
            customFieldName(fieldname: 'Subject'),
            kheight7,
            CustomTextFormField(
                controller: value.subjectController,
                validator: (val) => value.textFormValidation(val!),
                hintText: 'Subject',
                prefixIcon: null),
            kheight15,
            customFieldName(fieldname: 'Query'),
            kheight7,
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: TextFormField(
                controller: value.queryController,
                maxLines: 5,
                validator: (val) => value.textFormValidation(val!),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 38.0, top: 20),
                  hintText: 'Write your query',
                  hintStyle: KFont().hintTextStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: kBlack, width: 15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: kBlack, width: 1),
                  ),
                ),
              ),
            ),
            kheight30,
            ElevatedButton(
              onPressed: () {
                value.createTicket(context: context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                fixedSize: const Size(320, 50),
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  });
}
