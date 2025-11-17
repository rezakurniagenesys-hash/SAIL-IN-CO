import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sail_in_co/core/helpers/image_picker_helper.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
import 'package:sail_in_co/ui/screens/adjustment/adjustment_screen.dart';
import 'package:sail_in_co/ui/screens/customer_detail/customer_edit/customer_edit_screen.dart';
import 'package:sail_in_co/ui/screens/customer_detail/widgets/customer_upload_foto.dart';
import 'package:sail_in_co/ui/screens/customer_detail/widgets/draggable_scrollable_sheet_detail_customer.dart';
import 'package:sail_in_co/ui/screens/order/order_screen.dart';
import 'package:sail_in_co/ui/screens/return/return_screen.dart';
import 'package:sail_in_co/ui/widgets/app_bar_custom.dart';
import 'package:sail_in_co/ui/widgets/app_button.dart';
import 'package:sail_in_co/ui/widgets/app_dialog.dart';

class CustomerDetailScreen extends StatefulWidget {
  const CustomerDetailScreen({super.key});

  @override
  State<CustomerDetailScreen> createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  File? image;

  Future<bool> pickImage() async {
    final picked = await ImagePickerHelper.pickImageDialog(context);
    if (picked != null) {
      setState(() => image = picked);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.sky700,
      appBar: AppBarCustom(title: l!.customerDetail_title, onRefresh: () {}),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 160),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Toko Bu Siti',
                      style: AppTextStyles.heading4Medium.copyWith(color: AppColors.white, fontWeight: FontWeight.w700),
                    ),
                    Row(
                      children: [
                        Container(
                          height: 5,
                          width: 5,
                          decoration: BoxDecoration(color: AppColors.error, shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 4),
                        Text(l.customerDetail_statusNotVisited, style: AppTextStyles.label2SemiBold.copyWith(color: AppColors.white)),
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
                          infoItem(l.customerDetail_customerCode, 'C0001'),
                          infoItem(l.customerDetail_paymentType, 'Credit'),
                          infoItem(l.customerDetail_salesCode, 'Jl. Merpati No. 45, Jakarta'),
                          infoItem(l.customerDetail_address, 'Jl. Jeruk Sidoarjo Gedangan'),
                          infoItem(l.customerDetail_ktp, '01231231312412'),
                          infoItem(l.customerDetail_creditLimit, 'Rp 2,000,000.00'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        spacing: 12,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          infoItem(l.customerDetail_warehouseCode, 'W.123123.12312'),
                          infoItem(l.customerDetail_customerType, 'Grosir'),
                          infoItem(l.customerDetail_area, 'Ketintang'),
                          infoItem(l.customerDetail_city, 'Surabaya'),
                          infoItem(l.customerDetail_phoneNumber, '085xxxxxxxx'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: AppButton(
                        label: l.customerDetail_editData,
                        type: AppButtonType.sky50,
                        height: 42,
                        isFullWidth: true,
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerEditScreen()));
                        },
                      ),
                    ),
                    Expanded(
                      child: AppButton(
                        label: l.customerDetail_uploadPhoto,
                        type: AppButtonType.sky50,
                        height: 42,
                        isFullWidth: true,
                        onPressed: () async {
                          final picked = await pickImage();
                          if (picked) {
                            AppDialog.show(
                              context: context,
                              title: 'Upload Foto',
                              paddingContent: 0,
                              content: CustomerUploadFoto(image: image),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: AppButton(
                        label: l.customerDetail_order,
                        type: AppButtonType.sky50,
                        height: 42,
                        isFullWidth: true,
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OrderScreen()));
                        },
                      ),
                    ),
                    Expanded(
                      child: AppButton(
                        label: l.customerDetail_adjustment,
                        type: AppButtonType.sky50,
                        height: 42,
                        isFullWidth: true,
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AdjustmentScreen()));
                        },
                      ),
                    ),
                    Expanded(
                      child: AppButton(
                        label: l.customerDetail_return,
                        type: AppButtonType.sky50,
                        height: 42,
                        isFullWidth: true,
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ReturnScreen()));
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          DraggableScrollableSheetDetailCustomer(),
        ],
      ),
    );
  }

  Widget infoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.label2SemiBold.copyWith(color: AppColors.white)),
        Text(value, style: AppTextStyles.body3Regular.copyWith(color: AppColors.white)),
      ],
    );
  }
}
