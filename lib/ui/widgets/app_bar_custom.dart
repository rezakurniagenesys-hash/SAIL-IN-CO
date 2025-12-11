import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
import 'package:sail_in_co/providers/connection_provider.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? iconColor;
  final Function()? onRefresh;
  final bool showBack;

  const AppBarCustom({super.key, required this.title, this.actions, this.backgroundColor, this.iconColor, this.onRefresh, this.showBack = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          automaticallyImplyLeading: showBack,
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
        ),

        /// 🔥 OFFLINE BAR
        Consumer<ConnectionProvider>(
          builder: (context, connectionProvider, child) {
            final l = AppLocalizations.of(context);
            return (!connectionProvider.isConnected)
                ? Container(
                    width: double.infinity,
                    color: Color(0xFFFDF5D2),
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        const Icon(Icons.wifi_off, color: Colors.black),
                        const SizedBox(width: 8),
                        Text(
                          l!.home_noInternet,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  @override
  // Size get preferredSize => const Size.fromHeight(kToolbarHeight + 24);
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 40);
}
