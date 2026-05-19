import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/document.model.dart';
import 'documents.page.dart';

class DocumentsHomePage extends StatelessWidget {
  const DocumentsHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Documentos')),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: const DocumentsPage(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Document? documento;

          final result = await context.push(
            '/document/form',
            extra: documento,
          );

          if (result == true && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Documento creado correctamente',
                ),
              ),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
