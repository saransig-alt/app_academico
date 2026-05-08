import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SubjectsPage extends StatelessWidget {
  const SubjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final materias = [
      'Programación',
      'Matemáticas',
      'Bases de Datos',
      'Redes',
      'Diseño Web'
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: materias.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: const Icon(Icons.book, color: Colors.indigo),
            title: Text(materias[index]),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              context.push('/subject/${materias[index]}');
            },
          ),
        );
      },
    );
  }
}