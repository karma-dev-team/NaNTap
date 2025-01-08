import 'package:flutter/material.dart';
import 'package:nantap/progress/state.dart';

class StatisticsPage extends StatelessWidget {
  final GlobalState state;

  const StatisticsPage({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A2E47),
        title: const Text('Статистика'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/profile');
          },
        ),
      ),
      body: Container(
        color: const Color(0xFF0A2E47),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(10.0),
                children: [
                  _buildStatisticCard('Уровень', state.level.toString()),
                  _buildStatisticCard('Количество хлеба', state.getAmountShortened()),
                  _buildStatisticCard('Сила нажатия', state.calcTapStrengthBoost().toStringAsFixed(2)),
                  _buildStatisticCard('Достижения', "${state.achievements.length} / ${state.achievements.length + 1}"),
                  _buildStatisticCard('Общее производство хлеба/сек', state.calcBread().toStringAsFixed(2)),
                  _buildStatisticCard('Количество улучшений', state.upgrades.length.toString()),
                  _buildStatisticCard('Количество компаний', state.companies.length.toString()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticCard(String title, String value) {
    return Card(
      color: const Color(0xFF153B5F),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Icon(Icons.bar_chart, color: Colors.white),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Text(
          value,
          style: const TextStyle(
            color: Colors.orange,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
