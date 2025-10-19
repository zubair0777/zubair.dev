import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/constants.dart';

class ResumePage extends StatelessWidget {
  const ResumePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: width > 900 ? width * 0.15 : 20,
        vertical: 50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          ShaderMask(
            shaderCallback: (rect) => const LinearGradient(
              colors: [AppColors.accent, AppColors.accentGradientEnd],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(rect),
            child: const Text(
              "Resume",
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ).animate().fadeIn(duration: 700.ms).slideY(begin: 0.2),

          const SizedBox(height: 40),

          _sectionTitle("Experience"),
          _experienceItem(
            "Flutter Developer",
            "Freelance / Personal Projects",
            "2024 – Present",
            "Building modern Flutter apps with Firebase, responsive layouts, "
                "animations and AI integrations.",
          ),
          _experienceItem(
            "UI/UX Designer",
            "Freelance Work",
            "2023 – 2024",
            "Created modern, user-focused app interfaces using Figma and Flutter widgets.",
          ),

          const SizedBox(height: 30),
          _sectionTitle("Education"),
          _experienceItem(
            "B.S. in Computer Science",
            "The Exemplar Intermediate College",
            "2025 – Ongoing",
            "Studying algorithms, mobile development and backend fundamentals.",
          ),

          const SizedBox(height: 30),
          _sectionTitle("Certifications"),
          _experienceItem(
            "Flutter App Development Course",
            "Saylani Mass IT Training Program",
            "Completed 2025",
            "Mastered Flutter, Firebase, Dart, UI/UX, app deployment and version control.",
          ),
          _experienceItem(
            "AI & Cloud Integration Basics",
            "Self Projects",
            "2024 – Present",
            "Used AI APIs (e.g., Gemini, GPT) for smart Flutter app features.",
          ),

          const SizedBox(height: 40),
          Center(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              ),
              onPressed: () async {
                final url = Uri.parse(
                    "https://drive.google.com/file/d/1xX9qLXagk2WsNGYb2VhJJwOl4aL-N2Gy/view?usp=drive_link");
                if (await canLaunchUrl(url)) await launchUrl(url);
              },
              icon: const Icon(Icons.download_rounded),
              label: const Text("Download Full Resume",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ).animate().fadeIn(duration: 600.ms),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.accent,
      ),
    ),
  );

  Widget _experienceItem(
      String title, String company, String duration, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.card.withOpacity(0.9),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.accent.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 4),
            Text("$company • $duration",
                style:
                const TextStyle(color: AppColors.muted, fontSize: 14)),
            const SizedBox(height: 10),
            Text(desc,
                style: const TextStyle(
                    color: Colors.white70, height: 1.4, fontSize: 15)),
          ],
        ),
      ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1),
    );
  }
}
