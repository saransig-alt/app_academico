import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SubjectDetailPage extends StatelessWidget {
  final String name; 

  const SubjectDetailPage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle: $name')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Esta es una pantalla fullscreen fuera del ShellRoute.'),
              ),
            ),
            const Spacer(),
            FilledButton.icon(
              onPressed: () => context.push('/chat'), 
              icon: const Icon(Icons.forum),
              label: const Text('Abrir Chat de Materia'),
            ),
          ],
        ),
      ),
    );
  }
}