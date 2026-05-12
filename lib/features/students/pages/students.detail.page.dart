import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../providers/student.provider.dart';
import '../models/student.model.dart';

class StudentDetailPage extends StatelessWidget {
  final String id;

  const StudentDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    /// Provider
    final provider = context.watch<StudentProvider>();

    /// Convertir id a int
    final studentId = int.tryParse(id);

    /// Buscar estudiante
    final Student? student =
        studentId != null ? provider.getById(studentId) : null;

    /// Si no existe
    if (student == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Estudiante')),
        body: const Center(child: Text('Estudiante no encontrado')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('${student.firstName} ${student.lastName}')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// FOTO
            CircleAvatar(
              radius: 60,
              backgroundImage: student.photoUrl.isNotEmpty
                  ? AssetImage(student.photoUrl)
                  : null,
              child: student.photoUrl.isEmpty
                  ? const Icon(Icons.person, size: 60)
                  : null,
            ),

            const SizedBox(height: 20),

            /// NOMBRE
            Text(
              '${student.firstName} ${student.lastName}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            /// CÓDIGO
            Text(
              'Código: ${student.code}',
              style: const TextStyle(fontSize: 16),
            ),

            const Divider(height: 30),

            _infoTile(Icons.badge, "Género", student.gender),
            _infoTile(Icons.email, "Email", student.email),
            _infoTile(Icons.phone, "Teléfono", student.phone),
            _infoTile(
              Icons.cake,
              "Fecha nacimiento",
              "${student.birthDate.day}/${student.birthDate.month}/${student.birthDate.year}",
            ),

            const SizedBox(height: 30),

            /// BOTÓN CHAT
            FilledButton.icon(
              onPressed: () {
                context.push('/chat');
              },
              icon: const Icon(Icons.chat),
              label: const Text('Abrir Chat'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget reutilizable
class _infoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _infoTile(this.icon, this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      subtitle: Text(value),
    );
  }
}
