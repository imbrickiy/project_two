import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:project_two/widgets/layout_widget.dart';

class StationScreen extends StatefulWidget {
  const StationScreen({super.key});

  @override
  State<StationScreen> createState() => _StationScreenState();
}

class _StationScreenState extends State<StationScreen>
    with WidgetsBindingObserver {
  final _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    _player.errorStream.listen((e) {
      print('A stream error occurred: $e');
    });
    try {
      await _player.setAudioSource(
        AudioSource.uri(
          Uri.parse(
            "https://listen.powerapp.com.tr/powerdeep/abr/playlist.m3u8",
          ),
        ),
      );
    } on PlayerException catch (e) {
      print("Error loading audio source: $e");
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _player.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    const double itemWidth = 120;
    const double spacing = 16;
    return GridLayoutProvider(
      itemWidth: itemWidth,
      spacing: spacing,
      builder: (context, crossAxisCount) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Power Deep"),
            centerTitle: true,
            actionsPadding: const EdgeInsets.only(right: 16.0),
            actions: [
              IconButton(
                icon: const Icon(Icons.info),
                onPressed: () {
                  showAboutDialog(
                    context: context,
                    // applicationName: "Power Deep",
                    // applicationVersion: "1.0.0",
                    applicationIcon: const Icon(Icons.radio),
                    children: [
                      const Text("This is a sample radio player app."),
                    ],
                  );
                },
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.all(16.0),
                    child: const CircleAvatar(
                      radius: 150.0,
                      backgroundImage: NetworkImage(
                        "https://canliradyotv.com.tr/upload/tv/b_power-deep-logo_20221001110829.png",
                      ), // Adjust scale as needed
                    ),
                  ),
                ),
                ControlButtons(_player),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  const ControlButtons(this.player, {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 240;
        return ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 64, maxWidth: 240),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _PlayPauseButton(player: player),
              if (!isCompact) ...[
                IconButton(
                  icon: const Icon(Icons.stop),
                  iconSize: 32.0,
                  onPressed: player.stop,
                ),
                StreamBuilder<double>(
                  stream: player.volumeStream,
                  builder: (context, snapshot) {
                    return RotatedBox(
                      quarterTurns: 0,
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Colors.blueAccent,
                          inactiveTrackColor: Colors.blue[100],
                          thumbColor: Colors.blue,
                          overlayColor: Colors.blue.withAlpha(32),
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 10.0,
                          ),
                          trackHeight: 4.0,
                        ),
                        child: Slider(
                          value: snapshot.data ?? 1.0,
                          min: 0.0,
                          max: 1.0,
                          onChanged: player.setVolume,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _PlayPauseButton extends StatelessWidget {
  final AudioPlayer player;

  const _PlayPauseButton({required this.player});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: player.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        Widget buttonChild;
        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) {
          buttonChild = const CircularProgressIndicator();
        } else if (playing != true) {
          buttonChild = const Icon(Icons.play_arrow, size: 32.0);
        } else if (processingState != ProcessingState.completed) {
          buttonChild = const Icon(Icons.pause, size: 32.0);
        } else {
          buttonChild = const Icon(Icons.replay, size: 32.0);
        }

        VoidCallback? onPressed;
        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) {
          onPressed = null;
        } else if (playing != true) {
          onPressed = player.play;
        } else if (processingState != ProcessingState.completed) {
          onPressed = player.pause;
        } else {
          onPressed = () => player.seek(Duration.zero);
        }

        return SizedBox(
          width: 64.0,
          height: 64.0,
          child: IconButton(
            icon: buttonChild,
            iconSize: 32.0,
            onPressed: onPressed,
          ),
        );
      },
    );
  }
}
