import 'package:flutter/material.dart';
import 'package:nantap/components/footer.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D466C),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "Друзья",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        color: const Color(0xFF07223C), // Тёмный фон
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Пригласите друзей!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                'Вы и ваш друг получите бонусы',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white70,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF14233C),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const InviteFriendButton(
                    text: 'Пригласите друга',
                    bonus: '+2 За друга',
                    imagePath: 'assets/image/coin.png',
                  ),
                  const SizedBox(height: 10),
                  const InviteFriendButton(
                    text: 'Пригласите еще друга',
                    bonus: '+3 За друга',
                    imagePath: 'assets/image/coin.png',
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      print('Получить реферальную ссылку');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7F6BFF),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Получить реферальную ссылку',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Список ваших друзей',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh, color: Colors.white70),
                  onPressed: () {
                    print('Обновить список друзей');
                  },
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: const [
                  FriendTile(name: 'Ersultan gopnik'),
                  // Добавьте больше друзей сюда, если нужно
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      print('Пригласить друзей');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFCD8032),
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 8,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_add, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          'Пригласить друзей',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    print('Скопировать ссылку');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFCD8032),
                    padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 8,
                  ),
                  child: const Icon(Icons.copy, color: Colors.white),
                ),
              ],
            ),
          ),
          const Footer(selectedIndex: 3), // Укажите текущий индекс страницы
        ],
      ),
    );
  }
}


// Кнопка для приглашения друга
class InviteFriendButton extends StatelessWidget {
  final String text;
  final String bonus;
  final String imagePath; // Путь к изображению

  const InviteFriendButton({
    super.key,
    required this.text,
    required this.bonus,
    required this.imagePath, // Обязательный параметр для картинки
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A3A59),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(imagePath, width: 24, height: 24), // Отображаем изображение
              const SizedBox(width: 10),
              Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
          Text(
            bonus,
            style: const TextStyle(color: Colors.orangeAccent, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

// Виджет для отображения друзей
class FriendTile extends StatelessWidget {
  final String name;

  const FriendTile({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.person, size: 36, color: Colors.black),
      title: Text(name, style: const TextStyle(color: Colors.white70,),),
      onTap: () {
        // Заглушка для нажатия на друга
        print('Открыть профиль $name');
      },
    );
  }
}
