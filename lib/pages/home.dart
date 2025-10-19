import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../core/constants.dart';
import '../widgets/animated_name.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  final Function(int) onNavigate;
  const HomePage({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 800;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 100,
        vertical: isMobile ? 60 : 100,
      ),
      child: Center(
        child: Flex(
          direction: isMobile ? Axis.vertical : Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // LEFT SIDE CONTENT
            Expanded(
              flex: isMobile ? 0 : 5,
              child: Column(
                crossAxisAlignment:
                isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hi! I'm",
                    style: TextStyle(
                      color: AppColors.muted,
                      fontSize: isMobile ? 18 : 22,
                    ),
                  ).animate().fadeIn(duration: 600.ms).moveX(begin: -40),

                  // Animated name (different color for first/last name)
                  AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      TyperAnimatedText(
                        "Rana ",
                        textStyle: TextStyle(
                          color: AppColors.white,
                          fontSize: isMobile ? 36 : 56,
                          fontWeight: FontWeight.bold,
                        ),
                        speed: const Duration(milliseconds: 120),
                      ),
                      TyperAnimatedText(
                        "Zubair",
                        textStyle: TextStyle(
                          foreground: Paint()
                            ..shader = const LinearGradient(
                              colors: [AppColors.accentGradientStart, AppColors.accentGradientEnd],
                            ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                          fontSize: isMobile ? 36 : 56,
                          fontWeight: FontWeight.bold,
                        ),
                        speed: const Duration(milliseconds: 120),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Animated role text
                  AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      TyperAnimatedText(
                        "Flutter Developer 💙",
                        textStyle: TextStyle(
                          color: AppColors.accent,
                          fontSize: isMobile ? 20 : 28,
                          fontWeight: FontWeight.w600,
                        ),
                        speed: const Duration(milliseconds: 120),
                      ),
                      TyperAnimatedText(
                        "Firebase Expert 🔥",
                        textStyle: TextStyle(
                          color: AppColors.accent,
                          fontSize: isMobile ? 20 : 28,
                          fontWeight: FontWeight.w600,
                        ),
                        speed: const Duration(milliseconds: 120),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  Text(
                    "I create modern, fast, and scalable Flutter apps with beautiful UI and Firebase integration.",
                    style: TextStyle(
                      color: AppColors.muted,
                      fontSize: isMobile ? 15 : 17,
                      height: 1.5,
                    ),
                  ).animate().fadeIn(duration: 800.ms),

                  const SizedBox(height: 30),

                  Wrap(
                    spacing: 16,
                    runSpacing: 12,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          launchUrl(Uri.parse(
                              'https://drive.google.com/file/d/1xX9qLXagk2WsNGYb2VhJJwOl4aL-N2Gy/view?usp=drive_link'));
                        },
                        icon: const Icon(Icons.download, color: Colors.black),
                        label: const Text("Download CV" ,style: TextStyle(color: Colors.black),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22, vertical: 14),
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      OutlinedButton.icon(
                        onPressed: () => onNavigate(4),
                        icon: const Icon(Icons.send, color: AppColors.accent),
                        label: const Text(
                          "Hire Me Now",
                          style: TextStyle(color: AppColors.accent),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.accent),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22, vertical: 14),
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 60, height: 60),

            // RIGHT SIDE IMAGE (only for larger screens)
            if (!isMobile)
              Expanded(
                flex: 4,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Curved yellow background
                    Positioned(
                      right: 0,
                      child: Container(
                        width: 380,
                        height: 380,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              AppColors.accentGradientStart,
                              AppColors.accentGradientEnd,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                    ),
                    ClipOval(
                      child: Image.asset(
                        "assets/images/me.jpg",
                        width: 330,
                        height: 330,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ).animate().fadeIn(duration: 800.ms).moveX(begin: 60),
              ),
          ],
        ),
      ),
    );
  }
}
