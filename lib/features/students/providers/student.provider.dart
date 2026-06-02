import 'package:app_academico/features/academic_program/model/academic.program.model.dart';
import 'package:flutter/material.dart';
import '../models/student.model.dart';
import '../models/student.view.dart';
import '../repositories/student.repository.dart';
import '../../academic_program/repositories/academic.program.repository.dart';

class StudentProvider extends ChangeNotifier {
  final StudentRepository _repository = StudentRepository();
  final AcademicProgramRepository _acadProgramRepository =
      AcademicProgramRepository();
  List<StudentView> _students = [];
  List<StudentView> get students => _students;

  /// ============================
  /// INIT
  /// ============================
  Future<void> loadStudents() async {
    final students = await _repository.getAll();
    final careers = await _acadProgramRepository.getAll();
    _students = students.map((student) {
      final academicProgram = careers.firstWhere(
        (c) => c.id == student.academicProgramId,
        orElse: () => AcademicProgram(id: 0, name: 'Sin carrera'),
      );
      return StudentView(student: student, academicProgram: academicProgram);
    }).toList();
    notifyListeners();
  }

  /// ============================
  /// CREATE
  /// ============================
  Future<void> addStudent(Student student) async {
    await _repository.add(student);
    await loadStudents();
  }

  /// ============================
  /// UPDATE
  /// ============================
  Future<void> updateStudent(Student student) async {
    await _repository.update(student);
    await loadStudents();
  }

  /// ============================
  /// DELETE
  /// ============================
  Future<void> deleteStudent(String id) async {
    await _repository.delete(id);
    await loadStudents();
  }

  /// ============================
  /// GET BY ID
  /// ============================
  Future<Student?> getById(String id) async {
    return await _repository.getById(id);
  }
}
