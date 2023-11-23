import 'package:flutter/material.dart';

class PositionedCircularIndicator extends StatelessWidget {
  final String? text;

  const PositionedCircularIndicator({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(text ?? '',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14
            )),
          ],
        ),
      ),
    );
  }
}