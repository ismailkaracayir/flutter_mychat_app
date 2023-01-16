import 'package:flutter/material.dart';

class SocialSingInWidget extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final Widget buttonIcon;
  final double buttonHeight;
  final VoidCallback onPress;

  const SocialSingInWidget(
      {super.key,
      required this.buttonText,
      required this.buttonIcon,
      this.buttonColor = Colors.red,
      this.textColor = Colors.black,
      this.buttonHeight = 20,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ButtonStyle(
          alignment: Alignment.centerLeft,
          fixedSize: MaterialStateProperty.all(const Size(300, 40)),
          backgroundColor: MaterialStateProperty.all(buttonColor),
          overlayColor: MaterialStateProperty.all(textColor.withOpacity(0.3)),
          elevation: MaterialStateProperty.all(20),
        ),
        onPressed: onPress,
        icon: buttonIcon,
        label: Text(
          buttonText,
          style: TextStyle(
              color: textColor, fontWeight: FontWeight.bold, fontSize: 17),
        ));
  }
}
