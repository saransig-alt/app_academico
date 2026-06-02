// To parse this JSON data, do
//
// final studentResponse = studentResponseFromJson(jsonString);

import 'dart:convert';

StudentResponse studentResponseFromJson(String str) =>
    StudentResponse.fromJson(json.decode(str));

String studentResponseToJson(StudentResponse data) =>
    json.encode(data.toJson());

class StudentResponse {
  List<Student> students;

  StudentResponse({
    required this.students,
  });

  factory StudentResponse.fromJson(Map<String, dynamic> json) =>
      StudentResponse(
        students: List<Student>.from(
          json["students"].map((x) => Student.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "students": List<dynamic>.from(
          students.map((x) => x.toJson()),
        ),
      };
}

class Student {
  String? id;
  String code;
  String firstName;
  String lastName;

  /// RELACIÓN CON ACADEMIC PROGRAM
  int academicProgramId;

  String gender;
  DateTime birthDate;
  String email;
  String phone;
  String photoUrl;

  Student({
    required this.id,
    required this.code,
    required this.firstName,
    required this.lastName,
    required this.academicProgramId,
    required this.gender,
    required this.birthDate,
    required this.email,
    required this.phone,
    required this.photoUrl,
  });

  factory Student.fromJson(Map<String, dynamic> json, {String? id}) => Student(
        id: id,
        code: json["code"],
        firstName: json["firstName"],
        lastName: json["lastName"],

        /// FIREBASE
        academicProgramId: json["academicProgramId"] ?? 1,

        gender: json["gender"],
        birthDate: DateTime.parse(json["birthDate"]),
        email: json["email"],
        phone: json["phone"],
        photoUrl: json["photoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "firstName": firstName,
        "lastName": lastName,

        /// FIREBASE
        "academicProgramId": academicProgramId,

        "gender": gender,
        "birthDate": "${birthDate.year.toString().padLeft(4, '0')}-"
            "${birthDate.month.toString().padLeft(2, '0')}-"
            "${birthDate.day.toString().padLeft(2, '0')}",
        "email": email,
        "phone": phone,
        "photoUrl": photoUrl,
      };
}
