import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/users/providers/user.provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().currentUser;

    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.indigo.shade100,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bienvenido ${user.firstName}',
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              CircleAvatar(
                radius: 40,
                backgroundImage: user.photoUrl.isNotEmpty
                    ? NetworkImage(user.photoUrl)
                    : null,
                child: user.photoUrl.isEmpty
                    ? const Icon(Icons.person, size: 40)
                    : null,
              ),
              const SizedBox(height: 15),
              const Text(
                'Ejemplo didáctico usando GoRouter + ShellRoute',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
