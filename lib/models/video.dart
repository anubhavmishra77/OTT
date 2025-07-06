class Video {
  final int id;
  final String title;
  final String description;
  final String thumbnail;
  final String videoUrl;
  final String duration;
  final double rating;

  Video({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.videoUrl,
    required this.duration,
    required this.rating,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      thumbnail: json['thumbnail'],
      videoUrl: json['videoUrl'],
      duration: json['duration'],
      rating: json['rating'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'thumbnail': thumbnail,
      'videoUrl': videoUrl,
      'duration': duration,
      'rating': rating,
    };
  }
}
