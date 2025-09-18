import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _loading = false;
  List<String> _answers = [];

  Future<void> _sendQuery() async {
    final q = _controller.text.trim();
    if (q.isEmpty) return;
    setState(() { _loading = true; _answers = []; });
    try {
      // For demo: we call /api/docs/<doc_id>/ask. You should upload a doc first and use its id.
      // If you want to support asking without doc, adapt your backend endpoint accordingly.
      final url = Uri.parse('\$API_BASE_URL/api/docs/demo/ask');
      final resp = await http.post(url, headers: {'Content-Type':'application/json'}, body: jsonEncode({'question': q}));
      if (resp.statusCode == 200) {
        final js = jsonDecode(resp.body);
        String ans = js['answer'] ?? js.toString();
        final parts = ans.split('. ').where((s) => s.trim().isNotEmpty).toList();
        setState(() { _answers = parts; });
        final prefs = await SharedPreferences.getInstance();
        final history = prefs.getStringList('history') ?? [];
        history.insert(0, jsonEncode({'q': q, 'a': ans, 'ts': DateTime.now().toIso8601String()}));
        await prefs.setStringList('history', history);
      } else {
        setState(() { _answers = ['Error: \${resp.statusCode}']; });
      }
    } catch (e) {
      setState(() { _answers = ['Error: \$e']; });
    } finally {
      setState(() { _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(children: [
              Image.asset('assets/logo.png', width: 56, height: 56),
              SizedBox(width: 12),
              Text('Legal_AI', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ]),
            SizedBox(height: 12),
            TextField(
              controller: _controller,
              minLines: 1,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                hintText: 'Escribe tu consulta legal aquí...'
              ),
            ),
            SizedBox(height: 12),
            Row(children: [
              Expanded(child: ElevatedButton.icon(
                icon: Icon(Icons.send),
                label: Text('Consultar'),
                onPressed: _loading ? null : _sendQuery,
                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              )),
            ]),
            SizedBox(height: 12),
            if (_loading) CircularProgressIndicator(),
            Expanded(child: ListView.builder(
              itemCount: _answers.length,
              itemBuilder: (context, index) {
                final a = _answers[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical:8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(a, style: TextStyle(fontSize: 15)),
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
