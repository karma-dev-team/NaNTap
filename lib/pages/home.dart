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

      // Увеличиваем bufferBread
      state.bufferBread += state.calcTapStrengthBoost(); 

      // Проверяем, если bufferBread достигает стоимости следующего уровня
      if (state.bufferBread >= state.nextLevelPrice()) {
        // Увеличиваем уровень
        state.addLevel(1);

        // Перерасчет стоимости следующего уровня
        state.lvlPrice = (state.level * state.lvlPrice * 1.5).toInt();

        // Увеличиваем tapStrength
        if (state.tapStrength < 10) {
          state.tapStrength += 1;
        } else {
          state.tapStrength += 2;
        }

        // Награда каждые 5 уровней
        if (state.level % 5 == 0) {
          state.addBread(1); // Награда добавляется в breadCount
          _startPassiveIncomeTimer(); // Обновляем таймер пассивного дохода
        }
      }

      // Обновляем основной баланс
      state.breadCount = state.bufferBread;
    });
  }

  void _startPassiveIncomeTimer() {
    _passiveIncome?.cancel();
    _passiveIncome = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        var state = widget.manager.getState();
        state.bufferBread += state.calcBread(); // Пассивный доход
        state.breadCount = state.bufferBread;  // Синхронизация основного баланса
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
                  buildMenuCard('Тапов за тап', '+${state.calcTapStrengthBoost()}', 'assets/image/coin.png', Colors.orange, 120),
                  buildMenuCard('Тапы для уровня', '${state.nextLevelPrice()}', 'assets/image/coin.png', Colors.blue, 120),
                  buildMenuCard('Тапы в секунду', '+${state.calcBread()}', 'assets/image/coin.png', Colors.green, 120),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        'Реальный баланс: ${state.humanize(state.breadCount)}',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                        ),
                      ),
                    ],
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
                          ? (state.breadCount / state.nextLevelPrice()).clamp(0.0, 1.0)
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
