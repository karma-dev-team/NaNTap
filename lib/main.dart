import 'package:flutter/material.dart';
import 'package:nantap/pages/acievments.dart';
import 'package:nantap/pages/bazar.dart';
import 'package:nantap/pages/friends.dart';
import 'package:nantap/pages/home.dart';
import 'package:nantap/pages/profile.dart';
import 'package:nantap/pages/statistics.dart';
import 'package:nantap/pages/upgrades.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NaNTap',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: { 
        '/': (context) => const MyHomePage(title: "NanTap"), 
        '/profile': (context) => const ProfilePage(),
        '/market': (context) => const MarketPage(),
        '/friends': (context) => const FriendsPage(),
        '/statistics': (context) => const StatsPage(),
        '/upgrades': (context) => const UpgradesPage(),
        '/achievements': (context) => const AchievementsPage(), // Добавляем маршрут
      }, 
      initialRoute: '/',
    );
  }
}
