// lib/features/students/models/student.view.dart
import '../../academic_program/model/academic.program.model.dart';
import 'student.model.dart';

class StudentView {
  final Student student;
  final AcademicProgram academicProgram;

  StudentView({
    required this.student,
    required this.academicProgram,
  });
}
