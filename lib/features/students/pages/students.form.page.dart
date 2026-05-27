import 'package:app_academico/features/students/models/student.model.dart';
import 'package:app_academico/features/students/providers/student.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/section.title.dart';
import '../../carrera/providers/carrera.provider.dart';

class StudentsFormPage extends StatefulWidget {
  final Student? student;

  const StudentsFormPage({
    Key? key,
    this.student,
  }) : super(key: key);

  @override
  State<StudentsFormPage> createState() => _StudentsFormPageState();
}

class _StudentsFormPageState extends State<StudentsFormPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _codeCtrl;
  late final TextEditingController _firstNameCtrl;
  late final TextEditingController _lastNameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _phoneCtrl;

  String? _selectedGender;
  DateTime? _selectedBirthDate;

  int? _selectedAcademicProgramId;

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

    _emailCtrl = TextEditingController(
      text: s?.email ?? '',
    );

    _phoneCtrl = TextEditingController(
      text: s?.phone ?? '',
    );

    _selectedAcademicProgramId = s?.academicProgramId;

    _selectedGender = s?.gender.isEmpty == true ? null : s?.gender;

    _selectedBirthDate = s?.birthDate;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CarreraProvider>().loadCareers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final careers = context.watch<CarreraProvider>().careers;

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
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  /// ============================
                  /// INFORMACIÓN ACADÉMICA
                  /// ============================
                  const SectionTitle(
                    title: 'Información Académica',
                  ),

                  _buildTextField(
                    _codeCtrl,
                    'Código',
                    Icons.badge,
                    required: true,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: DropdownButtonFormField<int>(
                      value: _selectedAcademicProgramId,
                      decoration: const InputDecoration(
                        labelText: 'Selecciona la Carrera',
                        prefixIcon: Icon(Icons.school),
                        border: OutlineInputBorder(),
                      ),
                      items: careers.map((career) {
                        return DropdownMenuItem<int>(
                          value: career.id,
                          child: Text(career.nombre),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedAcademicProgramId = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Por favor selecciona una carrera';
                        }
                        return null;
                      },
                    ),
                  ),

                  /// ============================
                  /// DATOS PERSONALES
                  /// ============================
                  const SectionTitle(
                    title: 'Datos Personales',
                  ),

                  _buildTextField(
                    _firstNameCtrl,
                    'Nombres',
                    Icons.person,
                    required: true,
                  ),

                  _buildTextField(
                    _lastNameCtrl,
                    'Apellidos',
                    Icons.person_outline,
                    required: true,
                  ),

                  _buildTextField(
                    _emailCtrl,
                    'Correo Electrónico',
                    Icons.email,
                    type: TextInputType.emailAddress,
                  ),

                  _buildTextField(
                    _phoneCtrl,
                    'Teléfono',
                    Icons.phone,
                    type: TextInputType.phone,
                  ),

                  const SizedBox(height: 40),

                  _SaveButton(
                    onPressed: _handleSave,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleSave() {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<StudentProvider>();

    final student = Student(
      id: widget.student?.id ?? 0,
      code: _codeCtrl.text.trim(),
      firstName: _firstNameCtrl.text.trim(),
      lastName: _lastNameCtrl.text.trim(),
      academicProgramId: _selectedAcademicProgramId!,
      gender: _selectedGender ?? '',
      birthDate: _selectedBirthDate ?? DateTime.now(),
      email: _emailCtrl.text.trim(),
      phone: _phoneCtrl.text.trim(),
      photoUrl: '',
    );

    if (isEdit) {
      provider.updateStudent(student);
    } else {
      provider.addStudent(student);
    }

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
          ? (v) {
              if (v == null || v.isEmpty) {
                return 'Campo requerido';
              }
              return null;
            }
          : null,
    ),
  );
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SaveButton({
    required this.onPressed,
  });

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
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
