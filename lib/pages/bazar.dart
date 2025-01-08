import 'package:flutter/material.dart';
import 'package:nantap/components/companiesList.dart';
import 'package:nantap/components/footer.dart';
import 'package:nantap/progress/company.dart';
import 'package:nantap/progress/interfaces.dart';
import 'package:nantap/progress/upgrade.dart';

class MarketPage extends StatelessWidget {
  final AbstractProgressManager progressManager;

  MarketPage({required this.progressManager});
  @override
  Widget build(BuildContext context) {
    final companies = progressManager.getState().companies;
    final upgrades = progressManager.getUpgradesRegistry().getUpgrades().toList();

    return Scaffold(
      backgroundColor: const Color(0xFF07223C),
      appBar: AppBar(
        title: Text('Рынок'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CompaniesComponent(progressManager: progressManager),
              SizedBox(height: 20),

              // Детализация филиала
              companies.isNotEmpty
                  ? Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1D466C),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Название компании
                    Text(
                      companies[0].name,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(height: 16),

                    // Информация о доходах и бонусах
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Заработок в час: ${_formatProfit(companies[0].breadEarned())}',
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        const Text(
                          'Бонус к тапам: +100', // Замените на реальное значение
                          style: TextStyle(color: Colors.greenAccent, fontSize: 14),
                        ),
                        const Text(
                          'Убытки в час: -60', // Замените на реальное значение
                          style: TextStyle(color: Colors.redAccent, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              )
                  : const Center(
                child: Text(
                  'Нет выбранной компании',
                  style: TextStyle(color: Colors.white70, fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),

              // Меню апгрейдов
              if (companies.isNotEmpty) _buildUpgradeMenu(companies[0], upgrades),

              // Кнопка создания нового филиала
              ElevatedButton(
                onPressed: () {
                  _showNewBranchModal(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                ),
                child: Text(
                  'Создать пекарню в другом месте',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Footer(selectedIndex: 2),
    );
  }

  Widget _buildUpgradeMenu(Company selectedCompany, List<Upgrade> upgrades) {
    return Padding(
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
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: upgrades.isNotEmpty
                ? upgrades.map((upgrade) {
              return _buildUpgradeCard(upgrade, selectedCompany);
            }).toList()
                : [
              Center(
                child: Text(
                  'Нет доступных улучшений',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUpgradeCard(Upgrade upgrade, Company company) {
    return Card(
      color: const Color(0xFF1D466C),
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(
          upgrade.displayName,
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          'Цена: ${upgrade.cost} хлеба\nУровень: ${upgrade.level}',
          style: TextStyle(color: Colors.white70),
        ),
        trailing: ElevatedButton(
          onPressed: () {
            // Обработка покупки апгрейда для текущей компании
            progressManager.levelUpUpgrade(upgrade.upgradeId, 1);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text('Улучшить'),
        ),
      ),
    );
  }

  Widget _buildActionButton(String label) {
    return ElevatedButton(
      onPressed: () {
        // Обработка кнопки действия
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(label, style: TextStyle(color: Colors.white)),
    );
  }

  Widget _buildMultiplierButton(String label) {
    return ElevatedButton(
      onPressed: () {
        // Обработка выбора множителя
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade700,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(label, style: TextStyle(color: Colors.white)),
    );
  }

  Widget _buildBranchCard(Company company) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF1D466C),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            company.name,
            style: TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            'Уровень: ${company.branches.length}', // Используем количество филиалов как уровень
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          Text(
            'Рейтинг: 96%', // Фейковое значение
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          Text(
            'Прибыль: ${_formatProfit(company.breadEarned())}к/ч',
            style: TextStyle(color: Colors.greenAccent, fontSize: 14),
          ),
          Text(
            'Расходы: -2.2к/ч', // Фейковое значение
            style: TextStyle(color: Colors.redAccent, fontSize: 14),
          ),
        ],
      ),
    );
  }

  String _formatProfit(double profit) {
    if (profit > 1000) {
      return '${(profit / 1000).toStringAsFixed(1)}К';
    }
    return profit.toStringAsFixed(1);
  }

  void _showNewBranchModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1D466C),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Создать новый филиал',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              dropdownColor: const Color(0xFF1D466C),
              items: ['Япония', 'США', 'Казахстан']
                  .map((region) => DropdownMenuItem<String>(
                value: region,
                child: Text(
                  region,
                  style: TextStyle(color: Colors.white),
                ),
              ))
                  .toList(),
              onChanged: (value) {},
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blue.shade700,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Выберите регион',
                hintStyle: TextStyle(color: Colors.white70),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Подтвердить',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
