import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/ui/screens/adjustment/components/add_adjustment.dart';
import 'package:sail_in_co/ui/widgets/app_bar_custom.dart';
import 'package:sail_in_co/ui/widgets/app_button.dart';
import 'package:sail_in_co/ui/widgets/app_dialog.dart';
import 'package:sail_in_co/ui/widgets/app_dropdown_search.dart';

class AdjustmentScreen extends StatefulWidget {
  const AdjustmentScreen({super.key});

  @override
  State<AdjustmentScreen> createState() => _AdjustmentScreenState();
}

class _AdjustmentScreenState extends State<AdjustmentScreen> {
  String selectedInventory = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarCustom(title: 'Adjustment', onRefresh: () {}),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Toko Bu Siti',
                    style: AppTextStyles.heading4Medium.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w700),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 5,
                        width: 5,
                        decoration: BoxDecoration(color: AppColors.error, shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 4),
                      Text('Not Visited', style: AppTextStyles.label2SemiBold.copyWith(color: AppColors.textPrimary)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      spacing: 12,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        infoItem('Customer ID', 'C0001'),
                        infoItem('Jenis Pembayaran', 'Credit'),
                        infoItem('Sales ID', 'Jl. Merpati No. 45, Jakarta'),
                        infoItem('Alamat', 'Jl. Jeruk Sidoarjo Gedangan'),
                        infoItem('KTP', '01231231312412'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      spacing: 12,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        infoItem('Warehouse ID', 'W.123123.12312'),
                        infoItem('Kota', 'Surabaya'),
                        infoItem('Area', 'Ketintang'),
                        infoItem('Nomor HP', '085xxxxxxxx'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButton(
                    label: 'Add',
                    icon: Icons.add,
                    onPressed: () {
                      AppDialog.show(
                        context: context,
                        title: 'Add Product Adjustment',
                        content: AddAdjustment(),
                        actionButton: AppButton(
                          isFullWidth: true,
                          label: 'Insert',
                          height: 42,
                          type: AppButtonType.primary,
                          onPressed: () => Navigator.pop(context),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text('Search Inventory', style: AppTextStyles.body2Medium.copyWith(fontSize: 14, fontWeight: FontWeight.normal)),
              const SizedBox(height: 6),
              AppDropdownSearch(
                label: "Search Inventory",
                hintText: "Select Inventory",
                value: selectedInventory,
                items: const ['Inventory A', 'Inventory B', 'Inventory C', 'Inventory D'],
                onChanged: (value) => setState(() => selectedInventory = value ?? ''),
              ),
              const SizedBox(height: 12),
              Text('Detail Inventory', style: AppTextStyles.body2Medium.copyWith(fontSize: 14, fontWeight: FontWeight.normal)),
              const SizedBox(height: 6),
              for (var i = 0; i < 4; i++)
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.neutral400),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text('Rokok ABC Kategori A', style: AppTextStyles.body3Regular.copyWith(color: AppColors.textPrimary)),
                          ),
                          Text('100 Pack', style: AppTextStyles.body3Regular.copyWith(color: AppColors.textPrimary)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text('Last update : 23-10-2025', style: AppTextStyles.body4Medium.copyWith(color: AppColors.neutral400)),
                      const SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AppButton(
                            label: 'Edit Stock',
                            type: AppButtonType.warning,
                            onPressed: () {
                              AppDialog.show(
                                context: context,
                                title: 'Edit Product Adjustment',
                                content: AddAdjustment(),
                                actionButton: AppButton(
                                  isFullWidth: true,
                                  label: 'Update',
                                  height: 42,
                                  type: AppButtonType.primary,
                                  onPressed: () => Navigator.pop(context),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget infoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.label2SemiBold.copyWith(color: AppColors.textPrimary)),
        Text(value, style: AppTextStyles.body3Regular.copyWith(color: AppColors.textPrimary)),
      ],
    );
  }
}
