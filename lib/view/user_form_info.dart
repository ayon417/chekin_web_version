
import 'package:flutter/material.dart';

class UserFormInfo extends StatelessWidget {
  const UserFormInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 30, top: 100),
          child: const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Let\'s get you\nset up !',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w800),
            ),
          ),
        ),
        const SizedBox(height: 40),
        Container(
          margin: const EdgeInsets.only(left: 30),
          child: const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'It should take a couple\nof steps to create\nyour account',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
        SizedBox(height: 60),
        Text(
          "Stay Safe Online",
          style: TextStyle(
            color: Colors.white60,
            fontSize: 25.0,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
