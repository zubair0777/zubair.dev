import 'package:flutter/material.dart';
import '../core/constants.dart';

class AnimatedName extends StatefulWidget {
  final TextStyle? style;
  const AnimatedName({super.key, this.style});
  @override
  State<AnimatedName> createState() => _AnimatedNameState();
}

class _AnimatedNameState extends State<AnimatedName> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _ctrl.forward();
  }
  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final parts = AppStrings.name.split(' ');
    final first = parts.isNotEmpty ? parts[0] : AppStrings.name;
    final rest = parts.length>1 ? parts.sublist(1).join(' ') : '';
    return FadeTransition(
      opacity: CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.85, end: 1.0).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutBack)),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(first, style: widget.style ?? const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: AppColors.white)),
            if (rest.isNotEmpty) const SizedBox(width: 8),
            if (rest.isNotEmpty) Text(rest, style: widget.style?.copyWith(color: AppColors.accent) ?? const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: AppColors.accent)),
          ],
        ),
      ),
    );
  }
}
