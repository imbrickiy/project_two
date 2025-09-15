import 'package:flutter/material.dart';

class StationPlayer extends StatefulWidget {
  const StationPlayer({super.key});

  @override
  State<StationPlayer> createState() => _StationPlayerState();
}

class _StationPlayerState extends State<StationPlayer> {
  @override
  Widget build(BuildContext context) {
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
          ],
        ),
      ),
    );
  }
}
