import 'package:ease_tube/configs/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// A dedicated full-screen playback environment for Ease'TUBE videos
class FullVideoPlayerWidget extends StatefulWidget {
  final String videoId;
  const FullVideoPlayerWidget({super.key, required this.videoId});

  @override
  State<FullVideoPlayerWidget> createState() => _FullVideoPlayerWidgetState();
}

class _FullVideoPlayerWidgetState extends State<FullVideoPlayerWidget> {
  late YoutubePlayerController _controller;
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();
    // Initializes the player with autoPlay enabled for a seamless transition from the grid
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: true,
        forceHD: false,
      ),
    )..addListener(_onControllerChange);
  }

  // Listener to track playback states and capture potential API or network errors
  void _onControllerChange() {
    if (_controller.value.hasError) {
      debugPrint("Player Error Code: ${_controller.value.errorCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Center(
        child: GestureDetector(
          // Implements intuitive double-tap gestures to seek forward or backward
          onDoubleTapDown: (details) {
            final screenWidth = MediaQuery.of(context).size.width;
            if (details.globalPosition.dx > screenWidth / 2) {
              // Skip forward 10 seconds on the right side of the screen
              _controller.seekTo(
                _controller.value.position + const Duration(seconds: 10),
              );
            } else {
              // Skip backward 10 seconds on the left side of the screen
              _controller.seekTo(
                _controller.value.position - const Duration(seconds: 10),
              );
            }
          },
          child: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: AppColors.primary,
            // Customizes the bottom control bar for better user interaction
            bottomActions: [
              CurrentPosition(),
              ProgressBar(isExpanded: true),
              // Custom volume toggle button with dynamic icons
              IconButton(
                icon: Icon(
                  _isMuted ? Icons.volume_off : Icons.volume_up,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    if (_isMuted) {
                      _controller.unMute();
                    } else {
                      _controller.mute();
                    }
                    _isMuted = !_isMuted;
                  });
                },
              ),
              const PlaybackSpeedButton(),
              FullScreenButton(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Stops playback and removes the listener to prevent memory leaks
    _controller.removeListener(_onControllerChange);
    _controller.dispose();
    super.dispose();
  }
}
