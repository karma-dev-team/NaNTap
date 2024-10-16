import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const Footer({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.blueGrey[800],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildBottomMenuItem(
            context,
            'Домой',
            Icons.home,
            selectedIndex == 0 ? Colors.orange : Colors.white,
            selectedIndex == 0,
            0, // Индекс для домашней страницы
          ),
          _buildBottomMenuItem(
            context,
            'Улучшения',
            "assets/image/uparrow.png",
            selectedIndex == 1 ? Colors.orange : Colors.white,
            selectedIndex == 1,
            1, // Индекс для страницы улучшений
          ),
          _buildBottomMenuItem(
            context,
            'Рынок',
            Icons.shopping_basket,
            selectedIndex == 2 ? Colors.orange : Colors.white,
            selectedIndex == 2,
            2, // Индекс для страницы рынка
          ),
          _buildBottomMenuItem(
            context,
            'Друзья',
            Icons.people,
            selectedIndex == 3 ? Colors.orange : Colors.white,
            selectedIndex == 3,
            3, // Индекс для страницы друзей
          ),
          _buildBottomMenuItem(
            context,
            'Профиль',
            Icons.account_circle,
            selectedIndex == 4 ? Colors.orange : Colors.white,
            selectedIndex == 4,
            4, // Индекс для страницы профиля
          ),
        ],
      ),
    );
  }

  Widget _buildBottomMenuItem(BuildContext context, String title, icon, Color iconColor, bool isActive, int index) {
    return GestureDetector(
      onTap: () {
        // Передаем индекс в родительский виджет
        onItemTapped(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isActive ? Colors.blueGrey[700] : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: icon is IconData
                ? Icon(icon, color: iconColor, size: 30)
                : Image.asset(icon, width: 30, height: 30),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
