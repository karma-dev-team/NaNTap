import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  final Function(String) onMenuItemTapped;

  const Footer({Key? key, required this.onMenuItemTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.blueGrey[800],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildBottomMenuItem('Домой', Icons.home, Colors.orange, true),
          _buildBottomMenuItem('Улучшения', "assets/image/uparrow.png", Colors.white, false),
          _buildBottomMenuItem('Рынок', Icons.shopping_basket, Colors.white, false),
          _buildBottomMenuItem('Друзья', Icons.people, Colors.white, false),
          _buildBottomMenuItem('Профиль', Icons.account_circle, Colors.white, false),
        ],
      ),
    );
  }

  Widget _buildBottomMenuItem(String title, icon, Color iconColor, bool isActive) {
    return GestureDetector(
      onTap: () {
        onMenuItemTapped(title);
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
