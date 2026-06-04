import 'package:app_academico/features/documents/models/document.model.dart';
import 'package:app_academico/features/documents/pages/documents.detail.page.dart';
import 'package:app_academico/features/documents/pages/documents.form.page.dart';
import 'package:app_academico/features/documents/pages/documents.home.page.dart';
import 'package:app_academico/features/login/pages/login.page.dart';
import 'package:app_academico/features/students/models/student.model.dart';
import 'package:app_academico/features/students/pages/students.form.page.dart';
import 'package:app_academico/features/students/pages/students.home.page.dart';
import 'package:app_academico/features/students/subject/pages/subjects.detail.page.dart';
import 'package:app_academico/features/students/subject/pages/subjects.page.dart';
import 'package:app_academico/features/welcome/welcome.page.dart';
import 'package:go_router/go_router.dart';
import '../../features/login/pages/register.page.dart';
import '../../features/users/providers/auth.provider.dart';
import '../../pages/chat.page.dart';
import '../../pages/home.pages.dart';
import '../../pages/profile.page.dart';
import '../../features/students/pages/students.detail.page.dart';
import '../../app/app.shell.widget.dart';

GoRouter createRouter(AuthProvider authProvider) {
  return GoRouter(
    initialLocation: '/',
    refreshListenable: authProvider,
    redirect: (context, state) {
      final isLoggedIn = authProvider.isAuthenticated;

      final location = state.matchedLocation;

      const publicRoutes = ['/', '/login', '/register'];

      final isPublicRoute = publicRoutes.contains(location);

      if (!isLoggedIn && !isPublicRoute) {
        return '/login';
      }

      if (isLoggedIn && isPublicRoute) {
        return '/home';
      }

      return null;
    },
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
        builder: (context, state) {
          return LoginPage();
        },
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) {
          return const RegisterPage();
        },
      ),
      GoRoute(
        path: '/students',
        builder: (context, state) {
          return StudentsHomePage();
        },
      ),
      GoRoute(
        path: '/student/form',
        builder: (context, state) {
          final student = state.extra as Student?;
          return StudentsFormPage(student: student);
        },
      ),
      GoRoute(
        path: '/student/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return StudentDetailPage(id: id);
        },
      ),
      GoRoute(
        path: '/subject/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return SubjectDetailPage(id: id);
        },
      ),
      GoRoute(
        path: '/chat',
        builder: (context, state) {
          return const ChatPage();
        },
      ),
    ],
  );
}
