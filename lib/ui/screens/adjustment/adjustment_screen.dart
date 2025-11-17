import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
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
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarCustom(title: l!.customerDetail_adjustment, onRefresh: () {}),
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
                      Text(l.order_notVisit, style: AppTextStyles.label2SemiBold.copyWith(color: AppColors.textPrimary)),
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
                        infoItem(l.order_customerId, 'C0001'),
                        infoItem(l.order_paymentType, 'Credit'),
                        infoItem(l.order_salesId, 'Jl. Merpati No. 45, Jakarta'),
                        infoItem(l.order_address, 'Jl. Jeruk Sidoarjo Gedangan'),
                        infoItem(l.order_ktp, '01231231312412'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      spacing: 12,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        infoItem(l.order_warehouseId, 'W.123123.12312'),
                        infoItem(l.order_city, 'Surabaya'),
                        infoItem(l.order_area, 'Ketintang'),
                        infoItem(l.order_phoneNumber, '085xxxxxxxx'),
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
                    label: l.order_addProduct,
                    icon: Icons.add,
                    onPressed: () {
                      AppDialog.show(
                        context: context,
                        title: l.order_addProduct,
                        content: AddAdjustment(),
                        actionButton: AppButton(
                          isFullWidth: true,
                          label: l.order_insert,
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
              Text(l.order_searchInventory, style: AppTextStyles.body2Medium.copyWith(fontSize: 14, fontWeight: FontWeight.normal)),
              const SizedBox(height: 6),
              AppDropdownSearch(
                label: l.order_searchInventory,
                hintText: l.order_selectInventory,
                value: selectedInventory,
                items: const ['Inventory A', 'Inventory B', 'Inventory C', 'Inventory D'],
                onChanged: (value) => setState(() => selectedInventory = value ?? ''),
              ),
              const SizedBox(height: 12),
              Text(l.order_inventoryDetail, style: AppTextStyles.body2Medium.copyWith(fontSize: 14, fontWeight: FontWeight.normal)),
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
                            label: l.order_edit,
                            type: AppButtonType.warning,
                            onPressed: () {
                              AppDialog.show(
                                context: context,
                                title: l.order_edit,
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
