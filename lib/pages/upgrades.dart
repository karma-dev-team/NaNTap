import 'package:flutter/material.dart';
import 'package:nantap/components/cardBuilder.dart';
import 'package:nantap/pages/home.dart';

class UpgradesPage extends StatelessWidget {
  final String tapStr;
  final String lvlPrice;
  final String pasProf;

  const UpgradesPage({
    Key? key,
    required this.tapStr,
    required this.lvlPrice,
    required this.pasProf,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final gameData = Provider.of<GameData>(context);

    return Scaffold(
        backgroundColor: const Color(0xFF07223C),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('Upgrade'),
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
                buildMenuCard('Earn per tap', '+$tapStr', 'assets/image/coin.png', Colors.orange, 120),
                buildMenuCard('Coins to level up', '$lvlPrice', 'assets/image/coin.png', Colors.blue, 120),
                buildMenuCard('Profit per second', '+$pasProf', 'assets/image/coin.png', Colors.green, 120),
              ],
            ),
          ],
        ),
      ],
    ));
  }
}
