import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../pages/chat.page.dart';
import '../../pages/home.pages.dart';
import '../../pages/profile.page.dart';
import '../../pages/students.page.dart';
import '../../widgets/app.shell.widget.dart';
import '../../pages/students.detail.page.dart';
import '../../pages/subjects.page.dart';
import '../../pages/subjects.detail.page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return AppShellWidget(child: child);
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
            return const StudentsPage();
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
      path: '/student/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;

        return StudentDetailPage(id: id);
      },
    ),
    GoRoute(
      path: '/subject/:name',
      builder: (context, state) {
        final name = state.pathParameters['name']!;
        return SubjectDetailPage(name: name);
      } 
    ),
    GoRoute(
      path: '/chat',
      builder: (context, state) {
        return const ChatPage();
      },
    ),
  ],
);
