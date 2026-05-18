import 'package:app_academico/features/documents/providers/document.provider.dart';
import 'package:app_academico/features/students/providers/student.provider.dart';
import 'package:app_academico/features/students/subject/providers/subject.provider.dart';
import 'package:flutter/material.dart';
import 'app.widget.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => StudentProvider()..loadStudents(),
        ),
        ChangeNotifierProvider(
          create: (_) => SubjectProvider()..loadSubjects(),
        ),
        ChangeNotifierProvider(
          create: (_) => DocumentProvider()..loadDocuments(),
        ),
      ],
      child: const AppWidget(),
    ),
  );
}
