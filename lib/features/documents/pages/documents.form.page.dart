import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/document.model.dart';
import '../providers/document.provider.dart';

class DocumentsFormPage extends StatefulWidget {
  final Document? document;
  final String? studentId;

  const DocumentsFormPage({
    Key? key,
    this.document,
    this.studentId,
  }) : super(key: key);

  @override
  _DocumentsFormPageState createState() => _DocumentsFormPageState();
}

class _DocumentsFormPageState extends State<DocumentsFormPage> {
  final _formkey = GlobalKey<FormState>();

  late final TextEditingController _documentNumberCtrl;
  late final TextEditingController _titleCtrl;
  late final TextEditingController _descriptionCtrl;
  late final TextEditingController _studentIdCtrl;
  late final TextEditingController _verificationCodeCtrl;

  String? _selectedType;
  String? _selectedSender;
  String? _selectedReceiver;
  String? _selectedDepartment;
  String? _selectedStatus;
  String? _selectedPriority;

  List<String> _attachedFiles = [];

  final List<String> _typeOptions = [
    'Solicitud',
    'Oficio',
    'Memorando',
    'Certificado',
    'Reclamo',
    'Permiso académico'
  ];
  final List<String> _senderOptions = [
    'Estudiante',
    'Docente',
    'Secretaría',
    'Autoridad académica'
  ];
  final List<String> _receiverOptions = [
    'Secretaría Académica',
    'Coordinación de Carrera',
    'Rectorado'
  ];
  final List<String> _departmentOptions = [
    'Secretaría',
    'Bienestar Estudiantil',
    'Coordinación Académica'
  ];
  final List<String> _statusOptions = [
    'Borrador',
    'Enviado',
    'En revisión',
    'Aprobado',
    'Rechazado',
    'Archivado'
  ];
  final List<String> _priorityOptions = ['Normal', 'Urgente', 'Alta prioridad'];

  bool get isEdit => widget.document != null;

  @override
  void initState() {
    super.initState();
    final d = widget.document;

    _documentNumberCtrl = TextEditingController(text: d?.documentNumber ?? '');
    _titleCtrl = TextEditingController(text: d?.title ?? '');
    _descriptionCtrl = TextEditingController(text: d?.description ?? '');
    _studentIdCtrl = TextEditingController(
        text: widget.studentId ?? (d?.studentId.toString() ?? ''));
    _verificationCodeCtrl =
        TextEditingController(text: d?.verificationCode ?? '');

    if (!isEdit) {
      _documentNumberCtrl.addListener(_autoGenerateQR);
    }
    _attachedFiles =
        d?.attachments != null ? List<String>.from(d!.attachments) : [];
    _selectedType =
        _typeOptions.contains(d?.type) ? d?.type : _typeOptions.first;
    _selectedSender =
        _senderOptions.contains(d?.sender) ? d?.sender : _senderOptions.first;
    _selectedReceiver = _receiverOptions.contains(d?.receiver)
        ? d?.receiver
        : _receiverOptions.first;
    _selectedDepartment = _departmentOptions.contains(d?.department)
        ? d?.department
        : _departmentOptions.first;
    _selectedStatus =
        _statusOptions.contains(d?.status) ? d?.status : 'Borrador';
    _selectedPriority =
        _priorityOptions.contains(d?.priority) ? d?.priority : 'Normal';
  }

  void _autoGenerateQR() {
    final text = _documentNumberCtrl.text.trim();
    if (text.isEmpty) {
      _verificationCodeCtrl.text = '';
      return;
    }

    if (text.contains('-')) {
      _verificationCodeCtrl.text = 'QR-${text.split('-').last}';
    } else {
      _verificationCodeCtrl.text = 'QR-$text';
    }
  }

