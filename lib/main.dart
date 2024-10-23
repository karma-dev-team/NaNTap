import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nantap/firebase_options.dart';
import 'package:nantap/pages/acievments.dart';
import 'package:nantap/pages/bazar.dart';
import 'package:nantap/pages/friends.dart';
import 'package:nantap/pages/home.dart';
import 'package:nantap/pages/profile.dart';
import 'package:nantap/pages/statistics.dart';
import 'package:nantap/pages/upgrades.dart';
import 'package:nantap/components/footer.dart';
import 'package:nantap/progress/achievment_manager.dart';
import 'package:nantap/progress/interfaces.dart';
import 'package:nantap/progress/manager.dart';
import 'package:nantap/progress/storage.dart';

void main() async {

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var storage = SQLiteStorage(); 
  var achievementManager = AchievmentManager(storage); 

  var progressManager = new ProgressManager(storage, achievementManager); 

  runApp(const MyApp(progressManager: progressManager,));
}

class MyApp extends StatefulWidget {
  final AbstractProgressManager progressManager; 

  MyApp({required this.progressManager, super.key});

  @override
  _MyAppState createState() => _MyAppState();
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'NanTap', manager: progressManager),
    );
  }
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    const MyHomePage(title: 'NanTap'),
    const UpgradesPage(tapStr: '0', lvlPrice: '0', pasProf: '0',),
    const MarketPage(),
    const FriendsPage(),
    const ProfilePage(),
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
