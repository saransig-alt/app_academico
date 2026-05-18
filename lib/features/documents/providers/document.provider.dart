import 'package:flutter/material.dart';
import '../models/document.model.dart';
import '../repositories/document.repository.dart';

class DocumentProvider extends ChangeNotifier {
  final DocumentRepository _repository = DocumentRepository();

  List<Document> _documents = [];

  List<Document> get documents => _documents;

  /// INIT
  void loadDocuments() {
    _documents = _repository.getAll();
    notifyListeners();
  }

  /// CREATE
  void addDocument(Document document) {
    _repository.add(document);
    loadDocuments();
  }

  /// UPDATE
  void updateDocument(Document document) {
    _repository.update(document);
    loadDocuments();
  }

  /// DELETE
  void deleteDocument(int id) {
    _repository.delete(id);
    loadDocuments();
  }

  Document? getById(int id) {
    return _repository.getById(id);
  }
}