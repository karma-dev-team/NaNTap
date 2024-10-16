import 'package:flutter/material.dart';

class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final gameData = Provider.of<GameData>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Achievements Page"),
      ),
      body: const Center(
        child: Text(
          "Achievements data goes here",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}