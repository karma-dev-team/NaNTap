import 'package:flutter/material.dart';

Widget buildMenuCard(String title, String value, String iconPath, Color color, double width) {
  return Container(
    padding: const EdgeInsets.all(10),
    width: width,
    decoration: BoxDecoration(
      color: const Color(0xFF1D466C),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Column(
      children: [
        Text(
          title,
          style: TextStyle(color: color, fontSize: 14),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: const TextStyle(color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 2.5),
            Image.asset(
              iconPath,
              width: 20,
              height: 20,
            ),
          ],
        ),
      ],
    ),
  );
}