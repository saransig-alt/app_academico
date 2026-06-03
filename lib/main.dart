import 'package:app_academico/features/academic_program/providers/academic.program.provider.dart';
import 'package:app_academico/features/carrera/providers/carrera.provider.dart';
import 'package:app_academico/features/documents/providers/document.provider.dart';
import 'package:app_academico/features/students/providers/student.provider.dart';
import 'package:app_academico/features/students/subject/providers/subject.provider.dart';
import 'package:app_academico/features/users/providers/user.provider.dart' show UserProvider;
import 'package:app_academico/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app/app.startup.dart';
import 'app/app.widget.dart';
import 'package:provider/provider.dart';

import 'features/users/providers/auth.provider.dart';

void main() async {
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
          create: (_) => AcademicProgramProvider()..loadAcademicPrograms(),
        ),
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
               ChangeNotifierProvider(create: (_) => UserProvider()),

        /// ============================
        /// AUTHENTICATION
        /// ============================
        ChangeNotifierProxyProvider<UserProvider, AuthProvider>(
          create: (context) =>
              AuthProvider(userProvider: context.read<UserProvider>()),

          update: (context, userProvider, previous) =>
              previous ?? AuthProvider(userProvider: userProvider),
        ),
      ],

      child: const AppStartup(child: AppWidget()),
    ),


  );
}
