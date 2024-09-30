import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: 'NaNTap'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: prefer_const_constructors
      backgroundColor: Color(0xFF07223C),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$_counter',
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                    fontSize: 50.0,  
                    fontWeight: FontWeight.bold,  
                    color: Colors.white,  
                  ),
                ),
                const SizedBox(width: 10),  
                Image.asset(
                  'assets/image/coin.png',  
                  width: 50.0,  
                  height: 50.0,
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 200.0,
              height: 200.0,
              child: FloatingActionButton(
                onPressed: _incrementCounter,
                tooltip: '',
                backgroundColor: Colors.orange,
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: Image.asset('assets/image/clicker_logo.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
