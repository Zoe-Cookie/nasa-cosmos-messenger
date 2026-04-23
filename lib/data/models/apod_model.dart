class ApodModel {
  final String date;
  final String explanation;
  final String title;
  final String url;
  final String mediaType;
  final String? thumbnailUrl;

  ApodModel({
    required this.date,
    required this.explanation,
    required this.title,
    required this.url,
    required this.mediaType,
    this.thumbnailUrl,
  });

  factory ApodModel.fromJson(Map<String, dynamic> json) {
    return ApodModel(
      date: json['date'] ?? '',
      explanation: json['explanation'] ?? '',
      title: json['title'] ?? '',
      url: json['url'] ?? '',
      mediaType: json['media_type'] ?? '',
      thumbnailUrl: json['thumbnail_url'],
    );
  }
  
  String get displayImageUrl => mediaType == 'video' ? (thumbnailUrl ?? '') : url;
  bool get isVideo => mediaType == 'video';
  String? get videoUrl => isVideo ? url : null;

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'explanation': explanation,
      'title': title,
      'url': url,
      'media_type': mediaType,
      'thumbnail_url': thumbnailUrl,
    };
  }
}