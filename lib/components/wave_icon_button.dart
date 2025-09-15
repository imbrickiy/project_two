import 'package:flutter/material.dart';
import 'package:project_two/common/colors.dart';

class WaveIconButton extends StatefulWidget {
  final Icon icon;
  final VoidCallback onPressed;
  final bool active;

  const WaveIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.active = false,
  });

  @override
  State<WaveIconButton> createState() => _WaveIconButtonState();
}

class _WaveIconButtonState extends State<WaveIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    if (widget.active) _controller.repeat();
  }

  @override
  void didUpdateWidget(WaveIconButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.active && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!widget.active && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 88,
      height: 88,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (widget.active)
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final value = _controller.value;
                return Container(
                  width: 56 + value * 32,
                  height: 56 + value * 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.3 * (1 - value)),
                        Colors.transparent,
                      ],
                      stops: [0.7, 1.0],
                    ),
                  ),
                );
              },
            ),
          IconButton(icon: widget.icon, onPressed: widget.onPressed),
        ],
      ),
    );
  }
}
