// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/providers/auth_provider.dart';
import 'package:sail_in_co/ui/screens/dashboard/dashboard.dart';
import 'package:sail_in_co/ui/screens/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))..repeat();

    initApp();
  }

  void navigateSmooth(Widget page) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (_, animation, __) {
          return FadeTransition(opacity: animation, child: page);
        },
      ),
    );
  }

  void initApp() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);

    final result = await auth.checkTokenOnStart();

    if (!mounted) return;

    await Future.delayed(const Duration(seconds: 2));

    if (result) {
      navigateSmooth(const Dashboard());
    } else {
      navigateSmooth(const LoginScreen());
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.sky950,
      body: Center(
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                final delay = index * 0.2;
                double value = (controller.value - delay);
                if (value < 0) value += 1;
                final scale = (1 - (value * 2 - 1).abs()).clamp(0.0, 1.0);
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: 12 + (scale * 6),
                  height: 12 + (scale * 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3 + (scale * 0.7)),
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.white.withOpacity(scale * 0.4), blurRadius: 8, spreadRadius: 1)],
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
