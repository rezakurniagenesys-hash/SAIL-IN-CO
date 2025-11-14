import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';

class AppHorizontalMenuTab extends StatefulWidget {
  final List<String> tabs;
  final Function(String) onChanged;
  final String initialValue;

  const AppHorizontalMenuTab({super.key, required this.tabs, required this.onChanged, required this.initialValue});

  @override
  State<AppHorizontalMenuTab> createState() => _AppHorizontalMenuTabState();
}

class _AppHorizontalMenuTabState extends State<AppHorizontalMenuTab> {
  late String selectedTab;

  @override
  void initState() {
    super.initState();
    selectedTab = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.tabs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = widget.tabs[index];
          final isSelected = item == selectedTab;

          return GestureDetector(
            onTap: () {
              setState(() => selectedTab = item);
              widget.onChanged(item);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(color: isSelected ? AppColors.sky950 : Colors.transparent, borderRadius: BorderRadius.circular(6)),
              child: Text(
                item,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: isSelected ? Colors.white : Colors.black),
              ),
            ),
          );
        },
      ),
    );
  }
}
