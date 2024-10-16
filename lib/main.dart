import 'package:flutter/material.dart';
import 'package:nantap/pages/acievments.dart';
import 'package:nantap/pages/bazar.dart';
import 'package:nantap/pages/friends.dart';
import 'package:nantap/pages/home.dart';
import 'package:nantap/pages/profile.dart';
import 'package:nantap/pages/statistics.dart';
import 'package:nantap/pages/upgrades.dart';
import 'package:nantap/components/footer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    MyHomePage(title: 'NanTap'),
    UpgradesPage(),
    MarketPage(),
    FriendsPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NaNTap',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: Footer(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }
}
