import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = "PikoUsername"; // Имя пользователя
  String email = "piko@example.com"; // Email пользователя
  String companyName = "Ohno corp"; // Название компании
  bool isEditingName = false;
  bool isEditingEmail = false;
  bool isEditingCompany = false;

  // Переменная для хранения ошибки email
  String? emailError;

  // Регулярное выражение для проверки email
  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  // Метод для валидации email
  void validateEmail(String newEmail) {
    if (emailRegExp.hasMatch(newEmail)) {
      setState(() {
        emailError = null; // Email корректный, убираем ошибку
        email = newEmail; // Сохраняем новый email
        isEditingEmail = false;
      });
    } else {
      setState(() {
        emailError = 'Неверный формат email'; // Устанавливаем ошибку
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF07223C),
        title: const Text("Профиль"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          color: const Color(0xFF07223C), // Задний фон основной области
          child: Column(
            children: [
              // Блок с аватаром и ником, занимающий 100% ширины экрана
              Container(
                width: MediaQuery.of(context).size.width, // 100% ширина экрана
                color: const Color(0xFF153B5F), // Фон для аватара и ника
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Имя пользователя (ник)
                    Text(
                      username,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Расширяющийся контейнер с информацией
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width, // 100% ширина экрана
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF153B5F), // Фон для информации о профиле
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileInfoRow(
                          icon: Icons.person,
                          label: "Имя", // Имя пользователя
                          value: username,
                          isEditing: isEditingName,
                          onSave: (newValue) {
                            setState(() {
                              username = newValue;
                              isEditingName = false;
                            });
                          },
                          onEdit: () {
                            setState(() {
                              isEditingName = true;
                            });
                          },
                        ),
                        // Email с валидацией
                        ProfileInfoRow(
                          icon: Icons.email,
                          label: "Email", // Email пользователя
                          value: email,
                          isEditing: isEditingEmail,
                          errorText: emailError, // Ошибка в email
                          onSave: validateEmail, // Метод для валидации email
                          onEdit: () {
                            setState(() {
                              isEditingEmail = true;
                            });
                          },
                        ),
                        ProfileInfoRow(
                          icon: Icons.business,
                          label: "Имя компании", // Название компании
                          value: companyName,
                          isEditing: isEditingCompany,
                          onSave: (newValue) {
                            setState(() {
                              companyName = newValue;
                              isEditingCompany = false;
                            });
                          },
                          onEdit: () {
                            setState(() {
                              isEditingCompany = true;
                            });
                          },
                        ),
                        ProfileInfoRow(
                          icon: Icons.emoji_events,
                          label: "Достижения",
                          value: "10/124",
                          isNavigable: true,
                        ),
                        const SizedBox(height: 20),
                        ProfileNavigationItem(
                          icon: Icons.settings,
                          label: "Настройки",
                        ),
                        ProfileNavigationItem(
                          icon: Icons.bar_chart,
                          label: "Статистика",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isNavigable;
  final bool isEditing;
  final Function(String)? onSave;
  final Function()? onEdit;
  final String? errorText; // Поле для ошибки

  const ProfileInfoRow({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
    this.isNavigable = false,
    this.isEditing = false,
    this.onSave,
    this.onEdit,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.orange),
          const SizedBox(width: 10),
          Expanded(
            child: isEditing
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  autofocus: true,
                  onSubmitted: onSave,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: label,
                    hintStyle: const TextStyle(color: Colors.white54),
                    errorText: errorText, // Показываем ошибку
                  ),
                ),
                if (errorText != null)
                  Text(
                    errorText!,
                    style: const TextStyle(color: Colors.red),
                  ),
              ],
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(color: Colors.white70),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          if (isNavigable)
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.orange,
              size: 16,
            )
          else
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.orange),
              onPressed: onEdit,
            ),
        ],
      ),
    );
  }
}

class ProfileNavigationItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const ProfileNavigationItem({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.orange),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.orange,
            size: 16,
          ),
        ],
      ),
    );
  }
}
