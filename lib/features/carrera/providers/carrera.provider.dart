import 'package:app_academico/features/carrera/models/carrera.model.dart';
import 'package:app_academico/features/carrera/repositories/carrera.respository.dart';
import 'package:flutter/material.dart';

class CarreraProvider extends ChangeNotifier {
  final CarreraRepository _repositorio = CarreraRepository();
  List<Carrera> _careers = [];

  List<Carrera> get careers => _careers;

  void loadCareers() {
    _careers = _repositorio.getAll();
    notifyListeners();
  }
}
