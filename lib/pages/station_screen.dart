import 'package:flutter/material.dart';
import 'package:project_two/common/colors.dart';
import 'package:project_two/widgets/layout_with_footer.dart';
import 'package:project_two/widgets/station_player_widget.dart';

class StationScreen extends StatelessWidget {
  final String stationName;
  final String stationUrl;
  final String stationImage;

  const StationScreen({
    super.key,
    required this.stationName,
    required this.stationUrl,
    required this.stationImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primary,
            size: 32,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,

        centerTitle: true,
        actionsPadding: const EdgeInsets.only(right: 16.0),
        actions: [
          IconButton(
            icon: const Icon(Icons.info, color: AppColors.primary),
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationIcon: const Icon(Icons.radio),
                children: [const Text("This is a sample radio player app.")],
              );
            },
          ),
        ],
      ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutWithFooter(
          child: StationPlayerWidget(
            stationName: stationName,
            stationUrl: stationUrl,
            stationImage: stationImage,
          ),
        ),
      ),
    );
  }
}
