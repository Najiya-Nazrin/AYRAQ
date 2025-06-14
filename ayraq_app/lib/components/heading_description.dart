import 'package:flutter/material.dart';

class HeadingAndDescription extends StatelessWidget {
  final String heading;
  final String description;

  const HeadingAndDescription({
    required this.heading,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          heading,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.purple[800],
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            description,
            style: TextStyle(fontSize: 16, color: const Color.fromARGB(137, 0, 0, 0)),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
