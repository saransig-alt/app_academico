import 'package:app_academico/features/carrera/models/carrera.model.dart';

class CarreraRepository {
  final List<Carrera> _carreras = [
    Carrera(id: 1, nombre: 'Desarrollo de Software'),
    Carrera(id: 2, nombre: 'Diseño Gráfico'),
    Carrera(id: 3, nombre: 'Administración de Empresas'),
    Carrera(id: 4, nombre: 'TI'),
    Carrera(id: 5, nombre: 'Redes'),
  ];

  List<Carrera> getAll() {
    return _carreras;
  }
}
