
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/textstyles.dart';

class NavigationButton extends StatelessWidget {

  final void Function() onPressed;
  final String text;

  const NavigationButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Material(
        borderRadius: BorderRadius.circular(15),
        color: DarkBlueColor,
        textStyle: buttonTextStyle,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Center(child: Text(text)),
          ),
        ),
      ),
    );
  }
}
