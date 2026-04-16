import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'beranda_screen.dart';
import 'favorit_screen.dart';
import 'dipinjam_screen.dart';
import 'history_screen.dart';
import 'lainnya_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 2;

  final List<Widget> _screens = [
    const HistoryScreen(),
    const FavoritScreen(),
    const BerandaScreen(),
    const DipinjamScreen(),
    const LainnyaScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.primary,
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, -2)),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.menu,
                  label: 'Menu',
                  index: 0,
                  currentIndex: _currentIndex,
                  onTap: (i) => setState(() => _currentIndex = i),
                ),
                _NavItem(
                  icon: Icons.favorite_border,
                  label: 'Favorit',
                  index: 1,
                  currentIndex: _currentIndex,
                  onTap: (i) => setState(() => _currentIndex = i),
                ),
                // Home center button
                GestureDetector(
                  onTap: () => setState(() => _currentIndex = 2),
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == 2 ? AppColors.accentCyan : AppColors.accentCyan.withOpacity(0.7),
                      boxShadow: const [
                        BoxShadow(color: Colors.black38, blurRadius: 8, offset: Offset(0, 2)),
                      ],
                    ),
                    child: const Icon(Icons.home, color: AppColors.white, size: 28),
                  ),
                ),
                _NavItem(
                  icon: Icons.book_outlined,
                  label: 'Dipinjam',
                  index: 3,
                  currentIndex: _currentIndex,
                  onTap: (i) => setState(() => _currentIndex = i),
                ),
                _NavItem(
                  icon: Icons.more_horiz,
                  label: 'Lainnya',
                  index: 4,
                  currentIndex: _currentIndex,
                  onTap: (i) => setState(() => _currentIndex = i),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final int currentIndex;
  final Function(int) onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Icon(
          icon,
          color: isActive ? AppColors.accentCyan : AppColors.white.withOpacity(0.7),
          size: 26,
        ),
      ),
    );
  }
}
