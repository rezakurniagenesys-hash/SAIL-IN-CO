import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/ui/widgets/app_dropdown_field.dart';
import 'package:sail_in_co/ui/widgets/app_input_field.dart';

class AddInventory extends StatelessWidget {
  const AddInventory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        AppInputField(
          label: 'Inventory',
          hintText: 'Inventory',
          borderSideColor: AppColors.neutral400,
          controller: TextEditingController(),
          onChanged: (value) {
            // handle search logic here
          },
        ),
        AppInputField(
          label: 'Qty',
          hintText: 'Qry',
          borderSideColor: AppColors.neutral400,
          type: AppInputType.number,
          controller: TextEditingController(),
          onChanged: (value) {
            // handle search logic here
          },
        ),
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
        AppDropdownField(borderSideColor: AppColors.neutral400, label: 'UoM', value: null, items: ['Pcs', 'Box'], onChanged: (value) {}),
        AppInputField(
          label: 'Discount',
          hintText: 'Discount',
          type: AppInputType.number,
          borderSideColor: AppColors.neutral400,
          controller: TextEditingController(),
          onChanged: (value) {
            // handle search logic here
          },
        ),
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
