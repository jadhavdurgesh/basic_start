import 'package:flutter/material.dart';

import '../colors.dart';

class CustomTextfield extends StatelessWidget {
  final int length;
  final int lines;
  final double height;
  const CustomTextfield({
    super.key,
    required this.length,
    required this.lines,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
          color: surfaceWhite1, borderRadius: BorderRadius.circular(8)),
      child: TextField(
        maxLength: length,
        scrollPhysics: const ClampingScrollPhysics(),
        maxLines: lines,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "/ Describe your perfect hotspot",
        ),
        style: TextStyle(color: textColor),
      ),
    );
  }
}
