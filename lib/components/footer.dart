import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

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
            Colors.orange,
            true,
            '/', // Маршрут для домашней страницы
          ),
          _buildBottomMenuItem(
            context,
            'Улучшения',
            "assets/image/uparrow.png",
            Colors.white,
            false,
            '/upgrades', // Маршрут для страницы улучшений
          ),
          _buildBottomMenuItem(
            context,
            'Рынок',
            Icons.shopping_basket,
            Colors.white,
            false,
            '/market', // Маршрут для страницы рынка
          ),
          _buildBottomMenuItem(
            context,
            'Друзья',
            Icons.people,
            Colors.white,
            false,
            '/friends', // Маршрут для страницы друзей
          ),
          _buildBottomMenuItem(
            context,
            'Профиль',
            Icons.account_circle,
            Colors.white,
            false,
            '/profile', // Маршрут для страницы профиля
          ),
        ],
      ),
    );
  }

  Widget _buildBottomMenuItem(BuildContext context, String title, icon, Color iconColor, bool isActive, String route) {
    return GestureDetector(
      onTap: () {
        // Переход на указанный маршрут при нажатии
        Navigator.pushNamed(context, route);
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