  @override
  void dispose() {
    _documentNumberCtrl.dispose();
    _titleCtrl.dispose();
    _descriptionCtrl.dispose();
    _studentIdCtrl.dispose();
    _verificationCodeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit ? 'Editar Documento' : 'Nuevo Documento',
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _SectionTitle(title: 'Identificación Institucional'),
                  _buildTextField(_documentNumberCtrl,
                      'Número de documento (Ej: SOL-2026-001)', Icons.tag,
                      required: true),
                  _buildDropdownField(
                    label: 'Tipo de documento',
                    icon: Icons.assignment,
                    value: _selectedType,
                    items: _typeOptions,
                    onChanged: (val) => setState(() => _selectedType = val),
                  ),
                  _buildTextField(_verificationCodeCtrl,
                      'Código de verificación / QR', Icons.qr_code,
                      required: true, enabled: false),
                  const _SectionTitle(title: 'Contenido del Trámite'),
                  _buildTextField(_titleCtrl, 'Asunto', Icons.title,
                      required: true),
                  _buildTextField(
                    _descriptionCtrl,
                    'Descripción',
                    Icons.description,
                    required: true,
                    maxLines: 4,
                  ),
                  const _SectionTitle(title: ' Flujo y Responsables'),
                  _buildTextField(
                    _studentIdCtrl,
                    'ID Estudiante asociado',
                    Icons.school,
                    required: true,
                    type: TextInputType.number,
                    enabled: widget.studentId == null,
                  ),
                  _buildDropdownField(
                    label: 'Remitente',
                    icon: Icons.person,
                    value: _selectedSender,
                    items: _senderOptions,
                    onChanged: (val) => setState(() => _selectedSender = val),
                  ),
                  _buildDropdownField(
                    label: 'Destinatario',
                    icon: Icons.person_outline,
                    value: _selectedReceiver,
                    items: _receiverOptions,
                    onChanged: (val) => setState(() => _selectedReceiver = val),
                  ),
                  _buildDropdownField(
                    label: 'Departamento o área responsable',
                    icon: Icons.business,
                    value: _selectedDepartment,
                    items: _departmentOptions,
                    onChanged: (val) =>
                        setState(() => _selectedDepartment = val),
                  ),
                  const _SectionTitle(title: 'Seguimiento y Organización'),
                  _buildDropdownField(
                    label: 'Estado del documento',
                    icon: Icons.info_outline,
                    value: _selectedStatus,
                    items: _statusOptions,
                    onChanged: (val) => setState(() => _selectedStatus = val),
                  ),
                  _buildDropdownField(
                    label: 'Prioridad de urgencia',
                    icon: Icons.priority_high,
                    value: _selectedPriority,
                    items: _priorityOptions,
                    onChanged: (val) => setState(() => _selectedPriority = val),
                  ),
                  const _SectionTitle(title: '📎 Archivos Adjuntos'),
                  OutlinedButton.icon(
                    onPressed: () {
                      final ejemplos = [
                        'Certificado_Medico.pdf',
                        'Comprobante_Pago.png',
                        'Evidencia_Inasistencia.pdf',
                        'Solicitud_Firmada.pdf'
                      ];

                      final nuevoArchivo =
                          ejemplos[_attachedFiles.length % ejemplos.length];
                      setState(() {
                        _attachedFiles.add(nuevoArchivo);
                      });
                    },
                    icon: const Icon(Icons.attach_file),
                    label:
                        const Text('Simular Adjuntar Evidencia (PDF/Imagen)'),
                  ),
                  const SizedBox(height: 8),
                  if (_attachedFiles.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Ningún archivo seleccionado',
                          style: TextStyle(
                              color: Colors.grey, fontStyle: FontStyle.italic)),
                    )
                  else
                    ..._attachedFiles.map((fileName) => Card(
                          margin: const EdgeInsets.only(bottom: 6),
                          child: ListTile(
                            dense: true,
                            leading: Icon(
                              fileName.endsWith('.pdf')
                                  ? Icons.picture_as_pdf
                                  : Icons.image,
                              color: fileName.endsWith('.pdf')
                                  ? Colors.red
                                  : Colors.blue,
                            ),
                            title: Text(fileName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500)),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete_outline,
                                  color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  _attachedFiles.remove(fileName);
                                });
                              },
                            ),
                          ),
                        )),
                  const SizedBox(height: 40),
                  _SaveButton(onPressed: _handleSave),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleSave() {
    if (!_formkey.currentState!.validate()) return;

    final provider = context.read<DocumentProvider>();

    final document = Document(
      id: widget.document?.id ?? DateTime.now().millisecondsSinceEpoch,
      documentNumber: _documentNumberCtrl.text.trim(),
      type: _selectedType ?? 'Solicitud',
      title: _titleCtrl.text.trim(),
      description: _descriptionCtrl.text.trim(),
      studentId: int.tryParse(_studentIdCtrl.text.trim()) ?? 0,
      sender: _selectedSender ?? 'Estudiante',
      receiver: _selectedReceiver ?? 'Secretaría Académica',
      department: _selectedDepartment ?? 'Secretaría',
      status: _selectedStatus ?? 'Borrador',
      priority: _selectedPriority ?? 'Normal',
      createdAt: widget.document?.createdAt ?? DateTime.now(),
      approvedAt: widget.document?.approvedAt,
      attachments: _attachedFiles,
      verificationCode: _verificationCodeCtrl.text.trim(),
    );

    isEdit ? provider.updateDocument(document) : provider.addDocument(document);

    Navigator.pop(context, true);
  }

  Widget _buildDropdownField({
    required String label,
    required IconData icon,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: value,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
        items: items.map<DropdownMenuItem<String>>((String val) {
          return DropdownMenuItem<String>(
            value: val,
            child: Text(val),
          );
        }).toList(),
        validator: (v) =>
            (v == null || v.isEmpty) ? 'Selección requerida' : null,
      ),
    );
  }
}

Widget _buildTextField(
  TextEditingController ctrl,
  String label,
  IconData icon, {
  bool required = false,
  TextInputType? type,
  bool enabled = true,
  int maxLines = 1,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: TextFormField(
      controller: ctrl,
      keyboardType: type,
      enabled: enabled,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
        fillColor: enabled ? null : Colors.grey[100],
        filled: !enabled,
      ),
      validator: required
          ? (v) => (v == null || v.isEmpty) ? 'Campo requerido' : null
          : null,
    ),
  );
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14, bottom: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey[700],
            ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _SaveButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: FilledButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.save),
        label: const Text(
          'GUARDAR DOCUMENTO',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
