// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class custom_button extends StatelessWidget {
  void Function() ontap;
  custom_button({
    Key? key,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.1), // Darker side of the gradient
                Colors.white.withOpacity(0.01), // More transparent
                Colors.black.withOpacity(0.1), // Darker side of the gradient
                Colors.black.withOpacity(0.1), // Darker side of the gradient
                Colors.white.withOpacity(0.01), // More transparent
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blueGrey.withOpacity(0.3))),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Next',
              style: TextStyle(color: Colors.white), // Text color
            ),
            SizedBox(width: 8), // Space between text and icon
            Icon(
              Icons.navigate_next_rounded,
              color: Colors.white, // Icon color
            ),
          ],
        ),
      ),
    );
  }
}
