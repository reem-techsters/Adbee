import 'package:flutter/material.dart';
import 'package:newadbee/core/colors/colors.dart';
import 'package:newadbee/core/constants/constants.dart';

class CustomToast extends StatelessWidget {
  final IconData? icon;
  final String message;

  const CustomToast({
    super.key,
    required this.icon,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 70,
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.green[700],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: kBlack.withOpacity(0.22),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: kWhite),
            kWidth10,
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  color: kWhite,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Handle close button tap
              },
              child: const Icon(
                Icons.close,
                color: kWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
