import 'dart:io';

import 'package:flutter/material.dart';

class BackButton extends StatelessWidget {
  // onPressed function
  final VoidCallback? onPressed;
  final Color iconColor;

  const BackButton(
      {super.key, required this.onPressed, this.iconColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
        color: iconColor,
      ),
      onPressed: () {
        if (onPressed == null) {
          Navigator.of(context).pop();
        } else {
          onPressed!();
        }
      }
    );
  }
}
