import 'package:app_academico/features/students/models/student.model.dart';
import 'package:app_academico/features/students/pages/students.page.dart';
import 'package:app_academico/features/students/providers/student.provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
          final provider = context.read<StudentProvider>();
          Student? estudiante = null;
          // Student? estudiante = provider.getById(1);
          context.push('/student/home', extra: estudiante);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
