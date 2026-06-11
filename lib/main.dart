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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<String> tasks = const [
    'Turnbeutel einpacken',
    'Müll rausstellen',
    'Wäsche aus der Maschine holen',
  ];

  final List<String> shoppingItems = const [
    'Brot',
    'Milch',
    'Windeln',
    'Äpfel',
  ];

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
            children: tasks
                .map(
                  (task) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.circle_outlined),
                    title: Text(task),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          InfoCard(
            title: 'Einkauf',
            icon: Icons.shopping_cart_outlined,
            children: shoppingItems
                .map(
                  (item) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.add_shopping_cart),
                    title: Text(item),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          const InfoCard(
            title: 'Essen heute',
            icon: Icons.restaurant_menu,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.dinner_dining),
                title: Text('Gebratener Reis mit Gemüse'),
                subtitle: Text('Schnell, günstig und familientauglich'),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
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