import 'package:flutter/material.dart';
import 'package:nantap/components/cardBuilder.dart';
import 'package:nantap/pages/home.dart';

class UpgradesPage extends StatefulWidget {
  final String tapStr;
  final String lvlPrice;
  final String pasProf;

  const UpgradesPage({
    super.key,
    required this.tapStr,
    required this.lvlPrice,
    required this.pasProf,
  });

  @override
  _UpgradesPageState createState() => _UpgradesPageState();
}

class _UpgradesPageState extends State<UpgradesPage> {
  final TextEditingController _promoController = TextEditingController();
  String _promoMessage = ''; // Сообщение для результата проверки промокода

  // Метод для проверки промокода
  void _checkPromoCode() {
    if (_promoController.text == "ilovenan") {
      setState(() {
        _promoMessage = '+2 000 000';
      });
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _promoMessage = '';
        });
      });
    } else {
      setState(() {
        _promoMessage = 'Invalid promo code';
      });
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _promoMessage = '';
        });
      });
    }
  }

  // Виджет для создания карты улучшения
  Widget buildUpgradeCard(String title, String profitPerHour, String imagePath, String level, String price) {
    return Card(
      color: const Color(0xFF144572),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(imagePath, width: 50, height: 50),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      'Profit per hour: $profitPerHour',
                      style: const TextStyle(color: Colors.white54, fontSize: 14),
                    ),
                  ],
                ),
                const Spacer(),
                const Text(
                  '1x',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Lvl $level',
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
                Row(
                  children: [
                    Text(
                      price,
                      style: const TextStyle(color: Colors.orange, fontSize: 16),
                    ),
                    const SizedBox(width: 5),
                    Image.asset('assets/image/coin.png', width: 24, height: 24),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF07223C),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Upgrade'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildMenuCard(
                    'Earn per tap',
                    '+${widget.tapStr}',
                    'assets/image/coin.png',
                    Colors.orange,
                    120,
                  ),
                  buildMenuCard(
                    'Coins to level up',
                    '${widget.lvlPrice}',
                    'assets/image/coin.png',
                    Colors.blue,
                    120,
                  ),
                  buildMenuCard(
                    'Profit per second',
                    '+${widget.pasProf}',
                    'assets/image/coin.png',
                    Colors.green,
                    120,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Полоска с промокодом
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF144572),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _promoController,
                          decoration: const InputDecoration(
                            hintText: 'Промокод',
                            hintStyle: TextStyle(color: Colors.white54),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(16.0),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 8.0),
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: GestureDetector(
                          onTap: _checkPromoCode,
                          child: const Text(
                            'Применить',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Полоска "Купить", "Продать"
              Container(
                color: const Color(0xFF144572),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Купить',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Продать',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        '1x',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        '10x',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        '100x',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        '1000x',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),

              // Секция для покупки улучшений
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Две колонки
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.4, // Настроено для похожего вида
                  ),
                  itemCount: 6, // Количество карт
                  itemBuilder: (context, index) {
                    if (index % 2 == 0) {
                      return buildUpgradeCard(
                        'Top 10 cmc pairs',
                        '1.61K',
                        'assets/image/top10.png',
                        '13',
                        '156.92K',
                      );
                    } else {
                      return buildUpgradeCard(
                        'Mene coins',
                        '2.2K',
                        'assets/image/mene.png',
                        '13',
                        '312.2K',
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 60), // Отступ под футер
            ],
          ),
        ),
      ),
    );
  }
}
