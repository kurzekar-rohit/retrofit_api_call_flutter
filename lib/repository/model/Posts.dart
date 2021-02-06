import 'package:json_annotation/json_annotation.dart';
part 'Posts.g.dart';

@JsonSerializable()
class Posts {
  Posts(
    this.userId,
    this.id,
    this.title,
    this.body,
  );

  int userId;
  int id;
  String title;
  String body;

  factory Posts.fromJson(Map<String, dynamic> json) => _$PostsFromJson(json);
  Map<String, dynamic> toJson() => _$PostsToJson(this);
}
