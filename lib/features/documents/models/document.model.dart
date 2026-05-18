// To parse this JSON data, do
//
//     final documentResponse = documentResponseFromJson(jsonString);

import 'dart:convert';

DocumentResponse documentResponseFromJson(String str) =>
    DocumentResponse.fromJson(json.decode(str));

String documentResponseToJson(DocumentResponse data) =>
    json.encode(data.toJson());

class DocumentResponse {
  List<Document> documents;

  DocumentResponse({
    required this.documents,
  });

  factory DocumentResponse.fromJson(Map<String, dynamic> json) =>
      DocumentResponse(
        documents: List<Document>.from(
            json["documents"].map((x) => Document.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "documents": List<dynamic>.from(documents.map((x) => x.toJson())),
      };
}

class Document {
  int id;
  String documentNumber;
  String type;
  String title;
  String description;
  int studentId;
  String sender;
  String receiver;
  String department;
  String status;
  String priority;
  DateTime createdAt;
  DateTime? approvedAt; 
  List<String> attachments;
  String verificationCode;

  Document({
    required this.id,
    required this.documentNumber,
    required this.type,
    required this.title,
    required this.description,
    required this.studentId,
    required this.sender,
    required this.receiver,
    required this.department,
    required this.status,
    required this.priority,
    required this.createdAt,
    this.approvedAt,
    required this.attachments,
    required this.verificationCode,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        id: json["id"],
        documentNumber: json["documentNumber"],
        type: json["type"],
        title: json["title"],
        description: json["description"],
        studentId: json["studentId"],
        sender: json["sender"],
        receiver: json["receiver"],
        department: json["department"],
        status: json["status"],
        priority: json["priority"],
        createdAt: DateTime.parse(json["createdAt"]),
        approvedAt: json["approvedAt"] != null ? DateTime.parse(json["approvedAt"]) : null,
        attachments: List<String>.from(json["attachments"].map((x) => x)),
        verificationCode: json["verificationCode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "documentNumber": documentNumber,
        "type": type,
        "title": title,
        "description": description,
        "studentId": studentId,
        "sender": sender,
        "receiver": receiver,
        "department": department,
        "status": status,
        "priority": priority,
        "createdAt":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "approvedAt": approvedAt != null
            ? "${approvedAt!.year.toString().padLeft(4, '0')}-${approvedAt!.month.toString().padLeft(2, '0')}-${approvedAt!.day.toString().padLeft(2, '0')}"
            : null,
        "attachments": List<dynamic>.from(attachments.map((x) => x)),
        "verificationCode": verificationCode,
      };
}