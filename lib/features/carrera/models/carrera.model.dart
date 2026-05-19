import 'package:flutter/src/material/dropdown.dart';

class Carrera {
  final int id;
  final String nombre;

  Carrera({
    required this.id,
    required this.nombre,
  });

  static map(DropdownMenuItem<int> Function(dynamic carrera) param0) {}
}
