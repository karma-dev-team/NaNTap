import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Здесь можно вытащить информацию о профиле игрока
    // final gameData = Provider.of<GameData>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Page"),
      ),
      body: const Center(
        child: Text(
          "Profile data goes here",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}