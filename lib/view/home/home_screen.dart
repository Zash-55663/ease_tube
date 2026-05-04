import 'package:ease_tube/configs/colors/app_colors.dart';
import 'package:ease_tube/model/youtube_video.dart';
import 'package:ease_tube/services/youtube_service/youtube_service.dart';
import 'package:ease_tube/view/home/widgets/grid_view_widget.dart';
import 'package:flutter/material.dart';

import '../../configs/routes/routes_name.dart';

// The primary dashboard for Ease'TUBE displaying search and video feeds
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controller to capture and manage user search input
  final TextEditingController _searchController = TextEditingController();

  // Default query to load trending content on initial startup
  String _currentQuery = "trending";

  @override
  void dispose() {
    // Standard cleanup to release text controller resources
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        // Inline search bar within the AppBar for quick content discovery
        title: TextField(
          controller: _searchController,
          style: const TextStyle(
            color: AppColors.secondaryText,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            prefixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // Triggers search when the icon is manually tapped
                setState(() {
                  _currentQuery = _searchController.text;
                });
              },
            ),
            hintText: "Search Ease'TUBE...",
            hintStyle: const TextStyle(color: AppColors.primaryText),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
          ),
          onSubmitted: (value) {
            // Refreshes the UI with results for the entered search term
            setState(() {
              _currentQuery = value;
            });
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: InkWell(
              // Direct access to account settings and user profile details
              onTap: () {
                Navigator.pushNamed(context, RoutesName.userProfile);
              },
              child: const Icon(Icons.account_circle, size: 28),
            ),
          ),
        ],
      ),
      // Automatically fetches and displays video data based on the current query
      body: FutureBuilder<List<YoutubeVideo>>(
        future: fetchYouTubeVideos(_currentQuery),
        builder: (context, snapshot) {
          // Displays the primary brand loader while fetching API data
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // Basic error handling for network or API failures
          else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          // Handles empty states if no videos match the query
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No videos found"));
          }

          // Renders the retrieved video list into a modular grid layout
          return GridViewWidget(videos: snapshot.data!);
        },
      ),
    );
  }
}
