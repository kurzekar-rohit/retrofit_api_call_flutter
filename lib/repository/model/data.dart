import 'package:json_annotation/json_annotation.dart';
part 'data.g.dart';

@JsonSerializable()
class User {
  User({
    this.id,
    this.name,
    this.username,
    this.email,
    // this.address,
    this.phone,
    this.website,
    // this.company,
  });

  int id;
  String name;
  String username;
  String email;
  // Address address;
  String phone;
  String website;
  // Company company;
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
