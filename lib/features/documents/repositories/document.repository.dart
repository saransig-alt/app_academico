import '../models/document.model.dart';

class DocumentRepository {
  final List<Document> _documents = [
    Document(
      id: 1,
      documentNumber: "SOL-2026-001",
      type: "Solicitud",
      title: "Justificación de asistencia",
      description: "Solicito la justificación de la falta del día 15 de mayo por motivos de salud.",
      studentId: 1,
      sender: "Juan Pérez",
      receiver: "Secretaría Académica",
      department: "Secretaría",
      status: "Aprobado",
      priority: "Normal",
      createdAt: DateTime(2026, 5, 15),
      approvedAt: DateTime(2026, 5, 16),
      attachments: [],
      verificationCode: "QR-DOC-001",
    ),
    Document(
      id: 2,
      documentNumber: "OFI-2026-002",
      type: "Oficio",
      title: "Pasantías Pre-profesionales",
      description: "Requiere certificado de matrícula y autorización para iniciar prácticas en el departamento de Tics.",
      studentId: 3, 
      sender: "Hefziba Saransig",
      receiver: "Rectorado",
      department: "Dirección Académica",
      status: "En revisión",
      priority: "Alta",
      createdAt: DateTime(2026, 5, 16),
      approvedAt: null,
      attachments: ["solicitud_firmada.pdf"],
      verificationCode: "QR-DOC-002",
    ),
  ];

  /// GET ALL
  List<Document> getAll() {
    return _documents;
  }

  /// GET BY ID
  Document? getById(int id) {
    return _documents.firstWhere(
      (d) => d.id == id,
      orElse: () => throw Exception("Document not found"),
    );
  }

  /// INSERT
  void add(Document document) {
    _documents.add(document);
  }

  /// UPDATE
  void update(Document document) {
    final index = _documents.indexWhere((d) => d.id == document.id);
    if (index != -1) {
      _documents[index] = document;
    }
  }

  /// DELETE
  void delete(int id) {
    _documents.removeWhere((d) => d.id == id);
  }
}