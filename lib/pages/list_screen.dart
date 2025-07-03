import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_two/common/colors.dart';
import 'package:project_two/pages/station_screen.dart';
import 'package:project_two/states/station_player_state.dart';
import 'package:project_two/widgets/layout_widget.dart';
import 'package:provider/provider.dart';

import '../model/stations.dart';

class FixedSizeGrid extends StatelessWidget {
  final List<Station> stations;

  const FixedSizeGrid({super.key, required this.stations});

  @override
  Widget build(BuildContext context) {
    const double itemWidth = 120;
    const double spacing = 16;
    return GridLayoutProvider(
      itemWidth: itemWidth,
      spacing: spacing,
      builder: (context, crossAxisCount) {
        return GridView.builder(
          padding: const EdgeInsets.only(
            left: spacing,
            right: spacing,
            bottom: spacing,
            top: kToolbarHeight + 16, // 16 is extra spacing, adjust as needed
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            mainAxisExtent: 140,
          ),
          itemCount: stations.length,
          itemBuilder: (context, index) {
            final station = stations[index];
            return SizedBox(
              width: itemWidth,
              height: 140,
              child: GridItem(
                imageUrl: station.iconGray ?? '',
                title: station.title ?? '',
                onTap: () => _openStationScreen(context, station),
              ),
            );
          },
        );
      },
    );
  }

  void _openStationScreen(BuildContext context, Station station) {
    final playerProvider = Provider.of<PlayerProvider>(context, listen: false);
    playerProvider.setSource(
      station.streamHls ??
          'https://listen.powerapp.com.tr/powerdeep/abr/playlist.m3u8',
    );
    playerProvider.isPlaying
        ? (playerProvider.stop(), playerProvider.play())
        : playerProvider.play();
    playerProvider.setStationName(station.title ?? '');
    playerProvider.setStationImage(station.iconGray ?? '');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StationScreen(
          stationName: station.title ?? '',
          stationUrl: station.streamHls ?? '',
          stationImage: station.iconGray ?? '',
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;

  const GridItem({
    super.key,
    required this.title,
    required this.onTap,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.background,
      borderRadius: BorderRadius.circular(12),
      elevation: 3,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        splashColor: AppColors.primary.withValues(
          alpha: 0.3, // Adjust alpha for splash effect
        ),
        highlightColor: AppColors.primary,
        onTap: onTap,
        child: Container(
          alignment: Alignment.bottomCenter,
          height: 140,
          width: 120,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: imageUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: imageUrl,
                          width: double.infinity,
                          fit: BoxFit.contain,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error, color: AppColors.error),
                        )
                      : const SizedBox(),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
