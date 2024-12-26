import 'package:flutter/material.dart';
import 'package:nantap/components/footer.dart';

class MarketPage extends StatelessWidget {
  const MarketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF07223C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1D466C),
        title: const Text(
          'Филиалы',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Верхняя часть с филиалами
          Container(
            padding: const EdgeInsets.all(8.0),
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3, // Количество филиалов
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: BranchCard(
                    location: index == 0 ? "Япония" : index == 1 ? "США" : "Африка",
                    profit: 12200 + index * 300, // Пример прибыли
                    level: 13,
                    rating: 96,
                  ),
                );
              },
            ),
          ),
          // Разделение
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Детализация филиала
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0A3A5E),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Филиал в Японии',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InfoTile(label: 'Заработок в час', value: '1.61K'),
                            InfoTile(label: 'Бонус к этапам', value: '+100'),
                            InfoTile(label: 'Убытки в час', value: '0'),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Создание пекарни
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFCD8032),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          child: const Text(
                            'Создать пекарню в другом месте',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Карточки улучшений
                  ...List.generate(
                    4,
                    (index) => BakeryUpgradeCard(
                      title: index == 0
                          ? "Пекарь"
                          : index == 1
                              ? "Пекарь-кондитер"
                              : index == 2
                                  ? "Пекарный аппарат"
                                  : "Супер пекарь",
                      count: 10,
                      profit: '156.92K',
                      cost: 25,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const Footer(
        selectedIndex: 4,
      ),
    );
  }
}

class BranchCard extends StatelessWidget {
  final String location;
  final int profit;
  final int level;
  final int rating;

  const BranchCard({
    super.key,
    required this.location,
    required this.profit,
    required this.level,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1A3D5C),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Филиал в $location',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Уровень: $level',
              style: const TextStyle(color: Colors.white70),
            ),
            Text(
              'Рейтинг: $rating%',
              style: const TextStyle(color: Colors.white70),
            ),
            Text(
              'Прибыль: $profit монет/ч',
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final String label;
  final String value;

  const InfoTile({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class BakeryUpgradeCard extends StatelessWidget {
  final String title;
  final int count;
  final String profit;
  final int cost;

  const BakeryUpgradeCard({
    super.key,
    required this.title,
    required this.count,
    required this.profit,
    required this.cost,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF0A3A5E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12.0),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        subtitle: Text('Прибыль: $profit', style: const TextStyle(color: Colors.white70)),
        trailing: Column(
          children: [
            Text('10x $cost', style: const TextStyle(color: Colors.white)),
            const Text('монет', style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}
