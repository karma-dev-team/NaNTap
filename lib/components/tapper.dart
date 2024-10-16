import 'package:flutter/material.dart';

class Tapper extends StatelessWidget {
  final VoidCallback onTap;

  const Tapper({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      height: 200.0,
      child: FloatingActionButton(
        onPressed: onTap,
        tooltip: '',
        backgroundColor: Colors.orange,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Image.asset('assets/image/clicker_logo.png'),
      ),
    );
  }
}
