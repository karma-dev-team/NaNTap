import 'package:flutter/material.dart';
import 'package:nantap/components/footer.dart';
import 'package:nantap/progress/referallManager.dart';
import 'package:nantap/progress/state.dart';

class FriendsPage extends StatelessWidget {
  final ReferralManager referralManager = ReferralManager();
  final GlobalState state; // Use your existing GlobalState

  FriendsPage({super.key, required this.state});

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
      body: FutureBuilder<List<String>>(
        future: referralManager.getInvitedFriends(state),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final invitedFriends = snapshot.data!;

          return Container(
            color: const Color(0xFF07223C), // Dark background
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
                ElevatedButton(
                  onPressed: () async {
                    String referralCode = await referralManager.generateReferralCode(state);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Ваш реферальный код: $referralCode')),
                    );
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
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Введите реферальный код',
                    labelStyle: TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Color(0xFF14233C),
                    border: OutlineInputBorder(),
                  ),
                  style: const TextStyle(color: Colors.white),
                  onSubmitted: (referralCode) async {
                    try {
                      await referralManager.processReferralCode(referralCode, state);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Реферальный код принят!')),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Ошибка: ${e.toString()}')),
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  'Список ваших друзей',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: invitedFriends.length,
                    itemBuilder: (context, index) {
                      return FriendTile(name: invitedFriends[index]);
                    },
                  ),
                ),
              ],
            ),
          );
        },
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
