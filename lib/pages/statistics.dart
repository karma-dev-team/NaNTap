
import 'package:flutter/material.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final gameData = Provider.of<GameData>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Statistics Page"),
      ),
      body: const Center(
        child: Text(
          "Statistics data goes here",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
