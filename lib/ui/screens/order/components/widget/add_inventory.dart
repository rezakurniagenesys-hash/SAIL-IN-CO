import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
import 'package:sail_in_co/ui/widgets/app_dropdown_field.dart';
import 'package:sail_in_co/ui/widgets/app_input_field.dart';

class AddInventory extends StatelessWidget {
  const AddInventory({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Column(
      spacing: 12,
      children: [
        AppInputField(
          label: l!.order_inventory,
          hintText: l.order_inventory,
          borderSideColor: AppColors.neutral400,
          controller: TextEditingController(),
          onChanged: (value) {
            // handle search logic here
          },
        ),
        AppInputField(
          label: l.order_qty,
          hintText: l.order_qty,
          borderSideColor: AppColors.neutral400,
          type: AppInputType.number,
          controller: TextEditingController(),
          onChanged: (value) {
            // handle search logic here
          },
        ),
        AppInputField(
          label: l.order_price,
          hintText: l.order_price,
          type: AppInputType.number,
          borderSideColor: AppColors.neutral400,
          controller: TextEditingController(),
          onChanged: (value) {
            // handle search logic here
          },
        ),
        AppDropdownField(borderSideColor: AppColors.neutral400, label: l.order_uom, value: null, items: ['Pcs', 'Box'], onChanged: (value) {}),
        AppInputField(
          label: l.order_discount,
          hintText: l.order_discount,
          type: AppInputType.number,
          borderSideColor: AppColors.neutral400,
          controller: TextEditingController(),
          onChanged: (value) {
            // handle search logic here
          },
        ),
        AppInputField(
          label: l.order_notes,
          hintText: l.order_notes,
          type: AppInputType.textarea,
          borderSideColor: AppColors.neutral400,
          controller: TextEditingController(),
          onChanged: (value) {
            // handle search logic here
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(l.order_total, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text('Rp 10.000,00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ],
    );
  }
}
