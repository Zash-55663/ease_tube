import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../../model/youtube_video.dart';

// Asynchronously fetches video data from YouTube based on a search string
Future<List<YoutubeVideo>> fetchYouTubeVideos(String query) async {
  // Personal API Key for Google Cloud Console access
  const String apiKey = 'AIzaSyCHSB_VHTVqiZjmJJ6lc-0yLTwZ6wrT44c';

  // Defaults to 'trending' if the search bar is empty to keep the feed populated
  final String searchQuery = query.isEmpty ? 'trending' : query;

  // Constructs the GET request URL with snippet data and a 10-video limit
  final String url =
      'https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=10&q=$searchQuery&type=video&key=$apiKey';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // Decodes the raw response body into a Map
    Map<String, dynamic> data = json.decode(response.body);
    List<dynamic> items = data['items'];

    // Maps the JSON 'items' list to a List of YoutubeVideo model instances
    return items.map((item) {
      return YoutubeVideo(
        title: item['snippet']['title'],
        thumbnailUrl: item['snippet']['thumbnails']['high']['url'],
        videoId: item['id']['videoId'],
      );
    }).toList();
  } else {
    // Prints detailed error info (like 403 Quota Exceeded) to the debug console
    debugPrint("YouTube API Error: ${response.body}");
    throw Exception('Failed to load videos: ${response.statusCode}');
  }
}
