import 'package:flutter/material.dart';

class MarketPage extends StatelessWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final gameData = Provider.of<GameData>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Market Page"),
      ),
      body: const Center(
        child: Text(
          "Market data goes here",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}