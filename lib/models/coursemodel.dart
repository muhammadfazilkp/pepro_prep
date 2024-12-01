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

  Data(
      {this.name,
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
      this.doctype});

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
}
