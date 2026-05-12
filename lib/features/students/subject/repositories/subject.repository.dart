import '../models/subject.model.dart';

class SubjectRepository {
  final List<Subject> _subjects = [
    Subject(
      id: 1,
      code: 'MAT-101',
      name: 'Matemática',
      credits: 4,
      hours: 64,
      knowledgeArea: KnowledgeArea(
        name: 'Ciencias Básicas',
        career: 'Ingeniería Sistemas',
        level: 'Primer Nivel',
      ),
    ),
    Subject(
      id: 2,
      code: 'PRO-201',
      name: 'Programación',
      credits: 5,
      hours: 80,
      knowledgeArea: KnowledgeArea(
        name: 'Tecnología',
        career: 'Ingeniería Software',
        level: 'Segundo Nivel',
      ),
    ),
  ];

  List<Subject> getAll() {
    return _subjects;
  }

  Subject? getById(int id) {
    try {
      return _subjects.firstWhere(
        (e) => e.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  void add(Subject subject) {
    _subjects.add(subject);
  }

  void update(Subject subject) {
    final index = _subjects.indexWhere(
      (e) => e.id == subject.id,
    );

    if (index != -1) {
      _subjects[index] = subject;
    }
  }

  void delete(int id) {
    _subjects.removeWhere(
      (e) => e.id == id,
    );
  }
}
