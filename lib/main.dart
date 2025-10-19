import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animations/animations.dart';
import 'package:url_launcher/url_launcher.dart';

import 'core/constants.dart';
import 'widgets/navbar.dart';
import 'pages/home.dart';
import 'pages/projects.dart';
import 'pages/about.dart';
import 'pages/resume.dart';
import 'pages/contact.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  int _selected = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(const AssetImage('assets/images/me.jpg'), context);
    });
  }

  void _onTap(int idx) => setState(() => _selected = idx);

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      HomePage(onNavigate: _onTap),
      const ProjectsPage(),
      const AboutPage(),
      const ResumePage(),
      const ContactPage(),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '${AppStrings.name} — Portfolio',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        scaffoldBackgroundColor: AppColors.bg,
        brightness: Brightness.dark,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      home: Scaffold(
        appBar: NavBar(selectedIndex: _selected, onTap: _onTap),

        // ✅ Drawer for mobile
        endDrawer: Builder(
          builder: (context) => Drawer(
            backgroundColor: AppColors.panel,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                bottomLeft: Radius.circular(18),
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 🔹 Drawer Header with Avatar fix
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 28),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.accent, AppColors.accentGradientEnd],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.5),
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 55,
                            backgroundColor: Colors.transparent,
                            child: ClipOval(
                              child: Image.asset(
                                "assets/images/me.jpg",
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Rana Zubair",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 🔹 Menu Items
                  Expanded(
                    child: ListView(
                      children: [
                        _drawerItem(context, "🏠 Home", 0),
                        _drawerItem(context, "💼 Projects", 1),
                        _drawerItem(context, "👨‍💻 About", 2),
                        _drawerItem(context, "📄 Resume", 3),
                        _drawerItem(context, "📬 Contact", 4),
                      ],
                    ),
                  ),

                  // 🔹 Social Links
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () => _launchURL("https://github.com/zubair0777"),
                          icon: const Icon(Icons.code, color: Colors.white70),
                        ),
                        IconButton(
                          onPressed: () => _launchURL("https://linkedin.com/in/zubair-siddiq-761800371"),
                          icon: const Icon(Icons.business, color: Colors.white70),
                        ),
                        IconButton(
                          onPressed: () => _launchURL("mailto:zubair.flutter.dev@gmail.com"),
                          icon: const Icon(Icons.email, color: Colors.white70),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),

        // ✅ Smooth Page Transitions
        body: PageTransitionSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation, secondaryAnimation) =>
              SharedAxisTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.scaled,
                child: RepaintBoundary(child: child), // smooth render
              ),
          child: pages[_selected],
        ),
      ),
    );
  }

  // 🔹 Drawer Item
  Widget _drawerItem(BuildContext context, String title, int index) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white70, fontSize: 16),
      ),
      onTap: () {
        Navigator.pop(context);
        _onTap(index);
      },
    );
  }

  // 🔹 Launch URLs (GitHub, LinkedIn, etc.)
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }
}
