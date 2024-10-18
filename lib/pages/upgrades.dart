import 'package:flutter/material.dart';
import 'package:nantap/components/cardBuilder.dart';

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
  String _promoMessage = '';
  String _selectedAction = 'Купить'; // Для отслеживания выбранной кнопки
  String _selectedMultiplier = '1x'; // Для отслеживания выбранного множителя

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

  Widget buildUpgradeCard(String title, String profitPerHour, String imagePath, String price) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1D466C),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image.asset(imagePath, width: 40, height: 40),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  'в час: $profitPerHour',
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            price,
            style: const TextStyle(color: Colors.orange, fontSize: 18),
          ),
          const SizedBox(width: 5),
          Image.asset('assets/image/coin.png', width: 24, height: 24),
        ],
      ),
    );
  }

  Widget _buildActionButton(String text) {
    bool isSelected = _selectedAction == text;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAction = text;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF25537C) : Color(0xFF1D466C),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(color: isSelected ? Colors.white : Colors.white54),
        ),
      ),
    );
  }

  Widget _buildMultiplierButton(String text) {
    bool isSelected = _selectedMultiplier == text;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMultiplier = text;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF25537C) : Color(0xFF1D466C),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(color: isSelected ? Colors.white : Colors.white54),
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
        title: const Text('Upgrades'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Stats Row using buildMenuCard
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildMenuCard('Earn per tap', '+${widget.tapStr}', 'assets/image/coin.png', Colors.orange, 120),
                buildMenuCard('Coins to level up', '${widget.lvlPrice}', 'assets/image/coin.png', Colors.blue, 120),
                buildMenuCard('Profit per second', '+${widget.pasProf}', 'assets/image/coin.png', Colors.green, 120),
              ],
            ),
            const SizedBox(height: 16),
            // Promo Code Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              decoration: BoxDecoration(
                color: const Color(0xFF1D466C),
                borderRadius: BorderRadius.circular(12),
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
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: _checkPromoCode,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _promoMessage.isEmpty ? 'Применить' : _promoMessage,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Buy/Sell and Multipliers Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF1D466C),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton('Купить'),
                  _buildActionButton('Продать'),
                  _buildMultiplierButton('1x'),
                  _buildMultiplierButton('10x'),
                  _buildMultiplierButton('100x'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Upgrades List
            Expanded(
              child: ListView(
                children: [
                  buildUpgradeCard('Пекарь', '1.61K', 'assets/image/upg1.png', '156.92K'),
                  buildUpgradeCard('Пекарь-кондитер', '1.61K', 'assets/image/upg2.png', '156.92K'),
                  buildUpgradeCard('Пекарный аппарат', '1.61K', 'assets/image/upg3.png', '156.92K'),
                  buildUpgradeCard('Супер пекарь', '1.61K', 'assets/image/upg4.png', '156.92K'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
