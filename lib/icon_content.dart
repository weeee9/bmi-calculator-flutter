import 'package:flutter/material.dart';
import 'constants.dart';

class IconContent extends StatelessWidget {
  final IconData iconData;
  final String label;

  const IconContent({super.key, required this.iconData, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconData,
          size: 80.0,
        ),
        const SizedBox(height: 15.0),
        Text(
          label,
          style: kLabelTextStyle,
        ),
      ],
    );
  }
}
