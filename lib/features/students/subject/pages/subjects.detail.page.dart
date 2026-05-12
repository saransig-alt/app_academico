import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../providers/subject.provider.dart';
import '../models/subject.model.dart';

class SubjectDetailPage extends StatelessWidget {
  final String id;

  const SubjectDetailPage({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SubjectProvider>();
    final subjectId = int.tryParse(id);
    final Subject? subject =
        subjectId != null ? provider.getById(subjectId) : null;

    if (subject == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Asignatura'),
        ),
        body: const Center(
          child: Text('Asignatura no encontrada'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(subject.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              child: Icon(
                Icons.book,
                size: 60,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              subject.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Código: ${subject.code}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const Divider(height: 30),
            _infoTile(
              Icons.numbers,
              'Créditos',
              '${subject.credits}',
            ),
            _infoTile(
              Icons.access_time,
              'Horas',
              '${subject.hours}',
            ),
            _infoTile(
              Icons.category,
              'Área',
              subject.knowledgeArea.name,
            ),
            _infoTile(
              Icons.school,
              'Carrera',
              subject.knowledgeArea.career,
            ),
            _infoTile(
              Icons.layers,
              'Nivel',
              subject.knowledgeArea.level,
            ),
            const SizedBox(height: 30),
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

class _infoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _infoTile(
    this.icon,
    this.label,
    this.value,
  );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      subtitle: Text(value),
    );
  }
}
