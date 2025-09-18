import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Image.asset('assets/logo.png', width: 56, height: 56),
              SizedBox(width: 12),
              Text('Legal_AI', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ]),
            SizedBox(height: 12),
            Text('Legal_AI es una aplicación que permite consultar documentos legales y obtener resúmenes y respuestas generadas por IA.', style: TextStyle(fontSize:16)),
            SizedBox(height: 12),
            Text('Desarrollado por tu equipo', style: TextStyle(color: Colors.grey[700])),
          ],
        ),
      ),
    );
  }
}
