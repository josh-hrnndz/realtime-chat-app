import 'package:flutter/material.dart';
import 'package:realtime_chat_app/core/const/colors.dart';

class AppButton extends StatelessWidget {
  final String buttonType;
  final String textLabel;
  final IconData icon;
  final double fontSize;
  final FontWeight fontWeight;
  final Color buttonColor;
  final Color labelColor;
  final double borderRadius;
  const AppButton({
    super.key,
    required this.buttonType,
    this.textLabel = "Press me!",
    this.icon = Icons.touch_app_rounded,
    this.fontSize = 13,
    this.fontWeight = FontWeight.w300,
    this.buttonColor = PRIMARY_DARK,
    this.labelColor = TEXT_LIGHT,
    this.borderRadius = 15,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: buttonType == 'text'
          ? Text(
              textLabel,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: labelColor,
              ),
            )
          : Icon(
              icon,
              color: labelColor,
              size: fontSize,
            ),
    );
  }
}
