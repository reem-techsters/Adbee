import 'package:flutter/material.dart';
import 'package:newadbee/core/colors/colors.dart';

class CustomRadioButton extends StatelessWidget {
  final int value;
  final int groupValue;
  final Function(int?)? onChanged;
  final Color outerColor;
  final Color innerColor;

  const CustomRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.outerColor,
    required this.innerColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged!(value);
      },
      child: Container(
        width: 20.0,
        height: 20.0,
        decoration: BoxDecoration(
          color: kWhite,
          shape: BoxShape.circle,
          border: Border.all(color: outerColor, width: 2.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: Offset(0, 3),
              blurRadius: 6,
              spreadRadius: 0,
            )
          ],
        ),
        child: Center(
          child: Container(
            width: 20.0,
            height: 20.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: value == groupValue ? innerColor : Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
