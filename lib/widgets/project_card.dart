import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/constants.dart';

class ProjectCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String image;
  final String repo;
  final String demo;
  const ProjectCard(
      {super.key,
        required this.title,
        required this.subtitle,
        required this.image,
        this.repo = '',
        this.demo = ''});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hover = false;
  Future<void> _launch(String url) async {
    if (url.isEmpty) return;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedScale(
        scale: _hover ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Card(
          color: AppColors.card,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 8,
          clipBehavior: Clip.antiAlias,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    child: Stack(children: [
                      Positioned.fill(
                          child: Image.asset(widget.image, fit: BoxFit.cover)),
                      AnimatedOpacity(
                          opacity: _hover ? 0.14 : 0.0,
                          duration: const Duration(milliseconds: 220),
                          child: Container(color: Colors.black)),
                      Positioned(
                          bottom: 12,
                          left: 12,
                          right: 12,
                          child: AnimatedOpacity(
                              opacity: _hover ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 220),
                              child: Row(children: [
                                ElevatedButton(
                                    onPressed: () => _launch(widget.demo),
                                    child: const Text('Live')),
                                const SizedBox(width: 8),
                                OutlinedButton(
                                    onPressed: () => _launch(widget.repo),
                                    child: const Text('Source')),
                              ])))
                    ])),
                Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.title,
                              style: const TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 6),
                          Text(widget.subtitle,
                              style:
                              const TextStyle(color: AppColors.muted)),
                        ])),
              ]),
        ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.04, duration: 650.ms),
      ),
    );
  }
}
