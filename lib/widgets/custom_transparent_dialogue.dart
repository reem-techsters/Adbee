import 'package:flutter/material.dart';

void showDialogTransperent(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) => Dialog(
      elevation: 0,
      backgroundColor: const Color(0x00ffffff),
      child: Container(
        color: const Color(0x00ffffff),
        alignment: FractionalOffset.center,
        height: 80.0,
        padding: const EdgeInsets.all(20.0),
        child: const CircularProgressIndicator(
          backgroundColor: Colors.transparent,
          semanticsLabel: 'Circular progress indicator',
        ),
      ),
    ),
  );
}
