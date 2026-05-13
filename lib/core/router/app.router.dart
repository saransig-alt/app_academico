import 'package:app_academico/features/students/pages/students.home.page.dart';
import 'package:app_academico/features/students/subject/pages/subjects.detail.page.dart';
import 'package:app_academico/features/students/subject/pages/subjects.page.dart';
import 'package:go_router/go_router.dart';
import '../../pages/chat.page.dart';
import '../../pages/home.pages.dart';
import '../../pages/profile.page.dart';
import '../../features/students/pages/students.page.dart';
import '../../features/students/pages/students.detail.page.dart';
import '../../widgets/app.shell.widget.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/home',
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
