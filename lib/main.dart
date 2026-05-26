import 'package:app_academico/features/carrera/providers/carrera.provider.dart';
import 'package:app_academico/features/documents/providers/document.provider.dart';
import 'package:app_academico/features/students/providers/student.provider.dart';
import 'package:app_academico/features/students/subject/providers/subject.provider.dart';
import 'package:app_academico/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app/app.widget.dart';
import 'package:provider/provider.dart';

void main() async{
  /// NECESARIO para Firebase
  WidgetsFlutterBinding.ensureInitialized();

  /// Inicializar Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
        ChangeNotifierProvider(
          create: (_) => CarreraProvider()..loadCareers(),
        ),
      ],
      child: const AppWidget(),
    ),
  );
}
