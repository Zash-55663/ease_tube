import 'package:ease_tube/configs/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// A specialized widget that handles YouTube video playback and player controls
class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerWidget({super.key, required this.videoUrl});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Extracts the unique YouTube ID from a full URL (e.g., watch?v=...)
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);

    // Configures the playback behavior and initial state
    _controller = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: const YoutubePlayerFlags(
        autoPlay: false, // Prevents immediate playback to save user data
        mute: false,
        isLive: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Builder handles orientation changes and full-screen transitions automatically
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        // Aligns the player theme with Ease'TUBE brand colors
        progressIndicatorColor: AppColors.primary,
        progressColors: const ProgressBarColors(
          playedColor: AppColors.primary,
          handleColor: AppColors.textButton,
        ),
      ),
      builder: (context, player) {
        return Column(
          children: [
            // The actual YouTube video frame
            player,
            const SizedBox(height: 10),
            // Custom branding label below the player
            const Text(
              "Ease'TUBE Video Player",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // Crucial for performance: stops playback and releases player memory
    _controller.dispose();
    super.dispose();
  }
}
