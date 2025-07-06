import 'video.dart';

class Category {
  final int id;
  final String name;
  final List<Video> videos;

  Category({
    required this.id,
    required this.name,
    required this.videos,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      videos: (json['videos'] as List)
          .map((video) => Video.fromJson(video))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'videos': videos.map((video) => video.toJson()).toList(),
    };
  }
}
