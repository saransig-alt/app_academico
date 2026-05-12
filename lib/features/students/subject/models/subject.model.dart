// To parse this JSON data, do
//
//     final subjectResponse = subjectResponseFromJson(jsonString);

import 'dart:convert';

SubjectResponse subjectResponseFromJson(String str) =>
    SubjectResponse.fromJson(json.decode(str));

String subjectResponseToJson(SubjectResponse data) =>
    json.encode(data.toJson());

class SubjectResponse {
  List<Subject> subjects;

  SubjectResponse({
    required this.subjects,
  });

  factory SubjectResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      SubjectResponse(
        subjects: List<Subject>.from(
          json["subjects"].map(
            (x) => Subject.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "subjects": List<dynamic>.from(
          subjects.map(
            (x) => x.toJson(),
          ),
        ),
      };
}

class Subject {
  int id;
  String code;
  String name;
  int credits;
  int hours;
  KnowledgeArea knowledgeArea;

  Subject({
    required this.id,
    required this.code,
    required this.name,
    required this.credits,
    required this.hours,
    required this.knowledgeArea,
  });

  factory Subject.fromJson(
    Map<String, dynamic> json,
  ) =>
      Subject(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        credits: json["credits"],
        hours: json["hours"],
        knowledgeArea: KnowledgeArea.fromJson(
          json["knowledgeArea"],
        ),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "credits": credits,
        "hours": hours,
        "knowledgeArea": knowledgeArea.toJson(),
      };
}

class KnowledgeArea {
  String name;
  String career;
  String level;

  KnowledgeArea({
    required this.name,
    required this.career,
    required this.level,
  });

  factory KnowledgeArea.fromJson(
    Map<String, dynamic> json,
  ) =>
      KnowledgeArea(
        name: json["name"],
        career: json["career"],
        level: json["level"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "career": career,
        "level": level,
      };
}
