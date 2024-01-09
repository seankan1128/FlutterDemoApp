import 'package:json_annotation/json_annotation.dart';

part 'album.g.dart';

@JsonSerializable()
class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  // factory Album.fromJson(Map<String, dynamic> json) {
  //   return switch (json) {
  //     {
  //     'userId': int userId,
  //     'id': int id,
  //     'title': String title,
  //     } =>
  //         Album(
  //           userId: userId,
  //           id: id,
  //           title: title,
  //         ),
  //     _ => throw const FormatException('Failed to load album.'),
  //   };
  // }

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}