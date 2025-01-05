import 'package:flutter/material.dart';
import 'package:nantap/progress/interfaces.dart';

class CompaniesComponent extends StatelessWidget {
  final AbstractProgressManager progressManager;
  

  const CompaniesComponent({
    super.key,
    required this.progressManager,
  });

  @override
  Widget build(BuildContext context) {
    final state = progressManager.getState(); // Получаем состояние через переданный менеджер
    final companies = state.companies;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: companies.map((company) {
          final profitPerHour = company.breadEarned(); // Расчет прибыли в час
          final change = profitPerHour * 0.5; // Пример изменения (50%)
          final rating = (profitPerHour / 100).clamp(0, 100); // Пример рейтинга

          return Container(
            width: 200,
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color(0xFF1D466C),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  company.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'lvl 1', // change 
                      style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Рейтинг',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${(rating * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Profit per hour',
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 12,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              profitPerHour.toStringAsFixed(1),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Image.asset(
                              'assets/image/coin.png',
                              width: 16,
                              height: 16,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Изменение',
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 12,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '+${change.toStringAsFixed(1)}',
                              style: const TextStyle(
                                color: Colors.greenAccent,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Image.asset(
                              'assets/image/coin.png',
                              width: 16,
                              height: 16,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
