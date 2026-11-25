import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

/// Portfolio project synchronized with the Django REST Framework API.
@JsonSerializable(fieldRename: FieldRename.snake)
class Project {
  const Project({
    required this.title,
    required this.description,
    required this.category,
    this.thumbnail,
    this.startedAt,
    this.endedAt,
    this.starCount = 0,
    this.isStarred = false,
    this.starredByNames = '',
    this.id,
  });

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  @JsonKey(includeToJson: false)
  final String? id;
  final String title;
  final String description;
  final String category;
  final String? thumbnail;
  final String? startedAt;
  final String? endedAt;

  @JsonKey(defaultValue: 0)
  final int starCount;

  @JsonKey(defaultValue: false)
  final bool isStarred;

  @JsonKey(defaultValue: '')
  final String starredByNames;

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
