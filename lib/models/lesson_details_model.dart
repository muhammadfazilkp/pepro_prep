import 'dart:convert';

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
