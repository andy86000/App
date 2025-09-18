import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Map<String,dynamic>> _history = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList('history') ?? [];
    setState(() {
      _history = list.map((e) => jsonDecode(e) as Map<String,dynamic>).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Historial', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Expanded(child: _history.isEmpty ? Center(child: Text('Sin historial')) :
              ListView.builder(itemCount: _history.length, itemBuilder: (context, idx) {
                final it = _history[idx];
                return Card(
                  margin: EdgeInsets.symmetric(vertical:8),
                  child: ListTile(
                    title: Text(it['q'] ?? ''),
                    subtitle: Text((it['a'] ?? '').toString().length > 60 ? (it['a'] ?? '').toString().substring(0,60)+'...' : (it['a'] ?? '')),
                    trailing: Text(it['ts']?.substring(0,10) ?? ''),
                    onTap: (){},
                  ),
                );
              })),
          ],
        ),
      ),
    );
  }
}
