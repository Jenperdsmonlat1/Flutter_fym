import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fym/ui/Color.dart';

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        "FuckYourMoney",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),
      ),
      elevation: 0,
      backgroundColor: background.withOpacity(0.2),
      leading: Image.asset('img/logo.png'),
    );
  }
}
