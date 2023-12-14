import 'package:flutter/material.dart';
import 'package:newadbee/core/colors/colors.dart';


class CircleButtonWidget extends StatelessWidget {
  final Color color;
  final VoidCallback? onPressed;
  final bool? arrowback;
  const CircleButtonWidget({
    super.key,
    required this.color,
    this.onPressed,
    this.arrowback,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: CircleAvatar(
        backgroundColor: color,
        radius: 25,
        child: Icon(
          arrowback == true ? Icons.arrow_back : Icons.arrow_forward,
          color: kWhite,
        ),
      ),
    );
  }
}
