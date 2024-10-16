import 'package:flutter/material.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Пригласите друзей!"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Заголовок
            const Text(
              'Вы и ваш друг получите бонусы',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),

            // Кнопки приглашения друзей
            Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  InviteFriendButton(text: 'Пригласите друга', bonus: '+2 за каждого друга'),
                  const SizedBox(height: 10),
                  InviteFriendButton(text: 'Пригласите друга больше двух', bonus: '+3 за каждого друга'),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Заглушка для получения реферальной ссылки
                      print('Получить реферальную ссылку');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple, // цвет кнопки
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: const Text('Получить реферальную ссылку'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Список друзей
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Список ваших друзей',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    // Заглушка для обновления списка друзей
                    print('Обновить список друзей');
                  },
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  FriendTile(name: 'Ersultan gopnik'),
                  // Добавьте больше друзей сюда, если нужно
                  // FriendTile(name: 'Friend 2'),
                  // FriendTile(name: 'Friend 3'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Кнопка для приглашения друга
class InviteFriendButton extends StatelessWidget {
  final String text;
  final String bonus;

  const InviteFriendButton({
    Key? key,
    required this.text,
    required this.bonus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.blue[600],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          Text(
            bonus,
            style: const TextStyle(color: Colors.orange, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

// Виджет для отображения друзей
class FriendTile extends StatelessWidget {
  final String name;

  const FriendTile({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.person, size: 36, color: Colors.black),
      title: Text(name),
      onTap: () {
        // Заглушка для нажатия на друга
        print('Открыть профиль $name');
      },
    );
  }
}
