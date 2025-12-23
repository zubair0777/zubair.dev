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

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '${AppStrings.name} — Portfolio',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        scaffoldBackgroundColor: AppColors.bg,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const MainLayout(),
    );
  }
}

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selected = 0;

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

    return Scaffold(
      extendBodyBehindAppBar: true,
      // Drawer on the left is more standard for Android
      drawer: _buildDrawer(context),
      appBar: NavBar(selectedIndex: _selected, onTap: _onTap),
      body: Stack(
        children: [
          // 🌌 Seamless Global Background (Eliminates Black Bars)
          Positioned.fill(
            child: Container(
              color: AppColors.bg,
              child: CustomPaint(
                painter: BackgroundPainter(),
              ),
            ),
          ),
          
          // Dynamic Ambient Glows
          Positioned(
            top: -150,
            right: -150,
            child: _buildBlob(AppColors.accent.withValues(alpha: 0.15), 500),
          ),
          Positioned(
            bottom: -100,
            left: -100,
            child: _buildBlob(AppColors.accent.withValues(alpha: 0.1), 450),
          ),

          // Content Area with Smooth Transitions
          PageTransitionSwitcher(
            duration: const Duration(milliseconds: 700),
            transitionBuilder: (child, animation, secondaryAnimation) =>
                FadeThroughTransition(
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  child: child,
                ),
            child: pages[_selected],
          ),
        ],
      ),
    );
  }

  Widget _buildBlob(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: 200,
            spreadRadius: 100,
          )
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.panel,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        children: [
          // Premium Header
          Container(
            padding: const EdgeInsets.only(top: 60, bottom: 30, left: 20, right: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.accent, AppColors.accentGradientStart],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage("assets/images/me.jpg"),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  AppStrings.name,
                  style: TextStyle(
                    color: Colors.white, 
                    fontWeight: FontWeight.bold, 
                    fontSize: 20,
                  ),
                ),
                Text(
                  "Flutter Developer", 
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          
          // Navigation List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              children: [
                _drawerItem(Icons.home_rounded, "Home", 0),
                _drawerItem(Icons.grid_view_rounded, "Projects", 1),
                _drawerItem(Icons.person_rounded, "About Me", 2),
                _drawerItem(Icons.description_rounded, "Resume", 3),
                _drawerItem(Icons.email_rounded, "Contact", 4),
              ],
            ),
          ),

          // Footer Socials
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _socialIcon(Icons.code_rounded, AppStrings.github),
                const SizedBox(width: 20),
                _socialIcon(Icons.link_rounded, "https://linkedin.com/in/zubair-siddiq-761800371"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, int index) {
    final isSelected = _selected == index;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isSelected ? AppColors.accent.withValues(alpha: 0.15) : Colors.transparent,
      ),
      child: ListTile(
        leading: Icon(
          icon, 
          color: isSelected ? AppColors.accent : Colors.white54,
        ),
        title: Text(
          title, 
          style: TextStyle(
            color: isSelected ? AppColors.accent : Colors.white70,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: () {
          // Navigator.pop(context) now works because MainLayout is a separate widget
          Navigator.pop(context);
          _onTap(index);
        },
      ),
    );
  }

  Widget _socialIcon(IconData icon, String url) {
    return IconButton(
      onPressed: () => launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication),
      icon: Icon(icon, color: AppColors.accent, size: 24),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.04)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    const spacing = 50.0;
    for (var i = 0.0; i < size.width; i += spacing) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (var i = 0.0; i < size.height; i += spacing) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
