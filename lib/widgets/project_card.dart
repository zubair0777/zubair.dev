import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/constants.dart';

class ProjectCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String image;
  final String repo;
  final String demo;

  const ProjectCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    this.repo = '',
    this.demo = '',
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hover = false;

  Future<void> _launch(String url) async {
    if (url.isEmpty) return;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isVerySmall = width < 400;
    
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        transform: Matrix4.identity()..translate(0, _hover ? -10 : 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: _hover 
                  ? AppColors.accent.withValues(alpha: 0.2) 
                  : Colors.black.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.card.withValues(alpha: 0.7),
                border: Border.all(
                  color: _hover ? AppColors.accent.withValues(alpha: 0.5) : Colors.white10,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 🖼 IMAGE SECTION
                  AspectRatio(
                    aspectRatio: 16 / 10,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(widget.image, fit: BoxFit.cover),
                        ),
                        Positioned.fill(
                          child: Container(color: Colors.black.withValues(alpha: 0.4)),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(widget.image, fit: BoxFit.contain),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 📝 CONTENT SECTION
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          widget.subtitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.5),
                            fontSize: 12,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // Action Buttons - Use Row with Flexible to prevent overflow
                        Row(
                          children: [
                            if (widget.demo.isNotEmpty)
                              Expanded(
                                child: _actionButton(
                                  icon: Icons.launch,
                                  label: "Live",
                                  isPrimary: true,
                                  onTap: () => _launch(widget.demo),
                                ),
                              ),
                            if (widget.demo.isNotEmpty && widget.repo.isNotEmpty)
                              const SizedBox(width: 8),
                            if (widget.repo.isNotEmpty)
                              Expanded(
                                child: _actionButton(
                                  icon: Icons.code,
                                  label: "Code",
                                  isPrimary: false,
                                  onTap: () => _launch(widget.repo),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String label,
    required bool isPrimary,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.accent : Colors.white.withValues(alpha: 0.05),
          border: isPrimary ? null : Border.all(color: Colors.white10),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 14, color: isPrimary ? Colors.black : Colors.white),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: isPrimary ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
