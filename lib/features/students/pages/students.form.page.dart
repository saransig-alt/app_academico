import 'package:app_academico/features/students/models/student.model.dart';
import 'package:app_academico/features/students/providers/student.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentsFormPage extends StatefulWidget {
  final Student? student;
  const StudentsFormPage({
    Key? key,
    this.student,
  }) : super(key: key);

  @override
  _StudentsFormPageState createState() => _StudentsFormPageState();
}

class _StudentsFormPageState extends State<StudentsFormPage> {
  final _formkey = GlobalKey<FormState>();
  late final TextEditingController _codeCtrl;
  late final TextEditingController _firstNameCtrl;
  late final TextEditingController _lastNameCtrl;
  bool get isEdit => widget.student != null;

  @override
  void initState() {
    super.initState();
    final s = widget.student;
    _codeCtrl = TextEditingController(
      text: s?.code ?? '',
    );
    _firstNameCtrl = TextEditingController(
      text: s?.firstName ?? '',
    );
    _lastNameCtrl = TextEditingController(
      text: s?.lastName ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit ? 'Editar Estudiante' : 'Nuevo Estudiante',
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
                  _SectionTitle(title: 'Información Académica'),
                  _buildTextField(_codeCtrl, 'Código', Icons.badge,
                      required: true),
                  _SectionTitle(title: 'Datos Personales'),
                  _buildTextField(_firstNameCtrl, 'Nombres', Icons.person,
                      required: true),
                  _buildTextField(
                      _lastNameCtrl, 'Apellidos', Icons.person_outline,
                      required: true),
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

    final provider = context.read<StudentProvider>();

    final student = Student(
      id: widget.student?.id ?? 0,
      code: _codeCtrl.text.trim(),
      firstName: _firstNameCtrl.text.trim(),
      lastName: _lastNameCtrl.text.trim(),
      gender: "",
      birthDate: DateTime.now(),
      email: "",
      phone: "",
      photoUrl: "",
    );

    isEdit ? provider.updateStudent(student) : provider.addStudent(student);

    Navigator.pop(context, true);
  }
}

Widget _buildTextField(
  TextEditingController ctrl,
  String label,
  IconData icon, {
  bool required = false,
  TextInputType? type,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: TextFormField(
      controller: ctrl,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
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
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
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
          'GUARDAR ESTUDIANTE',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
