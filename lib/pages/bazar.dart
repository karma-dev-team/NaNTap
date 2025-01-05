import 'package:flutter/material.dart';
import 'package:nantap/components/companiesList.dart';
import 'package:nantap/components/footer.dart';
import 'package:nantap/progress/company.dart';
import 'package:nantap/progress/interfaces.dart';

class MarketPage extends StatelessWidget {
  final AbstractProgressManager progressManager;

  MarketPage({required this.progressManager});

  @override
  Widget build(BuildContext context) {
    // Получаем компании из прогресс-менеджера
    final companies = progressManager.getState().companies;

    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      appBar: AppBar(
        title: Text('Рынок'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CompaniesComponent(progressManager: progressManager),
            // Список филиалов
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: companies.length,
                itemBuilder: (context, index) {
                  final company = companies[index];
                  return _buildBranchCard(company);
                },
              ),
            ),
            SizedBox(height: 20),

            // Детализация филиала
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade800,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      companies.isNotEmpty ? companies[0].name : 'Филиал',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(height: 16),
                    Expanded(
                      child: Image.asset(
                        'assets/image/bakery_image.png', // Замените на ваш путь к изображению
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Заработок в час: ${_formatProfit(companies.isNotEmpty ? companies[0].breadEarned() : 0.0)}',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Text(
                          'Бонус к тапам: +100', // Фейковое значение
                          style: TextStyle(color: Colors.greenAccent, fontSize: 14),
                        ),
                        Text(
                          'Убытки в час: -60', // Фейковое значение
                          style: TextStyle(color: Colors.redAccent, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

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
      bottomNavigationBar: const Footer(selectedIndex: 2),
    );
  }

  Widget _buildBranchCard(Company company) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue.shade800,
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
              dropdownColor: Colors.blue.shade800,
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
