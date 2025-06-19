import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_two/station_screen.dart';
import 'package:project_two/widgets/layout_widget.dart';

import 'model/stations.dart';

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
          padding: const EdgeInsets.all(spacing),
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
      color: const Color(0xFF262626),
      borderRadius: BorderRadius.circular(12),
      elevation: 3,
      child: InkWell(
        splashColor: const Color(0xFFf2581f).withAlpha(30),
        highlightColor: const Color(0xFFf2581f).withAlpha(30),
        borderRadius: BorderRadius.circular(12),
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
                              color: Color(0xFFf2581f),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error, color: Colors.red),
                        )
                      : const SizedBox(),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
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
