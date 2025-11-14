import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/ui/widgets/app_button.dart';

class DevelopmentButtonScreen extends StatelessWidget {
  const DevelopmentButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.white),
        title: Text(
          'Button',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textWhite),
        ),
        backgroundColor: AppColors.sky950,
      ),
      body: Column(
        children: [
          AppButton(label: 'Return Request', type: AppButtonType.warning, onPressed: () {}),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: AppButton(label: 'Edit', type: AppButtonType.warning, onPressed: () {}),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: AppButton(label: 'Hapus', type: AppButtonType.danger, onPressed: () {}),
              ),
            ],
          ),
          const SizedBox(height: 20),
          AppButton(label: 'Save', type: AppButtonType.primary, isFullWidth: true, onPressed: () {}),
        ],
      ),
    );
  }
}
