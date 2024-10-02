import 'package:flutter/material.dart';
import 'dart:async';

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
  double lvlprice = 100;
  int curlvl = 1;
  Timer? _passiveIncome;

  void _incrementCounter() {
    setState(() {
      _counter+= tapstr;

      
      if (_counter >= lvlprice) {
        _counter -= lvlprice;
        lvlprice += (lvlprice * 1.5).toInt();
        curlvl++;

        if (curlvl % 5 == 0) {
          pasprof += 1;  
          _startPassiveIncomeTimer();  
        }

        if (tapstr < 10) {
          tapstr += 1;  
        } else {
          tapstr += 2;  
        }
      }
    });
  }

  void _startPassiveIncomeTimer() {
    _passiveIncome?.cancel(); // Отменяем предыдущий таймер, если он был
    _passiveIncome = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _counter += pasprof;
      });
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Размещаем элементы с учетом нижнего меню
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Info Menu
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMenuCard('Earn per tap', '+$tapstr', 'assets/image/coin.png', Colors.orange, 120),
                  _buildMenuCard('Coins to level up', '$lvlprice', 'assets/image/coin.png', Colors.blue, 120),
                  _buildMenuCard('Profit per second', '+$pasprof', 'assets/image/coin.png', Colors.green, 120),
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
                    'assets/image/coin.png',
                    width: 50.0,
                    height: 50.0,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              // Goal
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // ignore: prefer_const_constructors
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text(
                          'Следующая цель',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 5),
                        // ignore: prefer_const_constructors
                        Icon(
                          Icons.info_outline,
                          color: Colors.grey,
                          size: 18,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    LinearProgressIndicator(
                      value: _counter / lvlprice, // Прогресс
                      backgroundColor: Colors.blueGrey[700], // Цвет заднего фона
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange), // Цвет заполненной части
                      minHeight: 10.0, // Высота полоски
                    ),
                  ],
                ),
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
          
          // Fotter Menu
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: Colors.blueGrey[800],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildBottomMenuItem('Домой', Icons.home, Colors.orange, true),
                _buildBottomMenuItem('Улучшения', "assets/image/uparrow.png", Colors.white, false),
                _buildBottomMenuItem('Рынок', Icons.shopping_basket, Colors.white, false),
                _buildBottomMenuItem('Друзья', Icons.people, Colors.white, false),
                _buildBottomMenuItem('Профиль', Icons.account_circle, Colors.white, false),
              ],
            ),
          ),
        ],
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

  // Podval Builder 228
  Widget _buildBottomMenuItem(String title, icon, Color iconColor, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isActive ? Colors.blueGrey[700] : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: icon is IconData
            ? Icon(
                icon,
                color: iconColor,
                size: 30,
              )
            : Image.asset(
                icon,
                width: 30,
                height: 30,
              ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          // ignore: prefer_const_constructors
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
