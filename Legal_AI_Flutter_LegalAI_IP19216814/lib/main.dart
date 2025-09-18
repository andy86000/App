import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/history_screen.dart';
import 'screens/about_screen.dart';

void main() {
  runApp(LegalAIApp());
}

class LegalAIApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Legal_AI',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: MainTabView(),
    );
  }
}

class MainTabView extends StatefulWidget {
  @override
  _MainTabViewState createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  int _currentIndex = 0;
  final tabs = [HomeScreen(), HistoryScreen(), AboutScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (int idx) {
          setState(() { _currentIndex = idx; });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.history), label: 'Historial'),
          NavigationDestination(icon: Icon(Icons.info), label: 'Acerca'),
        ],
      ),
    );
  }
}
