import 'package:app_academico/features/carrera/models/carrera.model.dart';

class CarreraRepository {
  // Aquí simulamos las carreras del pizarrón
  final List<Carrera> _carreras = [
    Carrera(id: 1, nombre: 'Desarrollo de Software'),
    Carrera(id: 2, nombre: 'Diseño Gráfico'),
    Carrera(id: 3, nombre: 'Gastronomía'),
  ];

  List<Carrera> getAll() {
    return _carreras;
  }
}
