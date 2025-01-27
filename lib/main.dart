import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nantap/firebase_options.dart';
import 'package:nantap/pages/acievments.dart';
import 'package:nantap/pages/settings.dart';
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
import 'package:nantap/progress/upgradesList.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Helper class for local storage using shared_preferences
class LocalStorage {
  static const String userIdKey = 'userId';

  // Save the userId locally
  static Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userIdKey, userId);
  }

  // Load the userId from local storage
  static Future<String?> loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  // Clear the userId from local storage
  static Future<void> clearUserId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(userIdKey);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Load the locally stored userId
  String? userId = await LocalStorage.loadUserId();

  // Initialize storage and progress manager
  var storage = JsonStorage();
  var achievementManager = AchievmentManager(storage);

  await storage.setup();

  var progressManager = ProgressManager(storage, achievementManager);

  setupCompaniesData(progressManager);
  setupUpgradesRegistry(progressManager.getUpgradesRegistry());

  // Pass the userId into the app
  runApp(MyApp(progressManager: progressManager, userId: userId, isTestMode: userId == null));
}

class MyApp extends StatefulWidget {
  final AbstractProgressManager progressManager;
  final String? userId; // Optional userId passed into the app
  final bool isTestMode;

  const MyApp({
    required this.progressManager,
    this.userId,
    required this.isTestMode,
    super.key,
  });

  @override
  _MyAppState createState() => _MyAppState(progressManager, userId, isTestMode);
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final AbstractProgressManager manager;
  final String? userId;
  final bool isTestMode;

  User? _firebaseUser;

  _MyAppState(this.manager, this.userId, this.isTestMode);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    if (!isTestMode) {
      _checkAuthState();
    } else {
      setState(() {
        _firebaseUser = null;
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.inactive || state == AppLifecycleState.detached) {
      _saveProgressData();
    }
  }

  Future<void> _saveProgressData() async {
    try {
      await manager.saveProgress();
      print("Progress saved successfully.");
    } catch (e) {
      print("Error saving progress: $e");
    }
  }

  void _checkAuthState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      setState(() {
        _firebaseUser = user;
      });

      if (user != null) {
        // Save userId locally after successful login
        await LocalStorage.saveUserId(user.uid);
      } else {
        // Clear userId locally after logout
        await LocalStorage.clearUserId();
      }
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
      initialRoute: isTestMode || _firebaseUser != null || userId != null ? '/home' : '/auth',
      routes: {
        '/auth': (context) => AuthPage(progressManager: manager),
        '/home': (context) => MainApp(manager: manager),
        '/upgrades': (context) => UpgradesPage(manager: manager),
        '/bazar': (context) => MarketPage(progressManager: manager),
        '/friends': (context) => FriendsPage(state: manager.getState()),
        '/profile': (context) => ProfilePage(progressManager: manager),
        '/achivments': (context) => AchievementsPage(),
        '/statistics': (context) => StatisticsPage(state: manager.getState()),
        "/settings": (context) => SettingsPage(manager: manager),
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
      FriendsPage(state: manager.getState()), 
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
