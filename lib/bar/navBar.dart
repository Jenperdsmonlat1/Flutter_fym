import 'package:flutter/material.dart';
import 'package:fym/AboutPage.dart';
import 'package:fym/AddNewPage.dart';
import 'package:fym/HomePage.dart';
import 'package:fym/NewsEcoPage.dart';
import 'package:fym/StatsPage.dart';
import 'package:fym/ui/Color.dart';

class navBar extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => new Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: background,
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: black,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                color: iconColor,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyHomePage()));
                },
                icon: Icon(Icons.home),
              ),
              IconButton(
                color: iconColor,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyStatPage()));
                },
                icon: Icon(Icons.bar_chart),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyAddNewPage()),
                  );
                },
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(10),
                  primary: yellowButton,
                ),
              ),
              IconButton(
                color: iconColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyNewsEcoPage()),
                  );
                },
                icon: Icon(Icons.web),
              ),
              IconButton(
                color: iconColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyAboutPage()),
                  );
                },
                icon: Icon(Icons.question_mark),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
