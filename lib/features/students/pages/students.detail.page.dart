import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../providers/student.provider.dart';
import '../models/student.model.dart';
import '../../documents/providers/document.provider.dart';

class StudentDetailPage extends StatelessWidget {
  final String id;

  const StudentDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
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

            const SizedBox(height: 10),
            FilledButton.icon(
              onPressed: () {
                context.push('/chat');
              },
              icon: const Icon(Icons.chat),
              label: const Text('Abrir Chat'),
            ),

            const Divider(height: 40),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Historial Documental',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Builder(
              builder: (context) {
                final allDocuments = context.watch<DocumentProvider>().documents;
                final misDocumentos = allDocuments
                    .where((doc) => doc.studentId == studentId)
                    .toList();

                if (misDocumentos.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: Text(
                        'No existen documentos registrados',
                        style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
                      ),
                    ),
                  );
                }

                return Column(
                  children: misDocumentos.map((doc) {
                    return Card(
                      color: Colors.grey[200], 
                      elevation: 0,
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: const Icon(Icons.description, color: Colors.blueGrey),
                        title: Text(
                          doc.title, 
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('${doc.documentNumber} - ${doc.status}'),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                        onTap: () {
                          context.push('/document/${doc.id}');
                        },
                      ),
                    );
                  }).toList(),
                );
              },
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo, 
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  context.push('/document/form?studentId=$id');
                },
                child: const Text(
                  'Crear documento',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
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