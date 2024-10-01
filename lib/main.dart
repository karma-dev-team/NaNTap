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
  double tapstr = 1;
  double pasprof = 0;
  double lvlprice = 1000;

  void _incrementCounter() {
    setState(() {
      _counter+= tapstr;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF07223C),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Info Menu
            const SizedBox(height: 20),  
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMenuCard('Earn per tap', '+$tapstr', 'assets/image/nancoin.png', Colors.orange, 150),
                _buildMenuCard('Coins to level up', '$lvlprice', 'assets/image/nancoin.png', Colors.blue, 150),
                _buildMenuCard('Profit per hour', '+$pasprof', 'assets/image/nancoin.png', Colors.green, 150),
              ],
            ),
            const SizedBox(height: 40),  
            
            // Coin counter
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$_counter',
                  style: const TextStyle(
                    fontSize: 50.0,  
                    fontWeight: FontWeight.bold,  
                    color: Colors.white,  
                  ),
                ),
                const SizedBox(width: 10),  
                Image.asset(
                  'assets/image/nancoin.png',  
                  width: 50.0,  
                  height: 50.0,
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Tap tap tap
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

  // info card builder
  Widget _buildMenuCard(String title, String value, String iconPath, Color color, double width) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: width,
      decoration: BoxDecoration(
        color: Colors.blueGrey[800],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(color: color, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 2.5),
              Image.asset(
                iconPath,
                width: 20,
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
