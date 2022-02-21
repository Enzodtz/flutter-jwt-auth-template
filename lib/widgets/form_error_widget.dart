import 'package:flutter/material.dart';

class FormErrorWidget extends StatelessWidget {
  final String text;

  const FormErrorWidget(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        color: Colors.red,
      ),
    );
  }
}
