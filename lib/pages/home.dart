import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nantap/components/cardBuilder.dart';
import 'package:nantap/components/tapper.dart';
import 'package:nantap/progress/interfaces.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  final AbstractProgressManager manager;

  const MyHomePage({super.key, required this.manager, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer? _passiveIncome;

  @override
  void initState() {
    super.initState();
    _startPassiveIncomeTimer();
  }

  @override
  void dispose() {
    _passiveIncome?.cancel();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      var state = widget.manager.getState();
      state.increase(state.tapStrength.toDouble());

      if (state.getAmount() >= state.nextLevelPrice()) {
        state.decrease(state.nextLevelPrice());
        state.addLevel(1);

        if (state.level % 5 == 0) {
          widget.manager.getState().addBread(1);
          _startPassiveIncomeTimer();
        }

        if (state.tapStrength < 10) {
          state.tapStrength += 1;
        } else {
          state.tapStrength += 2;
        }
      }
    });
  }

  void _startPassiveIncomeTimer() {
    _passiveIncome?.cancel();
    _passiveIncome = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        widget.manager.getState().increase(widget.manager.getState().calcBread());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var state = widget.manager.getState();

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
                  buildMenuCard('Earn per tap', '+${state.tapStrength}', 'assets/image/coin.png', Colors.orange, 120),
                  buildMenuCard('Coins to level up', '${state.nextLevelPrice()}', 'assets/image/coin.png', Colors.blue, 120),
                  buildMenuCard('Profit per second', '+${state.calcBread()}', 'assets/image/coin.png', Colors.green, 120),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${state.getAmount()}',
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
                      value: state.nextLevelPrice() > 0
                          ? (state.getAmount() / state.nextLevelPrice()).clamp(0.0, 1.0)
                          : 0.0,
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
        ],
      ),
    );
  }
}
