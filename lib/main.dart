import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nantap/firebase_options.dart';
import 'package:nantap/pages/acievments.dart';
import 'package:nantap/pages/statistics.dart';
import 'package:nantap/pages/auth.dart';
import 'package:nantap/pages/bazar.dart';
import 'package:nantap/pages/friends.dart';
import 'package:nantap/pages/home.dart';
import 'package:nantap/pages/profile.dart';
import 'package:nantap/pages/upgrades.dart';
import 'package:nantap/components/footer.dart';
import 'package:nantap/progress/achievment_manager.dart';
import 'package:nantap/progress/interfaces.dart';
import 'package:nantap/progress/jsonstorage.dart';
import 'package:nantap/progress/manager.dart';
import 'package:nantap/progress/progressManagerData.dart';
import 'package:nantap/progress/storage.dart';
import 'package:nantap/progress/upgradesList.dart';
// import 'package:nantap/progress/webjsonstorage.dart';  // JSON STORAGE FOR WEB VERSION
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var storage = SQLiteStorage();
  var achievementManager = AchievmentManager(storage);

  await storage.setup(); 

  var progressManager = ProgressManager(storage, achievementManager);

  setupCompaniesData(progressManager); 
  setupUpgradesRegistry(progressManager.getUpgradesRegistry());

  runApp(MyApp(progressManager: progressManager, isTestMode: true));
}

class MyApp extends StatefulWidget {
  final AbstractProgressManager progressManager;
  final bool isTestMode;

  const MyApp({required this.progressManager, required this.isTestMode, super.key});

  @override
  _MyAppState createState() => _MyAppState(progressManager, isTestMode);
}

class _MyAppState extends State<MyApp> {
  final AbstractProgressManager manager;
  final bool isTestMode;

  User? _user;

  _MyAppState(this.manager, this.isTestMode);

  @override
  void initState() {
    super.initState();
    if (!isTestMode) {
      _checkAuthState();
    } else {
      setState(() {
        _user = null;
      });
    }
  }

  void _checkAuthState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        _user = user;
      });
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
      initialRoute: isTestMode || _user != null ? '/home' : '/auth',
      routes: {
        '/auth': (context) => AuthPage(progressManager: manager),
        '/home': (context) => MainApp(manager: manager),
        '/upgrades': (context) => UpgradesPage(manager: manager),
        '/bazar': (context) => MarketPage(progressManager: manager),
        '/friends': (context) => FriendsPage(),
        '/profile': (context) => ProfilePage(progressManager: manager),
        '/achivments': (context) => AchievementsPage(),
        '/statistics': (context) => StatisticsPage(state: manager.getState())
      },
    );
  }
}

class MainApp extends StatefulWidget {
  final AbstractProgressManager manager;

  const MainApp({required this.manager, super.key});

  @override
  _MainAppState createState() => _MainAppState(manager);
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;
  final AbstractProgressManager manager;
  late Timer _timer;

  _MainAppState(this.manager);

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        manager.getState().increase(manager.getState().calcBread());
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  List<Widget> pages() {
    return [
      MyHomePage(title: 'NanTap', manager: manager),
      UpgradesPage(manager: manager),
      MarketPage(progressManager: manager),
      FriendsPage(),
      ProfilePage(progressManager: manager),
    ];
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/upgrades');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/bazar');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/friends');
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
      default:
        break;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: pages(),
      ),
      bottomNavigationBar: Footer(
        selectedIndex: _selectedIndex,
      ),
    );
  }
}
  