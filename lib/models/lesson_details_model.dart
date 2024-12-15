// import 'dart:convert';

// class LessonDetails {
//   final String name;
//   final String title;
//   final String body;
//   final String pdfFileUrl;

//   LessonDetails({
//     required this.name,
//     required this.title,
//     required this.body,
//     required this.pdfFileUrl,
//   });

//   factory LessonDetails.fromJson(Map<String, dynamic> json) {
//     // Parse the content field and extract the PDF URL
//     final content = json['content'] != null ? jsonDecode(json['content']) : {};
//     String pdfUrl = '';
//     if (content['blocks'] != null) {
//       for (var block in content['blocks']) {
//         if (block['type'] == 'upload' && block['data']['file_type'] == 'PDF') {
//           pdfUrl = block['data']['file_url'] ?? '';
//           break;
//         }
//       }
//     }

//     return LessonDetails(
//       name: json['name'] ?? '',
//       title: json['title'] ?? '',
//       body: json['body'] ?? '',
//       pdfFileUrl: pdfUrl,
//     );
//   }
// }
import 'dart:convert';

// class LessonDetails {
//   final String name;
//   final String title;
//   final String body;
//   final List<ContentBlock> contentBlocks;

//   LessonDetails({
//     required this.name,
//     required this.title,
//     required this.body,
//     required this.contentBlocks,
//   });

//   factory LessonDetails.fromJson(Map<String, dynamic> json) {
//     // Parse the content field and extract the blocks
//     final content = json['content'] != null ? jsonDecode(json['content']) : {};
//     List<ContentBlock> blocks = [];
//     if (content['blocks'] != null) {
//       blocks = (content['blocks'] as List)
//           .map((block) => ContentBlock.fromJson(block))
//           .toList();
//     }

//     return LessonDetails(
//       name: json['name'] ?? '',
//       title: json['title'] ?? '',
//       body: json['body'] ?? '',
//       contentBlocks: blocks,
//     );
//   }
// }

// class ContentBlock {
//   final String id;
//   final String type;
//   final Map<String, dynamic> data;

//   ContentBlock({
//     required this.id,
//     required this.type,
//     required this.data,
//   });

//   factory ContentBlock.fromJson(Map<String, dynamic> json) {
//     return ContentBlock(
//       id: json['id'] ?? '',
//       type: json['type'] ?? '',
//       data: json['data'] ?? {},
//     );
//   }

//   // Helper methods to extract specific data based on block type
//   String get text => data['text'] ?? '';
//   List<dynamic> get listItems => data['items'] ?? [];
//   List<List<dynamic>> get tableContent => data['content'] ?? [];
//   String get fileUrl => data['file_url'] ?? '';
//   String get fileType => data['file_type'] ?? '';
//   String get code => data['code'] ?? '';
//   String get language => data['language'] ?? '';
// }

class LessonDetails {
  final String name;
  final String title;
  final String body;
  final List<ContentBlock> contentBlocks;

  LessonDetails({
    required this.name,
    required this.title,
    required this.body,
    required this.contentBlocks,
  });

  factory LessonDetails.fromJson(Map<String, dynamic> json) {
    // Parse the content field
    List<ContentBlock> parsedContentBlocks = [];
    if (json['content'] != null) {
      final contentJson = jsonDecode(json['content']);
      if (contentJson['blocks'] != null) {
        parsedContentBlocks = (contentJson['blocks'] as List)
            .map((block) => ContentBlock.fromJson(block))
            .toList();
      }
    }

    return LessonDetails(
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      contentBlocks: parsedContentBlocks,
    );
  }
}

class ContentBlock {
  final String type;
  final Map<String, dynamic> data;

  // Getters for specific types of data
  String get text => data['text'] ?? '';
  List<List<dynamic>> get tableContent {
    if (type == 'table' && data['content'] != null) {
      final table = data['content'];
      return List<List<dynamic>>.from(
        table.map((row) => List<dynamic>.from(row)),
      );
    }
    return [];
  }

  List<String> get listItems {
    if (type == 'list' && data['items'] != null) {
      return List<String>.from(
        data['items'].map((item) => item['content'] as String),
      );
    }
    return [];
  }

  String get fileUrl => data['file_url'] ?? '';
  String get fileType => data['file_type'] ?? '';
  String get code => data['code'] ?? '';
  String get language => data['language'] ?? '';

  ContentBlock({required this.type, required this.data});

  factory ContentBlock.fromJson(Map<String, dynamic> json) {
    return ContentBlock(
      type: json['type'] ?? '',
      data: json['data'] ?? {},
    );
  }
}