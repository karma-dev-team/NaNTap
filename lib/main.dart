import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:nantap/progress/upgradesList.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var storage = SQLiteStorage();
  var achievementManager = AchievmentManager(storage);

  var progressManager = ProgressManager(storage, achievementManager);

  setupUpgradesRegistry(progressManager.getUpgradesRegistry());

  runApp(MyApp(progressManager: progressManager, isTestMode: false));
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
      // В тестовом режиме пользователь считается авторизованным
      setState(() {
        _user = null; // Пользователь не нужен для тестового режима
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
    if (isTestMode || _user != null) {
      return MaterialApp(
        title: 'NaNTap',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MainApp(manager: manager),
      );
    }

    return MaterialApp(
      title: 'NaNTap',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AuthPage(progressManager: manager),
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
      ProfilePage(progressManager: manager,),
    ];
  }

  void _onItemTapped(int index) {
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
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class AuthPage extends StatefulWidget {
  final AbstractProgressManager progressManager;

  const AuthPage({required this.progressManager, Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState(progressManager);
}

class _AuthPageState extends State<AuthPage> {
  final AbstractProgressManager progressManager;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _AuthPageState(this.progressManager);

  Future<void> _signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign in: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signIn,
              child: const Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
