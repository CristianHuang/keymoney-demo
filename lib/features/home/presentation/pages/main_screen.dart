import 'package:flutter/material.dart';
import 'package:keymoneydemo/features/home/presentation/pages/home_page.dart';
import 'package:keymoneydemo/features/wallet/presentation/pages/wallet_page.dart';
import 'package:keymoneydemo/features/budget/presentation/pages/budget_page.dart';
import 'package:keymoneydemo/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keymoneydemo/core/theme/app_colors.dart';
import 'dart:ui';
import 'package:keymoneydemo/features/home/presentation/widgets/transaction_card.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  bool _isMenuOpen = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    if (_isMenuOpen) {
      _animationController.reverse().whenComplete(() {
        setState(() {
          _isMenuOpen = false;
        });
      });
    } else {
      setState(() {
        _isMenuOpen = true;
      });
      _animationController.forward();
    }
  }

  final List<Widget> _pages = [
    const HomePage(),
    const WalletPage(),
    const BudgetPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          IndexedStack(index: _selectedIndex, children: _pages),
          if (_isMenuOpen) ...[
            GestureDetector(
              onTap: _toggleMenu,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: FadeTransition(
                  opacity: _animationController,
                  child: Container(color: Colors.black.withOpacity(0.5)),
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              left: 20,
              right: 20,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildAnimatedCard(
                    index: 2,
                    title: "Registrar ahorro",
                    icon: Icons.savings,
                    circleColor: AppColors.accent,
                    onTap: () {
                      _toggleMenu();
                    },
                  ),
                  const SizedBox(height: 5),
                  _buildAnimatedCard(
                    index: 1,
                    title: "Registrar gasto",
                    icon: Icons.remove,
                    circleColor: AppColors.red,
                    onTap: () {
                      _toggleMenu();
                    },
                  ),
                  const SizedBox(height: 5),
                  _buildAnimatedCard(
                    index: 0,
                    title: "Registrar ingreso",
                    icon: Icons.add,
                    circleColor: AppColors.green,
                    onTap: () {
                      _toggleMenu();
                    },
                  ),
                ],
              ),
            ),
          ],
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _toggleMenu,
        backgroundColor: AppColors.accent,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: RotationTransition(
          turns: Tween<double>(begin: 0, end: 0.125).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeInOut,
            ),
          ),
          child: const Icon(Icons.add, size: 35, color: AppColors.background),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        color: AppColors.background2,
        padding: EdgeInsets.zero,
        notchMargin: 10,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildNavItem(0, "assets/icons/home.svg", "INICIO"),
              const SizedBox(width: 45),
              _buildNavItem(1, "assets/icons/wallet.svg", "CARTERA"),
              const SizedBox(width: 80),
              _buildNavItem(2, "assets/icons/budget.svg", "PRESUPUESTO"),
              const SizedBox(width: 45),
              _buildNavItem(3, "assets/icons/profile.svg", "PERFIL"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String iconPath, String label) {
    final bool isSelected = _selectedIndex == index;
    final Color color = isSelected ? AppColors.accent : AppColors.background3;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            width: 28,
            height: 28,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedCard({
    required int index,
    required String title,
    required IconData icon,
    required Color circleColor,
    required VoidCallback onTap,
  }) {
    final staggeredAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        index * 0.1,
        0.5 + (index * 0.1),
        curve: Curves.easeOutCubic,
      ),
    );

    return FadeTransition(
      opacity: staggeredAnimation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.5),
          end: Offset.zero,
        ).animate(staggeredAnimation),
        child: ActionCard(
          title: title,
          icon: icon,
          circleColor: circleColor,
          onTap: onTap,
        ),
      ),
    );
  }
}
