import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/document.provider.dart';
import '../models/document.model.dart';

class DocumentDetailPage extends StatelessWidget {
  final String id;

  const DocumentDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DocumentProvider>();
    final documentId = int.tryParse(id);
    final Document? document =
        documentId != null ? provider.getById(documentId) : null;
  
    if (document == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Documento')),
        body: const Center(child: Text('Documento no encontrado')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(document.documentNumber)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  const Icon(Icons.qr_code_2, size: 100, color: Colors.black87),
                  const SizedBox(height: 5),
                  Text(
                    document.verificationCode,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            

            const Divider(height: 40),

            _infoTile(Icons.assignment, "Tipo de documento", document.type),
            _infoTile(Icons.info, "Estado del documento", document.status),
            _infoTile(Icons.priority_high, "Prioridad", document.priority),
            _infoTile(Icons.person, "Estudiante asociado (ID)", document.studentId.toString()),
            _infoTile(Icons.person_outline, "Remitente", document.sender),
            _infoTile(Icons.business, "Destinatario", document.receiver),
            _infoTile(Icons.corporate_fare, "Departamento o área", document.department),
            _infoTile(
              Icons.calendar_today,
              "Fecha de creación",
              "${document.createdAt.day}/${document.createdAt.month}/${document.createdAt.year}",
            ),
            _infoTile(
              Icons.rate_review,
              "Fecha de firma o aprobación",
              document.approvedAt != null
                  ? "${document.approvedAt!.day}/${document.approvedAt!.month}/${document.approvedAt!.year}"
                  : "Pendiente de firma",
            ),

            const SizedBox(height: 20),

            const Text(
              'Asunto:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              document.title,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),
            const Text(
              'Descripción o contenido:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[200], 
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                document.description,
                style: const TextStyle(fontSize: 15, height: 1.4),
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              'Archivos adjuntos:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            document.attachments.isEmpty
                ? const Text('No hay archivos adjuntos.', style: TextStyle(fontStyle: FontStyle.italic))
                : Column(
                    children: document.attachments
                        .map((file) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(Icons.attach_file, color: Colors.blueGrey),
                              title: Text(file),
                            ))
                        .toList(),
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
      contentPadding: EdgeInsets.zero, 
      leading: Icon(icon, color: Colors.blueGrey),
      title: Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      subtitle: Text(value, style: const TextStyle(fontSize: 16, color: Colors.black)),
    );
  }
}