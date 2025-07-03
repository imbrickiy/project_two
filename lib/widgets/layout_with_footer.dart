// lib/widgets/layout_with_footer.dart
import 'package:flutter/material.dart';
import 'package:project_two/common/colors.dart';
import 'package:project_two/widgets/footer_widget.dart';

class LayoutWithFooter extends StatelessWidget {
  final Widget child;

  const LayoutWithFooter({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: child,
      bottomNavigationBar: FooterWidget(),
    );
  }
}
