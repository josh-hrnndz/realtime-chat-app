import 'package:flutter/material.dart';
import 'package:realtime_chat_app/view/widgets/loader/loader.widget.dart';

import '../../core/const/colors.dart';

class BaseModal extends StatelessWidget {
  final List<Widget> children;
  final String title;
  final String message;
  final double height;
  const BaseModal({
    Key? key,
    this.title = "",
    this.message = "",
    required this.children,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: TEXT_LIGHT,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: SizedBox(
        height: height * .2,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: children,
          ),
        ),
      ),
    );
  }
}

class LoadingModal extends BaseModal {
  LoadingModal({
    Key? key,
    required String message,
    required double height,
  }) : super(
          key: key,
          height: height,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                message,
                style: const TextStyle(color: TEXT_DARK),
              ),
            ),
            Container(
              width: height * .2,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: PRIMARY_LIGHT,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: LoaderAnimation(
                color: DARK,
                size: height * .03,
              ),
            ),
          ],
        );
}

class ConnectionFailedModal extends BaseModal {
  ConnectionFailedModal({
    Key? key,
    required String title,
    required String message,
    required double height,
  }) : super(
          key: key,
          height: height,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: TEXT_DARK,
                fontSize: 18,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                message,
                style: const TextStyle(
                  color: TEXT_DARK,
                  fontSize: 12,
                ),
              ),
            )
          ],
        );
}
