import 'package:flutter/material.dart';
import 'package:fym/ui/Color.dart';

class ErrorConnection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: background,
      body: Center(
        child: Container(
          height: 500,
          margin: const EdgeInsets.fromLTRB(35, 0, 35, 0),
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.lightBlue.shade100,
            borderRadius: BorderRadius.circular(60),
            boxShadow: [
              BoxShadow(
                blurRadius: 60,
                spreadRadius: 2,
                color: Colors.lightBlueAccent.shade200,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("img/logo.png"),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Vous êtes hors ligne",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Connectez-vous à internet pour profiter pleinement de FuckYourMoney",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
