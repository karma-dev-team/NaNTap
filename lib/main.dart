import 'dart:async'; // Для использования Timer
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nantap/firebase_options.dart';
import 'package:nantap/pages/bazar.dart';
import 'package:nantap/pages/friends.dart';
import 'package:nantap/pages/home.dart';
import 'package:nantap/pages/profile.dart';
import 'package:nantap/pages/upgrades.dart';
import 'package:nantap/components/footer.dart';
import 'package:nantap/progress/achievment_manager.dart';
import 'package:nantap/progress/interfaces.dart';
import 'package:nantap/progress/manager.dart';
import 'package:nantap/progress/storage.dart';
import 'package:nantap/progress/upgrade.dart';
import 'package:nantap/progress/upgradesList.dart';

void main() async {
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  var storage = SQLiteStorage();
  var achievementManager = AchievmentManager(storage);

  var progressManager = ProgressManager(storage, achievementManager);

  setupUpgradesRegistry(progressManager.getUpgradesRegistry());

  runApp(MyApp(progressManager: progressManager));
}


class MyApp extends StatefulWidget {
  final AbstractProgressManager progressManager;

  MyApp({required this.progressManager, super.key});

  @override
  _MyAppState createState() => _MyAppState(progressManager);
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  AbstractProgressManager manager;

  late Timer _timer; // Таймер для выполнения задачи

  _MyAppState(this.manager);

  @override
  void initState() {
    super.initState();
    // Запуск задачи, выполняющейся каждую секунду
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        manager.getState().increase(manager.getState().calcBread());
      });
    });
  }

  @override
  void dispose() {
    // Остановка таймера при удалении виджета
    _timer.cancel();
    super.dispose();
  }

  List<Widget> pages() {
    List<Widget> _pages = <Widget>[
      MyHomePage(title: 'NanTap', manager: manager),
      UpgradesPage(manager: manager,),
      MarketPage(),
      FriendsPage(),
      ProfilePage(),
    ];

    return _pages;
  }

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
          children: pages(),
        ),
        bottomNavigationBar: Footer(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }
}
