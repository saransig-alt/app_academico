import '../models/student.model.dart';

class StudentRepository {
  /// Simulación de base de datos en memoria
  final List<Student> _students = [
    Student(
      id: 1,
      code: "STU001",
      firstName: "Juan",
      lastName: "Pérez",
      careerId: 1,
      gender: "M",
      birthDate: DateTime(2005, 5, 10),
      email: "juan@email.com",
      phone: "0999999999",
      photoUrl: "",
    ),
    Student(
      id: 2,
      code: "STU002",
      firstName: "María",
      lastName: "Lopez",
      careerId: 2,
      gender: "F",
      birthDate: DateTime(2006, 3, 15),
      email: "maria@email.com",
      phone: "0988888888",
      photoUrl: "",
    ),
    Student(
      id: 3,
      code: "STU003",
      firstName: "Hefziba",
      lastName: "Saransig",
      careerId: 3,
      gender: "F",
      birthDate: DateTime(2006, 4, 26),
      email: "shefziba@hotmail.com",
      phone: "0959071745",
      photoUrl: "",
    ),
  ];

  /// GET ALL
  List<Student> getAll() {
    return _students;
  }

  /// GET BY ID
  Student? getById(int id) {
    return _students.firstWhere(
      (s) => s.id == id,
      orElse: () => throw Exception("Student not found"),
    );
  }

  /// INSERT
  void add(Student student) {
    _students.add(student);
  }

  /// UPDATE
  void update(Student student) {
    final index = _students.indexWhere((s) => s.id == student.id);
    if (index != -1) {
      _students[index] = student;
    }
  }

  /// DELETE
  void delete(int id) {
    _students.removeWhere((s) => s.id == id);
  }
}
