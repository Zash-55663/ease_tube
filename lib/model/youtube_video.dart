// Data model representing a YouTube video throughout the Ease'TUBE application
class YoutubeVideo {
  final String title;
  final String thumbnailUrl;
  final String videoId;

  YoutubeVideo({
    required this.title,
    required this.thumbnailUrl,
    required this.videoId,
  });

  // A factory constructor to create an instance from JSON with safety checks
  factory YoutubeVideo.fromJson(Map<String, dynamic> json) {
    // Logic to handle different YouTube API response structures (Search vs. Video objects)
    // It checks if 'id' is a Map (common in Search API) or a direct String
    final String extractedId = json['id'] is Map
        ? (json['id']['videoId'] ?? '')
        : (json['id'] ?? '');

    return YoutubeVideo(
      videoId: extractedId,
      // Provides fallback values to prevent null-pointer errors in the UI
      title: json['snippet']['title'] ?? 'No Title',
      thumbnailUrl: json['snippet']['thumbnails']['high']['url'] ?? '',
    );
  }
}
