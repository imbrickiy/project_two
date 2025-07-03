import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class StationPlayerWidget extends StatefulWidget {
  final String stationName;
  final String stationUrl;
  final String stationImage;
  const StationPlayerWidget({
    super.key,
    required this.stationName,
    required this.stationUrl,
    required this.stationImage,
  });

  @override
  State<StationPlayerWidget> createState() => _StationPlayerWidgetState();
}

class _StationPlayerWidgetState extends State<StationPlayerWidget>
    with WidgetsBindingObserver {
  late final ValueNotifier<double> volumeNotifier;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    volumeNotifier = ValueNotifier<double>(1.0);
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.stationName,
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Center(child: StationImage(imageUrl: widget.stationImage)),
        // ControlButtons(_player, volumeNotifier: volumeNotifier),
      ],
    );
  }
}

class StationImage extends StatelessWidget {
  final String imageUrl;
  const StationImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: 300,
        height: 300,
        fit: BoxFit.contain,
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) =>
            const Icon(Icons.error, color: Colors.red, size: 64),
      ),
    );
  }
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;
  final ValueNotifier<double> volumeNotifier;

  const ControlButtons(this.player, {super.key, required this.volumeNotifier});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 64, maxWidth: 240),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [_PlayStopButton(player: player)],
          ),
        );
      },
    );
  }
}

class _PlayStopButton extends StatelessWidget {
  final AudioPlayer player;

  const _PlayStopButton({required this.player});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: player.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing ?? false;

        Widget buttonChild;
        VoidCallback? onPressed;

        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) {
          buttonChild = const CircularProgressIndicator();
          onPressed = null;
        } else if (!playing) {
          buttonChild = const Icon(Icons.play_arrow, size: 64.0);
          onPressed = player.play;
        } else {
          buttonChild = const Icon(
            Icons.stop,
            size: 64.0,
            color: Colors.orange,
          );
          onPressed = player.stop;
        }

        return SizedBox(
          width: 128.0,
          height: 128.0,
          child: IconButton(
            icon: buttonChild,
            iconSize: 64.0,
            onPressed: onPressed,
          ),
        );
      },
    );
  }
}
