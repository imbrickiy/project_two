import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class StationPlayerWidget extends StatelessWidget {
  final String stationName;
  final String stationUrl;
  final String stationImage;
  const StationPlayerWidget({
    super.key,
    required this.stationName,
    required this.stationUrl,
    required this.stationImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          stationName,
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Center(child: StationImage(imageUrl: stationImage)),
      ],
    );
  }
}

class StationImage extends StatelessWidget {
  final String imageUrl;
  const StationImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: 300,
        height: 300,
        fit: BoxFit.contain,
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) =>
            const Icon(Icons.error, color: Colors.red, size: 64),
      ),
    );
  }
}
