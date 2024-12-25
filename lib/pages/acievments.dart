import 'package:flutter/material.dart';

class AchievementsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A2E47),
        title: const Text('Достижения'),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF153B5F),
                  prefixIcon: const Icon(Icons.search, color: Colors.orange),
                  hintText: 'Поиск ...',
                  hintStyle: const TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Card(
                    color: const Color(0xFF153B5F),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        color: Colors.orange,
                        child: const Icon(Icons.emoji_events, color: Colors.white),
                      ),
                      title: const Text(
                        'Сосать и лежать',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: const Text(
                        'Это достижение есть у 25% игроков',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
