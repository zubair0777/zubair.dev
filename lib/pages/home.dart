import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/constants.dart';

class HomePage extends StatelessWidget {
  final Function(int) onNavigate;
  const HomePage({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 900;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topRight,
          radius: 1.5,
          colors: [
            AppColors.accent.withValues(alpha: 0.05),
            Colors.transparent,
          ],
        ),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : size.width * 0.1,
          vertical: isMobile ? 40 : 80,
        ),
        child: Column(
          children: [
            Flex(
              direction: isMobile ? Axis.vertical : Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // LEFT CONTENT
                Expanded(
                  flex: isMobile ? 0 : 6,
                  child: Column(
                    crossAxisAlignment: isMobile
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    children: [
                      _buildGreeting().animate().fadeIn(duration: 800.ms).slideX(begin: -0.2),
                      const SizedBox(height: 20),
                      _buildMainTitle(isMobile),
                      const SizedBox(height: 15),
                      _buildSubTitle(isMobile),
                      const SizedBox(height: 30),
                      _buildDescription(isMobile).animate().fadeIn(duration: 1.seconds, delay: 400.ms),
                      const SizedBox(height: 45),
                      _buildActionButtons(onNavigate).animate().fadeIn(duration: 1.seconds, delay: 600.ms).slideY(begin: 0.2),
                      if (!isMobile) ...[
                        const SizedBox(height: 60),
                        _buildSocialProof(),
                      ],
                    ],
                  ),
                ),

                if (!isMobile) const SizedBox(width: 40),

                // RIGHT IMAGE
                if (!isMobile)
                  Expanded(
                    flex: 4,
                    child: _buildHeroImage(),
                  ),
                
                if (isMobile) ...[
                  const SizedBox(height: 60),
                  _buildHeroImage(),
                  const SizedBox(height: 40),
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGreeting() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.waving_hand, color: AppColors.accent, size: 16),
          const SizedBox(width: 8),
          Text(
            "WELCOME TO MY WORLD",
            style: TextStyle(
              color: AppColors.accent,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainTitle(bool isMobile) {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          "I'm Rana Zubair",
          style: TextStyle(
            color: Colors.white,
            fontSize: isMobile ? 42 : 72,
            fontWeight: FontWeight.w900,
            height: 1.1,
          ),
        ),
      ],
    );
  }

  Widget _buildSubTitle(bool isMobile) {
    return SizedBox(
      height: isMobile ? 40 : 60,
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: isMobile ? 24 : 36,
          fontWeight: FontWeight.bold,
          color: AppColors.accent,
        ),
        child: AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            TypewriterAnimatedText('Flutter Developer.'),
            TypewriterAnimatedText('Firebase Expert.'),
            TypewriterAnimatedText('UI/UX Designer.'),
            TypewriterAnimatedText('AI Enthusiast.'),
          ],
        ),
      ),
    );
  }

  Widget _buildDescription(bool isMobile) {
    return Text(
      "Specializing in building exceptional digital experiences that are fast, accessible, visually stunning, and responsive. I turn complex problems into elegant, production-ready Flutter applications.",
      textAlign: isMobile ? TextAlign.center : TextAlign.start,
      style: TextStyle(
        color: AppColors.muted,
        fontSize: isMobile ? 16 : 18,
        height: 1.6,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildActionButtons(Function(int) onNavigate) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      alignment: WrapAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => onNavigate(1),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accent,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 8,
            shadowColor: AppColors.accent.withValues(alpha: 0.4),
          ),
          child: const Text(
            "VIEW MY WORK",
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
          ),
        ),
        OutlinedButton(
          onPressed: () {
            launchUrl(Uri.parse('https://drive.google.com/file/d/1xX9qLXagk2WsNGYb2VhJJwOl4aL-N2Gy/view?usp=drive_link'));
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: Colors.white24, width: 2),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text(
            "DOWNLOAD CV",
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroImage() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Decorative background elements
        Container(
          width: 320,
          height: 320,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [AppColors.accent.withValues(alpha: 0.2), Colors.transparent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ).animate(onPlay: (controller) => controller.repeat(reverse: true))
            .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1), duration: 2.seconds),
        
        // Main Image Container
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.accent.withValues(alpha: 0.3), width: 2),
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.accent.withValues(alpha: 0.5), width: 1),
            ),
            child: ClipOval(
              child: Image.asset(
                "assets/images/me.jpg",
                width: 280,
                height: 280,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        
        // Rotating Ring
        Positioned.fill(
          child: CustomPaint(
            painter: RingPainter(color: AppColors.accent.withValues(alpha: 0.4)),
          ).animate(onPlay: (controller) => controller.repeat())
            .rotate(duration: 10.seconds),
        ),
      ],
    ).animate().fadeIn(duration: 1.seconds).scale(begin: const Offset(0.8, 0.8));
  }

  Widget _buildSocialProof() {
    return Row(
      children: [
        _socialIcon(Icons.code, "15+ Projects"),
        const SizedBox(width: 30),
        _socialIcon(Icons.rocket_launch, "1 Year Exp."),
        const SizedBox(width: 30),
        _socialIcon(Icons.verified, "Certified"),
      ],
    );
  }

  Widget _socialIcon(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: AppColors.accent, size: 20),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class RingPainter extends CustomPainter {
  final Color color;
  RingPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 + 30;

    // Draw some dashed or dotted arcs for a techy feel
    for (int i = 0; i < 8; i++) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        i * 0.8,
        0.4,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
