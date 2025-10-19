import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;
  const NavBar({super.key, required this.selectedIndex, required this.onTap});

  Widget _navItem(String label, int idx) {
    final selected = idx == selectedIndex;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton(
        onPressed: () => onTap(idx),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: selected ? FontWeight.bold : FontWeight.w500,
            color: selected ? AppColors.accent : Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return AppBar(
      backgroundColor: AppColors.panel,
      elevation: 6,
      title: Row(
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundImage: AssetImage('assets/images/me.jpg'),
          ),
          const SizedBox(width: 12),
          Text(
            AppStrings.name,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: AppColors.accent,
            ),
          ),
        ],
      ),
      actions: isMobile
          ? null // Drawer button auto added in main.dart
          : [
        Row(
          children: [
            _navItem("Home", 0),
            _navItem("Projects", 1),
            _navItem("About", 2),
            _navItem("Resume", 3),
            _navItem("Contact", 4),
            const SizedBox(width: 16),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
