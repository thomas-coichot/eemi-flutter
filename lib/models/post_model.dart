import 'package:flutter_5_wd/models/user_model.dart';

class PostModel {
  final String id;
  final String url;
  final String? description;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserModel? user;

  const PostModel({
    required this.id,
    required this.url,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    this.description,
    this.user,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      url: json['url'],
      description: json['description'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }
}
