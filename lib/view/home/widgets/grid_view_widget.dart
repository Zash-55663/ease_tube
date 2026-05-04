import 'package:flutter/material.dart';
import '../../../model/youtube_video.dart';
import 'full_video_player_widget.dart';

// Renders a responsive grid of YouTube video thumbnails and titles
class GridViewWidget extends StatelessWidget {
  // Receives the dynamic list of videos fetched from the YouTube API
  final List<YoutubeVideo> videos;

  const GridViewWidget({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      // shrinkWrap and physics allow this grid to exist inside a scrolling parent if needed
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: videos.length,
      // Configures a 2-column layout optimized for mobile screens like the iPhone Xs
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8, // Adjusts the height-to-width ratio of each card
      ),
      itemBuilder: (context, index) {
        final video = videos[index];

        return GestureDetector(
          // Navigates to the dedicated player screen when a video card is tapped
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    FullVideoPlayerWidget(videoId: video.videoId),
              ),
            );
          },
          child: Card(
            clipBehavior: Clip
                .antiAlias, // Ensures the thumbnail doesn't bleed past rounded corners
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Video thumbnail section
                Expanded(
                  child: Image.network(
                    video.thumbnailUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    // Displays a fallback icon if the network image fails to load
                    errorBuilder: (context, error, stackTrace) =>
                        const Center(child: Icon(Icons.broken_image)),
                  ),
                ),
                // Video title section with text overflow protection
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    video.title,
                    maxLines:
                        2, // Prevents long titles from breaking the card layout
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
