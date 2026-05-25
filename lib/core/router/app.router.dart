import 'package:app_academico/features/documents/models/document.model.dart';
import 'package:app_academico/features/documents/pages/documents.detail.page.dart';
import 'package:app_academico/features/documents/pages/documents.form.page.dart';
import 'package:app_academico/features/documents/pages/documents.home.page.dart';
import 'package:app_academico/features/students/models/student.model.dart';
import 'package:app_academico/features/students/pages/students.form.page.dart';
import 'package:app_academico/features/students/pages/students.home.page.dart';
import 'package:app_academico/features/students/subject/pages/subjects.detail.page.dart';
import 'package:app_academico/features/students/subject/pages/subjects.page.dart';
import 'package:app_academico/features/welcome/welcome.page.dart';
import 'package:app_academico/pages/login.page.dart';
import 'package:go_router/go_router.dart';
import '../../pages/chat.page.dart';
import '../../pages/home.pages.dart';
import '../../pages/profile.page.dart';
import '../../features/students/pages/students.detail.page.dart';
import '../../app/app.shell.widget.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return AppShellWidget(
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) {
            return const HomePage();
          },
        ),
        GoRoute(
          path: '/students',
          builder: (context, state) {
            return StudentsHomePage();
          },
        ),
        GoRoute(
          path: '/documents',
          builder: (context, state) {
            return const DocumentsHomePage();
          },
        ),
        GoRoute(
          path: '/subjects',
          builder: (context, state) {
            return const SubjectsPage();
          },
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) {
            return const ProfilePage();
          },
        ),
      ],
    ),

    GoRoute(
      path: '/',
      builder: (context, state) {
        return WelcomePage();
      },
    ),

      GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),

    GoRoute(
      path: '/student/home',
      builder: (context, state) {
        final student = state.extra as Student?;
        return StudentsFormPage(
          student: student,
        );
      },
    ),
    GoRoute(
      path: '/document/form',
      builder: (context, state) {
        final document = state.extra as Document?;
        final studentId = state.uri.queryParameters['studentId'];

        return DocumentsFormPage(
          document: document,
          studentId: studentId,
        );
      },
    ),
    GoRoute(
      path: '/student/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;

        return StudentDetailPage(
          id: id,
        );
      },
    ),

    GoRoute(
      path: '/subject/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;

        return SubjectDetailPage(
          id: id,
        );
      },
    ),

    GoRoute(
      path: '/document/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return DocumentDetailPage(
          id: id,
        );
      },
    ),

    /// CHAT
    GoRoute(
      path: '/chat',
      builder: (context, state) {
        return const ChatPage();
      },
    ),
  ],
);
