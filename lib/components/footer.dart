import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  final int selectedIndex;

  const Footer({
    super.key,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/home');
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/upgrades');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/bazar');
            break;
          case 3:
            Navigator.pushReplacementNamed(context, '/friends');
            break;
          case 4:
            Navigator.pushReplacementNamed(context, '/profile');
            break;
        }
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.white,
      backgroundColor: Colors.blueGrey[800],
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Домой',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.construction),
          label: 'Улучшения',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_basket),
          label: 'Рынок',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Друзья',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Профиль',
        ),
      ],
    );
  }
}
