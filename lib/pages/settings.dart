import 'package:flutter/material.dart';
import 'package:nantap/progress/interfaces.dart';

class SettingsPage extends StatefulWidget {
  final AbstractProgressManager manager;

  const SettingsPage({super.key, required this.manager});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _soundEnabled = true; // Значение по умолчанию
  bool _musicEnabled = true; // Значение по умолчанию
  String _selectedTheme = 'Light'; // Значение по умолчанию
  String _selectedLanguage = 'English'; // Значение по умолчанию

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final storage = widget.manager.getStorage();
    final data = await storage.extractData();
    setState(() {
      _soundEnabled = data['soundEnabled'] as bool? ?? true;
      _musicEnabled = data['musicEnabled'] as bool? ?? true;
      _selectedTheme = data['theme'] as String? ?? 'Light';
      _selectedLanguage = data['language'] as String? ?? 'English';
    });
  }

  Future<void> _saveSettings() async {
    final storage = widget.manager.getStorage();
    await storage.saveData({
      'soundEnabled': _soundEnabled,
      'musicEnabled': _musicEnabled,
      'theme': _selectedTheme,
      'language': _selectedLanguage,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF07223C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A2E47),
        title: const Text(
          'Настройки',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/profile');
          },
        ),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text(
              'Включить звуки',
              style: TextStyle(color: Colors.white),
            ),
            value: _soundEnabled,
            onChanged: (value) {
              setState(() {
                _soundEnabled = value;
              });
              _saveSettings();
            },
          ),
          SwitchListTile(
            title: const Text(
              'Включить музыку',
              style: TextStyle(color: Colors.white),
            ),
            value: _musicEnabled,
            onChanged: (value) {
              setState(() {
                _musicEnabled = value;
              });
              _saveSettings();
            },
          ),
          ListTile(
            title: const Text(
              'Тема оформления',
              style: TextStyle(color: Colors.white),
            ),
            trailing: DropdownButton<String>(
              value: _selectedTheme,
              dropdownColor: const Color(0xFF07223C),
              items: const [
                DropdownMenuItem(
                  value: 'Light',
                  child: Text(
                    'Светлая',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                DropdownMenuItem(
                  value: 'Dark',
                  child: Text(
                    'Тёмная',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedTheme = value!;
                });
                _saveSettings();
              },
            ),
          ),
          ListTile(
            title: const Text(
              'Выбор языка',
              style: TextStyle(color: Colors.white),
            ),
            trailing: DropdownButton<String>(
              value: _selectedLanguage,
              dropdownColor: const Color(0xFF07223C),
              items: const [
                DropdownMenuItem(
                  value: 'English',
                  child: Text(
                    'Английский',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                DropdownMenuItem(
                  value: 'Russian',
                  child: Text(
                    'Русский',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value!;
                });
                _saveSettings();
              },
            ),
          ),
          ListTile(
            title: const Text(
              'Сбросить прогресс',
              style: TextStyle(color: Colors.white),
            ),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Сбросить прогресс'),
                    content: const Text(
                      'Вы уверены, что хотите сбросить прогресс? Это действие необратимо.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Отмена'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Сбросить'),
                      ),
                    ],
                  ),
                );

                if (confirm == true) {
                  final storage = widget.manager.getStorage();
                  await storage.set('progress', {});
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Прогресс сброшен.')),
                  );
                }
              },
              child: const Text('Сбросить'),
            ),
          ),
        ],
      ),
    );
  }
}
