import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/development/bottommenu/development_bottom_menu.dart';
import 'package:sail_in_co/development/button/development_button_screen.dart';
import 'package:sail_in_co/development/icons/development_icons_screen.dart';

class DevelopmentScreen extends StatelessWidget {
  const DevelopmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_DevMenuItem> menuItems = [
      _DevMenuItem(
        title: 'Button',
        icon: Icons.developer_mode,
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DevelopmentButtonScreen()));
        },
      ),
      _DevMenuItem(
        title: 'Icon',
        icon: Icons.developer_mode,
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DevelopemntIconsScreen()));
        },
      ),
      _DevMenuItem(
        title: 'Bottom Menu',
        icon: Icons.developer_mode,
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DevelopmentBottomMenu()));
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Development Menu',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textWhite),
        ),
        backgroundColor: AppColors.sky950,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(10),
        itemCount: menuItems.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue[50],
                child: Icon(item.icon, color: AppColors.sky950),
              ),
              title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
              trailing: const Icon(Icons.chevron_right),
              onTap: item.onTap,
            ),
          );
        },
      ),
    );
  }
}

class _DevMenuItem {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  _DevMenuItem({required this.title, required this.icon, required this.onTap});
}
