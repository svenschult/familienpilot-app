import 'package:flutter/material.dart';

void main() {
  runApp(const FamilienPilotApp());
}

class FamilienPilotApp extends StatelessWidget {
  const FamilienPilotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FamilienPilot',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> tasks = [
    'Turnbeutel einpacken',
    'Müll rausstellen',
    'Wäsche aus der Maschine holen',
  ];

  final List<String> shoppingItems = [
    'Brot',
    'Milch',
    'Windeln',
    'Äpfel',
  ];

  String todayMeal = 'Gebratener Reis mit Gemüse';

  void _openAddMenu() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Was möchtest du hinzufügen?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.check_circle_outline),
                title: const Text('Aufgabe hinzufügen'),
                onTap: () {
                  Navigator.pop(context);
                  _showTextInputDialog(
                    title: 'Neue Aufgabe',
                    hintText: 'z. B. Turnbeutel einpacken',
                    onSave: (value) {
                      setState(() {
                        tasks.add(value);
                      });
                    },
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.shopping_cart_outlined),
                title: const Text('Einkauf hinzufügen'),
                onTap: () {
                  Navigator.pop(context);
                  _showTextInputDialog(
                    title: 'Neuer Einkaufspunkt',
                    hintText: 'z. B. Milch',
                    onSave: (value) {
                      setState(() {
                        shoppingItems.add(value);
                      });
                    },
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.restaurant_menu),
                title: const Text('Essen heute ändern'),
                onTap: () {
                  Navigator.pop(context);
                  _showTextInputDialog(
                    title: 'Essen heute',
                    hintText: 'z. B. Nudeln mit Gemüse',
                    onSave: (value) {
                      setState(() {
                        todayMeal = value;
                      });
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showTextInputDialog({
    required String title,
    required String hintText,
    required void Function(String value) onSave,
  }) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
              hintText: hintText,
              border: const OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Abbrechen'),
            ),
            FilledButton(
              onPressed: () {
                final value = controller.text.trim();

                if (value.isEmpty) {
                  return;
                }

                onSave(value);
                Navigator.pop(context);
              },
              child: const Text('Speichern'),
            ),
          ],
        );
      },
    );
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void _deleteShoppingItem(int index) {
    setState(() {
      shoppingItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FamilienPilot'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Heute wichtig',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Ein schneller Überblick für euren Familientag.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 24),

          InfoCard(
            title: 'Aufgaben',
            icon: Icons.check_circle_outline,
            children: tasks.asMap().entries.map(
              (entry) {
                final index = entry.key;
                final task = entry.value;

                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.circle_outlined),
                  title: Text(task),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () {
                      _deleteTask(index);
                    },
                  ),
                );
              },
            ).toList(),
          ),

          const SizedBox(height: 16),

          InfoCard(
            title: 'Einkauf',
            icon: Icons.shopping_cart_outlined,
            children: shoppingItems.asMap().entries.map(
              (entry) {
                final index = entry.key;
                final item = entry.value;

                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.add_shopping_cart),
                  title: Text(item),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () {
                      _deleteShoppingItem(index);
                    },
                  ),
                );
              },
            ).toList(),
          ),

          const SizedBox(height: 16),

          InfoCard(
            title: 'Essen heute',
            icon: Icons.restaurant_menu,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.dinner_dining),
                title: Text(todayMeal),
                subtitle: const Text('Schnell, günstig und familientauglich'),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddMenu,
        icon: const Icon(Icons.add),
        label: const Text('Hinzufügen'),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const InfoCard({
    super.key,
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }
}