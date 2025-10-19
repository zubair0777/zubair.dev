import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/constants.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity, // ✅ Fills full screen
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800), // ✅ Centers & limits width
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 🌈 Header
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [AppColors.accent, AppColors.accentGradientStart],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: const Text(
                      "Let's Connect!",
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2),

                  const SizedBox(height: 20),

                  Text(
                    "Feel free to reach out for collaborations, freelance projects, or even a cup of chai ☕",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 16,
                    ),
                  ).animate().fadeIn(duration: 600.ms),

                  const SizedBox(height: 50),

                  // 🪩 Glassmorphic Contact Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withValues(alpha: 0.08),
                          Colors.white.withValues(alpha: 0.04),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(18),
                      border:
                      Border.all(color: Colors.white.withValues(alpha: 0.1)),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x33000000),
                          blurRadius: 25,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.email_rounded,
                            size: 58, color: AppColors.accent),
                        const SizedBox(height: 18),
                        Text(
                          "Drop me an Email at",
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () => _launch(
                              "mailto:zubair.flutter.dev@gmail.com?subject=Project%20Inquiry"),
                          child: const Text(
                            "zubair.flutter.dev@gmail.com",
                            style: TextStyle(
                              color: AppColors.accentGradientStart,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.15),

                  const SizedBox(height: 50),

                  // 🔗 Social Buttons
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 18,
                    runSpacing: 12,
                    children: [
                      _socialButton(FontAwesomeIcons.github, "GitHub",
                          "https://github.com/zubair0777"),
                      _socialButton(
                          FontAwesomeIcons.linkedin,
                          "LinkedIn",
                          "https://www.linkedin.com/in/zubair-siddiq-761800371"),
                      _socialButton(FontAwesomeIcons.whatsapp, "WhatsApp",
                          "https://wa.me/923021712268"),
                      _socialButton(FontAwesomeIcons.instagram, "Instagram",
                          "https://instagram.com/m.zubairking"),
                      _socialButton(FontAwesomeIcons.globe, "Portfolio Website",
                          "https://theexempler-ff99c.web.app"),
                    ],
                  ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.25),

                  const SizedBox(height: 70),

                  const Text(
                    "© 2025 Rana Zubair — Crafted with Flutter 💙",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialButton(IconData icon, String label, String url) {
    return GestureDetector(
      onTap: () => _launch(url),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: const LinearGradient(
            colors: [AppColors.accent, AppColors.accentGradientStart],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: const [
            BoxShadow(
                color: Color(0x44000000),
                blurRadius: 12,
                offset: Offset(0, 5)),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(
          begin: const Offset(1, 1), end: const Offset(1.03, 1.03)),
    );
  }
}
