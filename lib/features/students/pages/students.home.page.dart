import 'package:app_academico/features/students/pages/students.page.dart';
import 'package:flutter/material.dart';

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
        onPressed: () async {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
