
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:nantap/components/footer.dart';
import 'package:nantap/components/tapper.dart';

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
      _counter += tapstr;

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
    _passiveIncome?.cancel();
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Следующая цель',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.info_outline,
                          color: Colors.grey,
                          size: 18,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    LinearProgressIndicator(
                      value: _counter / lvlprice,
                      backgroundColor: Colors.blueGrey[700],
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
                      minHeight: 10.0,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Tapper(onTap: _incrementCounter),
            ],
          ),
          const Footer(),
        ],
      ),
    );
  }

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
