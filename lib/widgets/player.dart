import 'package:flutter/material.dart';

class StationPlayer extends StatefulWidget {
  const StationPlayer({super.key});

  @override
  State<StationPlayer> createState() => _StationPlayerState();
}

class _StationPlayerState extends State<StationPlayer> {
  bool _isSourceSet = false;
  // late PlayerProvider playerProvider;
  //
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   playerProvider = Provider.of<PlayerProvider>(context, listen: false);
  //   if (!_isSourceSet) {
  //     Provider.of<PlayerProvider>(
  //       context,
  //       listen: false,
  //     ).setSource("https://listen.powerapp.com.tr/powerdeep/abr/playlist.m3u8");
  //     _isSourceSet = true;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // final playerProvider = Provider.of<PlayerProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Station Name",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: playerProvider.isPlaying
            //       ? () => playerProvider.stop()
            //       : () => playerProvider.play(),
            //   child: Text(playerProvider.isPlaying ? "Stop" : "Play"),
            // ),
            // ElevatedButton(
            //   onPressed: playerProvider.isPlaying
            //       ? () => playerProvider.pause()
            //       : null,
            //   child: const Text("Pause"),
            // ),
          ],
        ),
      ),
    );
  }
}
