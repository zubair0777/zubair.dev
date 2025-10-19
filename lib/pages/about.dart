import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/constants.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 750;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF141E30), Color(0xFF243B55)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
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
                "About Me",
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
            ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2),

            const SizedBox(height: 40),

            // 🧑‍💻 Avatar + Intro
            Container(
              width: isMobile ? double.infinity : 800,
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
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x33000000),
                    blurRadius: 25,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: isMobile ? 60 : 80,
                    backgroundImage: const AssetImage("assets/images/me.jpg"),
                  ).animate().fadeIn(duration: 700.ms).scale(begin: const Offset(0.9, 0.9)),

                  const SizedBox(height: 22),

                  Text(
                    "Rana Zubair",
                    style: TextStyle(
                      fontSize: isMobile ? 26 : 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accentGradientStart,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Flutter Developer • Firebase Expert • AI Learner",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: isMobile ? 14 : 16,
                    ),
                  ),

                  const SizedBox(height: 30),

                  Text(
                    "Hi! I’m a passionate Flutter developer from Pakistan 🇵🇰 currently pursuing "
                        "my first year in Computer Science at The Exempler Intermediate College. "
                        "I specialize in creating modern, animated, and responsive Flutter apps with Firebase integration.\n\n"
                        "I’ve also explored AI-powered features, app deployment, and backend integration to build complete digital experiences. "
                        "I aim to keep growing as a developer and contribute to innovative projects that make real impact.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.5,
                      fontSize: 15,
                    ),
                  ).animate().fadeIn(duration: 700.ms).slideY(begin: 0.1),
                ],
              ),
            ),

            const SizedBox(height: 50),

            // 🧠 Skills Section
            _sectionTitle("Technical Skills"),
            const SizedBox(height: 20),
            Wrap(
              spacing: 16,
              runSpacing: 14,
              alignment: WrapAlignment.center,
              children: [
                _skillChip("Flutter"),
                _skillChip("Firebase"),
                _skillChip("Dart OOP"),
                _skillChip("UI/UX Design"),
                _skillChip("Animations"),
                _skillChip("REST APIs"),
                _skillChip("AI Integration"),
              ],
            ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2),

            const SizedBox(height: 50),

            // 💼 Career Highlights
            _sectionTitle("Career Highlights"),
            const SizedBox(height: 25),
            _highlightCard(
              "1 Year Flutter Experience",
              "Worked on multiple freelance & college-level projects including weather apps, login systems, and portfolio sites.",
            ),
            _highlightCard(
              "Saylani Flutter Course Graduate",
              "Completed professional Flutter & Firebase course from Saylani Mass IT Training Program in 2025.",
            ),
            _highlightCard(
              "AI Integration Enthusiast",
              "Experimenting with OpenAI APIs and integrating smart features in Flutter apps.",
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) => ShaderMask(
    shaderCallback: (bounds) => const LinearGradient(
      colors: [AppColors.accent, AppColors.accentGradientStart],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(bounds),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 0.8,
      ),
    ),
  );

  Widget _skillChip(String text) => AnimatedContainer(
    duration: const Duration(milliseconds: 200),
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [AppColors.accent, AppColors.accentGradientStart],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(25),
    ),
    child: Text(
      text,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
    ),
  );

  Widget _highlightCard(String title, String desc) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.08),
            Colors.white.withValues(alpha: 0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accentGradientStart)),
          const SizedBox(height: 6),
          Text(desc,
              style: const TextStyle(color: Colors.white70, height: 1.5, fontSize: 15)),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1),
  );
}
