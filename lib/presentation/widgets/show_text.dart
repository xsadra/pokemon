import 'package:flutter/material.dart';

class ShowText extends StatelessWidget {
  final String title;
  final String value;

  const ShowText({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 150,
          height: 50,
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Positioned(
                left: 0,
                child: Icon(
                  Icons.label,
                  color: Colors.black,
                  size: 100,
                ),
              ),
              const Positioned(
                left: 50,
                child: Icon(
                  Icons.label,
                  color: Colors.black,
                  size: 100,
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 150,
          height: 50,
          child: Center(
            child: Text(
              value,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
