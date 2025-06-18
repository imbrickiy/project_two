import 'package:flutter/material.dart';

class GridLayoutProvider extends StatelessWidget {
  final double itemWidth;
  final double spacing;
  final Widget Function(BuildContext context, int crossAxisCount) builder;

  const GridLayoutProvider({
    super.key,
    required this.itemWidth,
    required this.spacing,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = (constraints.maxWidth / (itemWidth + spacing))
            .floor();
        crossAxisCount = constraints.maxWidth < 200
            ? 1
            : crossAxisCount.clamp(1, 100);
        return builder(context, crossAxisCount);
      },
    );
  }
}
