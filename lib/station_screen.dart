import 'package:flutter/material.dart';
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
          icon: const Icon(Icons.arrow_back, color: Colors.orange, size: 32),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actionsPadding: const EdgeInsets.only(right: 16.0),
        actions: [
          IconButton(
            icon: const Icon(Icons.info, color: Colors.orange),
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
      backgroundColor: const Color(0xFF141414),
      // bottomNavigationBar: CustomBottomNavigationBar(
      //   currentIndex: 0,
      //   context: context,
      // ),
      body: SafeArea(
        child: StationPlayerWidget(
          stationName: stationName,
          stationUrl: stationUrl,
          stationImage: stationImage,
        ),
      ),
    );
  }
}
