import 'package:flutter/material.dart';
import 'package:nantap/components/footer.dart';
import 'package:nantap/progress/interfaces.dart';
import 'package:nantap/progress/company.dart';

class MarketPage extends StatelessWidget {
  final AbstractProgressManager progressManager;

  const MarketPage({required this.progressManager, super.key});

  @override
  Widget build(BuildContext context) {
    final state = progressManager.getState();

    return Scaffold(
      backgroundColor: const Color(0xFF07223C),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Market'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: state.companies.length,
                itemBuilder: (context, index) {
                  final company = state.companies[index];
                  return CompanyCard(company: company);
                },
              ),
            ),
            ElevatedButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => CreateBakeryPopup(progressManager: progressManager),
              ),
              child: const Text('Создать пекарню в другом месте'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Footer(
        selectedIndex: 4,
      ),
    );
  }
}

class CompanyCard extends StatelessWidget {
  final Company company;

  const CompanyCard({required this.company, super.key});

  @override
  Widget build(BuildContext context) {
    final profit = company.breadEarned();

    return Card(
      color: Colors.white10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Филиал: ${company.branches.length} объектов',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            Text(
              'Прибыль в час: ${profit.toStringAsFixed(1)} монет',
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateBakeryPopup extends StatefulWidget {
  final AbstractProgressManager progressManager;

  const CreateBakeryPopup({required this.progressManager, Key? key}) : super(key: key);

  @override
  State<CreateBakeryPopup> createState() => _CreateBakeryPopupState();
}

class _CreateBakeryPopupState extends State<CreateBakeryPopup> {
  int bakeryCount = 1;

  void _increment() {
    setState(() {
      bakeryCount++;
    });
  }

  void _decrement() {
    setState(() {
      if (bakeryCount > 1) bakeryCount--;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.progressManager.getState();
    final costPerBakery = 9403.0; // Example cost
    final totalCost = costPerBakery * bakeryCount;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: const Color(0xFF0A3A5E),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Пекарня в новом месте',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Цена за пекарню:', style: TextStyle(color: Colors.white70)),
                Text('$costPerBakery монет', style: const TextStyle(color: Colors.white)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Количество:', style: TextStyle(color: Colors.white70)),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove, color: Colors.white),
                      onPressed: _decrement,
                    ),
                    Text('$bakeryCount', style: const TextStyle(color: Colors.white)),
                    IconButton(
                      icon: const Icon(Icons.add, color: Colors.white),
                      onPressed: _increment,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Общая стоимость:', style: TextStyle(color: Colors.white70)),
                Text('$totalCost монет', style: const TextStyle(color: Colors.white)),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (state.decrease(totalCost)) {
                  widget.progressManager.saveProgress();
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Недостаточно средств!')),
                  );
                }
              },
              child: const Text('Создать'),
            ),
          ],
        ),
      ),
    );
  }
}