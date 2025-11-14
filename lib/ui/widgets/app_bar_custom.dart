import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? iconColor;
  final Function()? onRefresh;

  const AppBarCustom({super.key, required this.title, this.actions, this.backgroundColor, this.iconColor, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: iconColor ?? AppColors.white),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textWhite),
      ),
      backgroundColor: backgroundColor ?? AppColors.sky950,
      actions: [
        if (actions != null) ...actions!,
        if (onRefresh != null) IconButton(icon: const Icon(Icons.replay_outlined), onPressed: onRefresh),
      ],
      elevation: 0,
    );
  }

  // Untuk menentukan tinggi AppBar
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
