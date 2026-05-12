import 'package:app_academico/features/students/providers/student.provider.dart';
import 'package:flutter/material.dart';
import 'app.widget.dart';
import 'package:provider/provider.dart';
import 'package:app_academico/features/students/providers/student.provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => StudentProvider()..loadStudents(),
        ),
      ],
      child: const AppWidget(),
    ),
  );
}
