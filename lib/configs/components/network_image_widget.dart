import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'loading_widget.dart';

// Generic network image widget providing global consistency for Ease'TUBE
class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final double width, height, borderRadius, iconSize;
  final BoxFit boxFit;

  const NetworkImageWidget({
    super.key,
    required this.imageUrl,
    this.width = 40,
    this.height = 40,
    this.borderRadius = 18,
    this.iconSize = 20,
    this.boxFit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: imageUrl == ''
          // Fallback for empty URLs, often used for default profile placeholders
          ? Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Icon(Icons.person_outline, size: iconSize),
            )
          : CachedNetworkImage(
              imageUrl: imageUrl,
              width: width,
              height: height,
              // Custom builder to apply consistent border radii to the loaded image
              imageBuilder: (context, imageProvider) => Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  image: DecorationImage(image: imageProvider, fit: boxFit),
                ),
              ),
              // Shows the localized LoadingWidget while the asset is being fetched
              placeholder: (context, url) => Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: LoadingWidget(),
                ),
              ),
              // Handles broken links or network failures gracefully
              errorWidget: (context, url, error) => Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                child: Icon(Icons.error_outline, size: iconSize),
              ),
            ),
    );
  }
}
