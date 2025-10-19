import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../widgets/project_card.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.count(
        crossAxisCount: MediaQuery.of(context).size.width > 800 ? 3 : 1,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: const [
          ProjectCard(
            title: "A Website for my own collage",
            subtitle: "Modern Flutter Web For A collage",
            image: "assets/images/project1.jpg",
            repo: "https://github.com/zubair0777/the_exempler",
            demo: "https://zubair.dev",
          ),
          ProjectCard(
            title: "RG WEATHER APP",
            subtitle: "A full fledged weather app with API integration",
            image: "assets/images/RG WEATHER.jpg",
            repo: "https://github.com/zubair0777/RGWeather",
          ),
          ProjectCard(
            title: "Firebase Login App",
            subtitle: "A Flutter app with login integration using Firebase and a simple store app",
            image: "assets/images/loginapp.jpg",
            repo: "https://github.com/zubair0777/login_page_store_app",
          ),
          ProjectCard(
            title: "UI Design",
            subtitle: "A Modern Flutter UI Design",
            image: "assets/images/uidesign.jpg",
            repo: "https://github.com/zubair0777/RGWeather",
          ),
          ProjectCard(
            title: "WhatsApp Chat Screen",
            subtitle: "WhatsApp Chat Screen with Flutter",
            image: "assets/images/whatsapp.jpg",
            repo: "https://github.com/zubair0777/whatsapp_chat_screen",
          ),
          ProjectCard(
            title: "A Secret App Coming SOON",
            subtitle: "A Full Fledge AI Chatbot App",
            image: "assets/images/comingsoon.jpg",
            repo: "https://github.com/zubair0777",
          ),

        ],
      ),
    );
  }
}
