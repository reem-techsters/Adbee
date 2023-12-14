import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_dialpad/flutter_dialpad.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:newadbee/controller/calls_prov.dart';
import 'package:newadbee/core/colors/colors.dart';
import 'package:provider/provider.dart';

class DialPadScreen extends StatelessWidget {
  const DialPadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          color: kGrey,
                        ))
                  ],
                ),
              ),
              Expanded(
                child: DialPad(
                  enableDtmf: true,
                  hideSubtitle: false,
                  backspaceButtonIconColor: Colors.red,
                  buttonTextColor: Colors.white,
                  dialOutputTextColor: Colors.white,
                  keyPressed: (value) {},
                  makeCall: (number) async {
                    final provider =
                        Provider.of<CallsFetchProv>(context, listen: false);
                    provider.phoneState(context);
                    await FlutterPhoneDirectCaller.callNumber(
                        number.toString());
                    if (context.mounted) Navigator.pop(context);
                    log(number);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
