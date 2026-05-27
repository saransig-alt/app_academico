// To parse this JSON data, do
//
//     final academicProgramResponse = academicProgramResponseFromJson(jsonString);

import 'dart:convert';

AcademicProgramResponse academicProgramResponseFromJson(String str) => AcademicProgramResponse.fromJson(json.decode(str));

String academicProgramResponseToJson(AcademicProgramResponse data) => json.encode(data.toJson());

class AcademicProgramResponse {
    List<AcademicProgram> academicProgram;

    AcademicProgramResponse({
        required this.academicProgram,
    });

    factory AcademicProgramResponse.fromJson(Map<String, dynamic> json) => AcademicProgramResponse(
        academicProgram: List<AcademicProgram>.from(json["academic_program"].map((x) => AcademicProgram.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "academic_program": List<dynamic>.from(academicProgram.map((x) => x.toJson())),
    };
}

class AcademicProgram {
    int id;
    String name;

    AcademicProgram({
        required this.id,
        required this.name,
    });

    factory AcademicProgram.fromJson(Map<String, dynamic> json) => AcademicProgram(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
