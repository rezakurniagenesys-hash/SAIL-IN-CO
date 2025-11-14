import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sail_in_co/core/constants/asset_icons.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/ui/screens/home/home_screen.dart';

class DevelopmentBottomMenu extends StatefulWidget {
  const DevelopmentBottomMenu({super.key});

  @override
  State<DevelopmentBottomMenu> createState() => _DevelopmentBottomMenuState();
}

class _DevelopmentBottomMenuState extends State<DevelopmentBottomMenu> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  bool isSwipe = false;

  final List<String> icons = [AssetIcons.typcnHome, AssetIcons.f7Person2Fill, AssetIcons.mingcuteCarFill, AssetIcons.mingcutePaperFill];

  late final PageController _pageController;

  late final AnimationController _controller;
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);

    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 200), lowerBound: 0.0, upperBound: 0.1);
    animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });

    if (isSwipe) {
      // Jika swipe aktif, animasi halus
      _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      // Jika swipe nonaktif, langsung jump
      _pageController.jumpToPage(index);
    }

    await _controller.forward();
    await _controller.reverse();
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: isSwipe ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(), // disable swipe
        children: const [HomeScreen(), ProfilePage(), CarPage(), DocumentPage()],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 70,
        width: 70,
        decoration: const BoxDecoration(
          color: Color(0xFF122E4D),
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4))],
        ),
        child: Center(
          child: SvgPicture.asset(AssetIcons.fluentPersonSquareAdd16Filled, height: 28, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF122E4D),
        shape: const SmoothShallowNotchedRectangle(),
        notchMargin: 10,
        elevation: 12,
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, icons[0]),
              _buildNavItem(1, icons[1]),
              const SizedBox(width: 60),
              _buildNavItem(2, icons[2]),
              _buildNavItem(3, icons[3]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String iconPath) {
    final bool isActive = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.only(bottom: isActive ? 8 : 0),
        child: AnimatedScale(
          scale: isActive ? 1.25 : 1.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutBack,
          child: SvgPicture.asset(iconPath, height: 28, colorFilter: ColorFilter.mode(isActive ? const Color(0xFF61B8FF) : Colors.white, BlendMode.srcIn)),
        ),
      ),
    );
  }
}

class SmoothShallowNotchedRectangle extends NotchedShape {
  const SmoothShallowNotchedRectangle();

  @override
  Path getOuterPath(Rect host, Rect? guest) {
    final Path path = Path();
    const double radius = 24.0; // rounded kiri & kanan atas

    // Kiri bawah ke kiri atas (rounded)
    path.moveTo(host.left, host.bottom);
    path.lineTo(host.left, host.top + radius);
    path.quadraticBezierTo(host.left, host.top, host.left + radius, host.top);

    if (guest == null) {
      path.lineTo(host.right - radius, host.top);
      path.quadraticBezierTo(host.right, host.top, host.right, host.top + radius);
      path.lineTo(host.right, host.bottom);
      path.close();
      return path;
    }

    // Parameter bentuk lekukan
    final double notchRadius = guest.width * 0.8; // lebar lekukan
    final double notchDepth = guest.height * 0.55; // tidak terlalu dalam
    final double notchCenterX = guest.center.dx;

    final double startNotchX = notchCenterX - notchRadius;
    final double endNotchX = notchCenterX + notchRadius;

    path.lineTo(startNotchX, host.top);

    // Bentuk U lembut (lebih dangkal dari sebelumnya)
    path.cubicTo(
      notchCenterX - notchRadius * 0.6,
      host.top, // lengkungan kiri
      notchCenterX - notchRadius * 0.25 - 18,
      host.top + notchDepth, // titik kiri bawah
      notchCenterX + 1,
      host.top + (notchDepth), // tengah bawah (dangkal)
    );

    path.cubicTo(
      notchCenterX + notchRadius * 0.25 + 11,
      host.top + notchDepth + 2, // titik kanan bawah
      notchCenterX + notchRadius * 0.6,
      host.top, // lengkungan kanan
      endNotchX - 1,
      host.top, // keluar ke kanan
    );

    // Rounded kanan atas
    path.lineTo(host.right - radius, host.top);
    path.quadraticBezierTo(host.right, host.top, host.right, host.top + radius);

    // Tutup ke bawah
    path.lineTo(host.right, host.bottom);
    path.lineTo(host.left, host.bottom);
    path.close();

    return path;
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: Colors.pink,
      child: const Center(
        child: Text(
          "Profile Page",
          style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class CarPage extends StatelessWidget {
  const CarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: Colors.pink,
      child: const Center(
        child: Text(
          "Car Page",
          style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class DocumentPage extends StatelessWidget {
  const DocumentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Document Page", style: TextStyle(fontSize: 24)));
  }
}
