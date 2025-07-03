import 'package:flutter/material.dart';

class PulseIconButton extends StatefulWidget {
  final Icon icon;
  final VoidCallback onPressed;
  final bool pulse;

  const PulseIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.pulse = false,
  });

  @override
  State<PulseIconButton> createState() => _PulseIconButtonState();
}

class _PulseIconButtonState extends State<PulseIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      lowerBound: 0.9,
      upperBound: 1.0,
    );
    _controller.value = 1.0;
    _updatePulse();
  }

  @override
  void didUpdateWidget(PulseIconButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updatePulse();
  }

  void _updatePulse() {
    if (widget.pulse) {
      _controller.repeat(reverse: true);
    } else {
      _controller.stop();
      _controller.value = 1.0;
    }
  }

  void _onTap() {
    if (!widget.pulse) {
      _controller.reverse().then((_) {
        _controller.forward();
        widget.onPressed();
      });
    } else {
      widget.onPressed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) =>
          Transform.scale(scale: _controller.value, child: child),
      child: IconButton(icon: widget.icon, onPressed: _onTap),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
