// lib/widgets/app_footer.dart
import 'package:flutter/material.dart';
import 'package:project_two/common/colors.dart';
import 'package:project_two/components/wave_icon_button.dart';
import 'package:project_two/states/station_player_state.dart';
import 'package:provider/provider.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final playerProvider = Provider.of<PlayerProvider>(context);
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.55 * 255).round()),
            offset: const Offset(0, -5), // Shadow at the top
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) =>
                FadeTransition(opacity: animation, child: child),
            child: Text(
              playerProvider.isPlaying
                  ? 'Now Playing: ${playerProvider.stationName}'
                  : 'Select a station to play',
              key: ValueKey(
                playerProvider.isPlaying
                    ? playerProvider.stationName
                    : 'select',
              ),
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          WaveIconButton(
            icon: Icon(
              playerProvider.isPlaying ? Icons.stop : Icons.play_arrow,
              size: 32.0,
              color: AppColors.primary,
            ),
            onPressed: () {
              playerProvider.isPlaying
                  ? playerProvider.stop()
                  : playerProvider.play();
            },
            active: playerProvider.isPlaying, // Волны, если активна
          ),
        ],
      ),
    );
  }
}
