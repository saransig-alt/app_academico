import 'package:flutter/material.dart';

import '../models/subject.model.dart';
import '../repositories/subject.repository.dart';

class SubjectProvider extends ChangeNotifier {
  final SubjectRepository _repository = SubjectRepository();

  List<Subject> _subjects = [];

  List<Subject> get subjects => _subjects;

  /// INIT
  void loadSubjects() {
    _subjects = _repository.getAll();
    notifyListeners();
  }

  /// CREATE
  void addSubject(Subject subject) {
    _repository.add(subject);
    loadSubjects();
  }

  /// UPDATE
  void updateSubject(Subject subject) {
    _repository.update(subject);
    loadSubjects();
  }

  /// DELETE
  void deleteSubject(int id) {
    _repository.delete(id);
    loadSubjects();
  }

  /// GET BY ID
  Subject? getById(int id) {
    return _repository.getById(id);
  }
}
