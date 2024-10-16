import 'package:flutter/material.dart';

class MarketPage extends StatelessWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final gameData = Provider.of<GameData>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF07223C),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Market'),
      ),
      body: const Center(
        child: Text(
          "Market data goes here",
          style: TextStyle(fontSize: 24, color: Colors.white70),
        ),
      ),
    );
  }
}