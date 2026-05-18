import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../providers/document.provider.dart';

class DocumentsPage extends StatelessWidget {
  const DocumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final documents = context.watch<DocumentProvider>().documents;

    if (documents.isEmpty) {
      return const Center(
        child: Text("No hay documentos"),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: documents.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, 
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75, 
      ),
      itemBuilder: (context, index) {
        final document = documents[index];

        return _DocumentCard(
          numeroDoc: document.documentNumber,
          titulo: document.title,
          id: document.id,
        );
      },
    );
  }
}

class _DocumentCard extends StatelessWidget {
  final String numeroDoc;
  final String titulo;
  final int id;

  const _DocumentCard({
    required this.numeroDoc,
    required this.titulo,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push("/document/$id");
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Container(
                  width: double.infinity,
                  color: Colors.indigo.shade100, 
                  child: const Icon(
                    Icons.description, 
                    size: 70,
                    color: Colors.indigo,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Text(
                    titulo,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    numeroDoc,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}