import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/constants.dart';
import '../widgets/project_card.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;
    final isTablet = width < 1100 && width >= 700;

    int crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 60,
          vertical: 40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "FEATURED PROJECTS",
                  style: TextStyle(
                    color: AppColors.accent,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                    fontSize: 14,
                  ),
                ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.2),
                const SizedBox(height: 10),
                Text(
                  "Creative Works & Portfolios",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 32 : 48,
                    fontWeight: FontWeight.bold,
                  ),
                ).animate().fadeIn(duration: 600.ms, delay: 100.ms).slideX(begin: -0.1),
                const SizedBox(height: 20),
                Container(
                  width: 80,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ).animate().fadeIn(duration: 700.ms, delay: 200.ms).scaleX(alignment: Alignment.centerLeft),
              ],
            ),
            
            const SizedBox(height: 60),

            // Projects Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 6,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 30,
                mainAxisSpacing: 30,
                childAspectRatio: 0.85,
              ),
              itemBuilder: (context, index) {
                final projects = [
                  const ProjectCard(
                    title: "The Exempler College",
                    subtitle: "A modern, high-performance web platform for educational institutions with Flutter.",
                    image: "assets/images/project1.jpg",
                    repo: "https://github.com/zubair0777/the_exempler",
                    demo: "https://zubair.dev",
                  ),
                  const ProjectCard(
                    title: "RG Weather App",
                    subtitle: "Real-time weather tracking with beautiful UI, API integration, and location services.",
                    image: "assets/images/RG WEATHER.jpg",
                    repo: "https://github.com/zubair0777/RGWeather",
                  ),
                  const ProjectCard(
                    title: "Firebase E-Store",
                    subtitle: "Full-stack mobile shop with Firebase auth, real-time database, and cloud storage.",
                    image: "assets/images/loginapp.jpg",
                    repo: "https://github.com/zubair0777/login_page_store_app",
                  ),
                  const ProjectCard(
                    title: "Modern UI Kit",
                    subtitle: "A collection of premium Flutter UI components designed for scalability and performance.",
                    image: "assets/images/uidesign.jpg",
                    repo: "https://github.com/zubair0777/RGWeather",
                  ),
                  const ProjectCard(
                    title: "WhatsApp Clone",
                    subtitle: "Pixel-perfect WhatsApp UI recreation focusing on complex layouts and chat interactions.",
                    image: "assets/images/whatsapp.jpg",
                    repo: "https://github.com/zubair0777/whatsapp_chat_screen",
                  ),
                  const ProjectCard(
                    title: "AI Assistant (Upcoming)",
                    subtitle: "An intelligent chatbot application leveraging GPT models and custom Flutter UI.",
                    image: "assets/images/comingsoon.jpg",
                    repo: "https://github.com/zubair0777",
                  ),
                ];
                
                return projects[index].animate().fadeIn(
                  duration: 600.ms,
                  delay: (index * 100).ms,
                ).scale(begin: const Offset(0.9, 0.9));
              },
            ),
            
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
