import 'package:flutter/material.dart';

class UpgradesPage extends StatelessWidget {
  const UpgradesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final gameData = Provider.of<GameData>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Upgrade Page"),
      ),
      body: const Center(
        child: Text(
          "Upgrade data goes here",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
