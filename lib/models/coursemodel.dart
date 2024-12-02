import 'dart:convert';

import 'package:flutter/foundation.dart';

class Coureses {
  Data? data;

  Coureses({this.data});

  Coureses.fromJson(Map<String, dynamic> json) {
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (data != null) {
      _data["data"] = data?.toJson();
    }
    return _data;
  }
}

class Data {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? title;
  int? includeInPreview;
  String? chapter;
  int? isScormPackage;
  String? course;
  String? content;
  String? body;
  String? instructorContent;
  String? instructorNotes;
  String? fileType;
  String? doctype;

  // To store video URLs found in content
  List<String> videoUrls = [];

  Data({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.docstatus,
    this.idx,
    this.title,
    this.includeInPreview,
    this.chapter,
    this.isScormPackage,
    this.course,
    this.content,
    this.body,
    this.instructorContent,
    this.instructorNotes,
    this.fileType,
    this.doctype,
  });

  Data.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    owner = json["owner"];
    creation = json["creation"];
    modified = json["modified"];
    modifiedBy = json["modified_by"];
    docstatus = json["docstatus"];
    idx = json["idx"];
    title = json["title"];
    includeInPreview = json["include_in_preview"];
    chapter = json["chapter"];
    isScormPackage = json["is_scorm_package"];
    course = json["course"];
    content = json["content"];
    body = json["body"];
    instructorContent = json["instructor_content"];
    instructorNotes = json["instructor_notes"];
    fileType = json["file_type"];
    doctype = json["doctype"];

    // Parse the content field (which is a JSON string)
    if (content != null) {
      parseContent(content!);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["owner"] = owner;
    data["creation"] = creation;
    data["modified"] = modified;
    data["modified_by"] = modifiedBy;
    data["idx"] = idx;
    data["title"] = title;
    data["include_in_preview"] = includeInPreview;
    data["chapter"] = chapter;
    data["is_scorm_package"] = isScormPackage;
    data["course"] = course;
    data["content"] = content;
    data["body"] = body;
    data["instructor_content"] = instructorContent;
    data["instructor_notes"] = instructorNotes;
    data["file_type"] = fileType;
    data["doctype"] = doctype;
    return data;
  }

  // Parse the content field to extract video URLs
  void parseContent(String contentJson) {
    try {
      // Parse the content JSON string
      Map<String, dynamic> contentMap = json.decode(contentJson);

      // Loop through the blocks to extract video URLs from the "upload" type blocks
      List blocks = contentMap['blocks'] ?? [];
      for (var block in blocks) {
        if (block['type'] == 'upload') {
          var fileUrl = block['data']['file_url'];
          var fileType = block['data']['file_type'];

          // If file is a video (MP4 type), add the URL to the videoUrls list
          if (fileType != null && fileType == 'MP4') {
            videoUrls.add(fileUrl ?? '');
          }
        }
      }
    } catch (e) {
      debugPrint("Error parsing content JSON: $e");
    }
  }
}