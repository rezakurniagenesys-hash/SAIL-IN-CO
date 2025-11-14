import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/ui/widgets/app_dropdown_field.dart';
import 'package:sail_in_co/ui/widgets/app_input_field.dart';

class AddTransportScreen extends StatelessWidget {
  const AddTransportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppDropdownField(borderSideColor: AppColors.neutral400, label: 'Tipe', value: null, items: ['Service', 'BBM'], onChanged: (value) {}),
        const SizedBox(height: 12),
        AppInputField(
          label: 'Nomor Kendaraan',
          hintText: 'Nomor Kendaraan',
          borderSideColor: AppColors.neutral400,
          controller: TextEditingController(),
          onChanged: (value) {
            // handle search logic here
          },
        ),

        const SizedBox(height: 12),
        AppInputField(
          label: 'Date',
          hintText: 'Date',
          type: AppInputType.date,
          borderSideColor: AppColors.neutral400,
          controller: TextEditingController(),
          onChanged: (value) {
            // handle search logic here
          },
        ),
        const SizedBox(height: 12),
        AppInputField(
          label: 'Price',
          hintText: 'Price',
          type: AppInputType.number,
          borderSideColor: AppColors.neutral400,
          controller: TextEditingController(),
          onChanged: (value) {
            // handle search logic here
          },
        ),

        const SizedBox(height: 12),
        AppInputField(
          label: 'Notes',
          hintText: 'Notes',
          type: AppInputType.textarea,
          borderSideColor: AppColors.neutral400,
          controller: TextEditingController(),
          onChanged: (value) {
            // handle search logic here
          },
        ),
        const SizedBox(height: 16),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.neutral400),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: List.generate(3, (index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.add_photo_alternate_outlined),
                  );
                }),
              ),
            ),
            Positioned(
              left: 14,
              top: -8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                color: AppColors.white,
                child: Text('Foto', style: AppTextStyles.body3Medium.copyWith(color: AppColors.neutral300)),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text('Rp 10.000,00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ],
    );
  }
}
