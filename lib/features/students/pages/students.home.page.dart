import 'package:app_academico/features/students/models/student.model.dart';
import 'package:app_academico/features/students/pages/students.page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StudentsHomePage extends StatelessWidget {
  const StudentsHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estudiante')),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: const StudentsPage(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Student? estudiante = provider.getById(1);
          Student? estudiante;

          final result = await context.push(
            '/student/home',
            extra: estudiante,
          );

          if (result == true && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Estudiante creado correctamente',
                ),
              ),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
