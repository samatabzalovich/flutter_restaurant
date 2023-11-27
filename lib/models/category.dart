import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Category {
  final int id;
  final String name;
  Category({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

}
