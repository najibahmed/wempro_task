// To parse this JSON data, do
//
//     final formFieldModel = formFieldModelFromJson(jsonString);

import 'dart:convert';

FormFieldModel formFieldModelFromJson(String str) => FormFieldModel.fromJson(json.decode(str));

String formFieldModelToJson(FormFieldModel data) => json.encode(data.toJson());

class FormFieldModel {
  String message;
  String assignmentInstructionUrl;
  String information;
  JsonResponse jsonResponse;

  FormFieldModel({
    required this.message,
    required this.assignmentInstructionUrl,
    required this.information,
    required this.jsonResponse,
  });

  factory FormFieldModel.fromJson(Map<String, dynamic> json) => FormFieldModel(
    message: json["message"],
    assignmentInstructionUrl: json["assignmentInstructionUrl"],
    information: json["information"],
    jsonResponse: JsonResponse.fromJson(json["json_response"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "assignmentInstructionUrl": assignmentInstructionUrl,
    "information": information,
    "json_response": jsonResponse.toJson(),
  };
}

class JsonResponse {
  List<Attribute> attributes;

  JsonResponse({
    required this.attributes,
  });

  factory JsonResponse.fromJson(Map<String, dynamic> json) => JsonResponse(
    attributes: List<Attribute>.from(json["attributes"].map((x) => Attribute.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
  };
}

class Attribute {
  String id;
  String title;
  String type;
  List<String> options;

  Attribute({
    required this.id,
    required this.title,
    required this.type,
    required this.options,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    id: json["id"],
    title: json["title"],
    type: json["type"],
    options: List<String>.from(json["options"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "type": type,
    "options": List<dynamic>.from(options.map((x) => x)),
  };
}
