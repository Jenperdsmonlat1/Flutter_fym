import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fym/ui/Color.dart';

class WebViewTopBar extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => new Size.fromHeight(50);

  final String articleURL;
  WebViewTopBar({required this.articleURL});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: background,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.close,
          color: Colors.black,
        ),
      ),
      title: Text(
        "${this.articleURL}",
        style: TextStyle(
          color: Colors.black,
          fontFamily: "Noto Sans",
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),
    );
  }
}
