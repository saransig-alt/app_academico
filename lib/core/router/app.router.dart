import 'package:app_academico/features/students/subject/pages/subjects.detail.page.dart';
import 'package:app_academico/features/students/subject/pages/subjects.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../pages/chat.page.dart';
import '../../pages/home.pages.dart';
import '../../pages/profile.page.dart';

/// STUDENTS
import '../../features/students/pages/students.page.dart';
import '../../features/students/pages/students.detail.page.dart';

/// SHELL
import '../../widgets/app.shell.widget.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    /// SHELL ROUTE
    ShellRoute(
      builder: (context, state, child) {
        return AppShellWidget(
          child: child,
        );
      },
      routes: [
        /// HOME
        GoRoute(
          path: '/home',
          builder: (context, state) {
            return const HomePage();
          },
        ),

        /// STUDENTS
        GoRoute(
          path: '/students',
          builder: (context, state) {
            return const StudentsPage();
          },
        ),

        /// SUBJECTS
        GoRoute(
          path: '/subjects',
          builder: (context, state) {
            return const SubjectsPage();
          },
        ),

        /// PROFILE
        GoRoute(
          path: '/profile',
          builder: (context, state) {
            return const ProfilePage();
          },
        ),
      ],
    ),

    /// STUDENT DETAIL
    GoRoute(
      path: '/student/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;

        return StudentDetailPage(
          id: id,
        );
      },
    ),

    /// SUBJECT DETAIL
    GoRoute(
      path: '/subject/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;

        return SubjectDetailPage(
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
