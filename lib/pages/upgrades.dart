import 'package:flutter/material.dart';
import 'package:nantap/components/cardBuilder.dart';
import 'package:nantap/progress/interfaces.dart';
import 'package:nantap/progress/upgrade.dart';

class UpgradesPage extends StatefulWidget {
  final AbstractProgressManager manager;

  const UpgradesPage({super.key, required this.manager});

  @override
  _UpgradesPageState createState() => _UpgradesPageState();
}

class _UpgradesPageState extends State<UpgradesPage> {
  String _selectedAction = 'Купить';
  String _selectedMultiplier = '1x';

  void _handleUpgrade(String upgradeId, int multiplier) {
    setState(() {
      if (_selectedAction == 'Купить') {
        final state = widget.manager.getState();
        final upgrade = widget.manager
            .getUpgradesRegistry()
            .getUpgrades()
            .firstWhere((u) => u.upgradeId == upgradeId);

        // Проверяем, хватает ли средств на покупку множества уровней
        double totalCost = upgrade.levelUpPrice * multiplier;
        if (state.getAmount() >= totalCost) {
          for (int i = 0; i < multiplier; i++) {
            // Увеличиваем уровень апгрейда через менеджер
            widget.manager.levelUpUpgrade(upgradeId, 1);
            // Уменьшаем количество денег в кошельке
            state.decrease(upgrade.levelUpPrice);
          }
        } else {
          // Опционально можно добавить уведомление, если средств недостаточно
          print("Недостаточно средств для покупки.");
        }
      }
      // Здесь можно добавить логику для продажи, если потребуется
    });
  }

  int _getMultiplier() {
    switch (_selectedMultiplier) {
      case '10x':
        return 10;
      case '100x':
        return 100;
      default:
        return 1;
    }
  }

  Widget _buildUpgradeCard(Upgrade upgrade) {
    final state = widget.manager.getState();
    final canAfford = state.getAmount() >= (upgrade.levelUpPrice * _getMultiplier());

    return GestureDetector(
      onTap: canAfford
          ? () {
              _handleUpgrade(upgrade.upgradeId, _getMultiplier());
            }
          : null,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: const Color(0xFF1D466C),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Image.asset(upgrade.imagePath, width: 40, height: 40),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    upgrade.displayName,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'В час: ${upgrade.earn().toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ],
              ),
            ),
            Text(
              (upgrade.levelUpPrice * _getMultiplier()).toStringAsFixed(2),
              style: TextStyle(
                color: canAfford ? Colors.orange : Colors.grey,
                fontSize: 18,
              ),
            ),
            const SizedBox(width: 5),
            Image.asset('assets/image/coin.png', width: 24, height: 24),
          ],
        ),
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
          color: isSelected ? const Color(0xFF25537C) : const Color(0xFF1D466C),
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
          color: isSelected ? const Color(0xFF25537C) : const Color(0xFF1D466C),
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
    final state = widget.manager.getState();
    final upgrades = widget.manager.getUpgradesRegistry().getUpgrades();

    return Scaffold(
      backgroundColor: const Color(0xFF07223C),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Upgrades'),
      ),
      body: ListView(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Баланс: ${state.getAmount().toStringAsFixed(2)}',
                style: const TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      _buildMultiplierButton('1x'),
                      _buildMultiplierButton('10x'),
                      _buildMultiplierButton('100x'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Upgrades List
                SizedBox(
                  height: 400,
                  child: ListView(
                    children: upgrades.map(_buildUpgradeCard).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
