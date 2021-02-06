import 'package:json_annotation/json_annotation.dart';
part 'Comments.g.dart';

@JsonSerializable()
class Comments {
  Comments(
    this.postId,
    this.id,
    this.name,
    this.email,
    this.body,
  );

  int postId;
  int id;
  String name;
  String email;
  String body;
  factory Comments.fromJson(Map<String, dynamic> json) =>
      _$CommentsFromJson(json);
  Map<String, dynamic> toJson() => _$CommentsToJson(this);
}
