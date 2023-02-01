import 'package:flutter/material.dart';

class ControlButton extends StatelessWidget {
  final double height;
  final double width;
  final Color buttonColor;
  final String label;
  final void Function() onTap;
  const ControlButton({
    super.key,
    required this.height,
    required this.width,
    required this.buttonColor,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: buttonColor,
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
