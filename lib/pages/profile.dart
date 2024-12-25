import 'package:flutter/material.dart';
import 'package:nantap/components/footer.dart';
import 'package:nantap/progress/interfaces.dart';
import 'package:nantap/progress/state.dart';
import 'package:nantap/progress/upgrade.dart';

class ProfilePage extends StatefulWidget {
  final AbstractProgressManager progressManager;

  const ProfilePage({
    Key? key,
    required this.progressManager,
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = "";
  String email = "";
  String companyName = "";
  String achievements = "";

  bool isEditingName = false;
  bool isEditingEmail = false;
  bool isEditingCompany = false;

  String? emailError;

  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final storage = await widget.progressManager.getStorage();
    final data = await storage.extractData();

    setState(() {
      username = data['username'] as String? ?? "User";
      email = data['email'] as String? ?? "example@example.com";
      companyName = data['companyName'] as String? ?? "Unknown Corp";
      achievements = data['achievements'] as String? ?? "0/0";
    });
  }

  void _updateProfile(String field, String value) async {
    final storage = await widget.progressManager.getStorage();
    final data = await storage.extractData();

    setState(() {
      switch (field) {
        case "username":
          username = value;
          data['username'] = value;
          break;
        case "email":
          email = value;
          data['email'] = value;
          break;
        case "companyName":
          companyName = value;
          data['companyName'] = value;
          break;
      }
    });

    await storage.saveData(data);
    widget.progressManager.saveProgress();
  }

  void validateEmail(String newEmail) {
    if (emailRegExp.hasMatch(newEmail)) {
      setState(() {
        emailError = null;
        isEditingEmail = false;
      });
      _updateProfile("email", newEmail);
    } else {
      setState(() {
        emailError = 'Неверный формат email';
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
          color: const Color(0xFF07223C),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: const Color(0xFF153B5F),
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
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Color(0xFF153B5F),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileInfoRow(
                          icon: Icons.person,
                          label: "Имя",
                          value: username,
                          isEditing: isEditingName,
                          onSave: (newValue) {
                            setState(() {
                              isEditingName = false;
                            });
                            _updateProfile("username", newValue);
                          },
                          onEdit: () {
                            setState(() {
                              isEditingName = true;
                            });
                          },
                        ),
                        ProfileInfoRow(
                          icon: Icons.email,
                          label: "Email",
                          value: email,
                          isEditing: isEditingEmail,
                          errorText: emailError,
                          onSave: validateEmail,
                          onEdit: () {
                            setState(() {
                              isEditingEmail = true;
                            });
                          },
                        ),
                        ProfileInfoRow(
                          icon: Icons.business,
                          label: "Имя компании",
                          value: companyName,
                          isEditing: isEditingCompany,
                          onSave: (newValue) {
                            setState(() {
                              isEditingCompany = false;
                            });
                            _updateProfile("companyName", newValue);
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
                          value: achievements,
                          isNavigable: true,
                          onTap: () {
                            Navigator.pushReplacementNamed(context, '/achivments');
                          },
                        ),
                        const SizedBox(height: 20),
                        const ProfileNavigationItem(
                          icon: Icons.settings,
                          label: "Настройки",
                        ),
                        const ProfileNavigationItem(
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
      bottomNavigationBar: const Footer(
        selectedIndex: 4,
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
  final Function()? onTap; // Новый параметр
  final String? errorText;

  const ProfileInfoRow({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
    this.isNavigable = false,
    this.isEditing = false,
    this.onSave,
    this.onEdit,
    this.onTap, // Инициализация нового параметра
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isNavigable ? onTap : null, // Реализация onTap
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(icon, color: Colors.orange),
            const SizedBox(width: 10),
            Expanded(
              child: isEditing
                  ? TextField(
                      autofocus: true,
                      onSubmitted: onSave,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: label,
                        hintStyle: const TextStyle(color: Colors.white54),
                        errorText: errorText,
                      ),
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
