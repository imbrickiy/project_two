import 'package:flutter/material.dart';
import 'package:project_two/widgets/layout_widget.dart';

import 'model/stations.dart';

class FixedSizeGrid extends StatelessWidget {
  final List items;

  const FixedSizeGrid({super.key, required this.items});

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
          itemCount: items.length,
          itemBuilder: (context, index) {
            final station = items[index];

            String title = ' ';
            String imageUrl = ' ';
            if (station is Station) {
              title = station.title ?? ' ';
              imageUrl = station.iconFillWhite.toString();
            } else {
              title = station.toString();
            }
            return SizedBox(
              width: itemWidth,
              height: 140,
              child: GridItem(
                imageUrl: imageUrl,
                title: title,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(title),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
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
                      ? Image(
                          image: NetworkImage(imageUrl),
                          width: double.infinity,
                          fit: BoxFit.contain,
                        )
                      : const SizedBox(),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
