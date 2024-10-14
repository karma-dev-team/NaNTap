import 'package:flutter/material.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final gameData = Provider.of<GameData>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Friends Page"),
      ),
      body: const Center(
        child: Text(
          "Friends data goes here",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
