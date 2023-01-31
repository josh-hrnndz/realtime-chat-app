import 'package:flutter/material.dart';
import 'package:realtime_chat_app/core/const/index.dart';
import 'package:realtime_chat_app/view/widgets/button.widget.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: height * .4,
              width: width * .8,
              child: Image.asset(
                'assets/icon.png',
              ),
            ),
            SizedBox(
              height: height * .07,
              width: width * .5,
              child: AppButton(
                buttonType: 'text',
                textLabel: TALK_TO_STRANGER,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                buttonColor: DARK,
                borderRadius: 21,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
