import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sail_in_co/core/constants/asset_icons.dart';
import 'package:sail_in_co/core/helpers/image_picker_helper.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/ui/screens/adjustment/adjustment_screen.dart';
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
    return Scaffold(
      backgroundColor: AppColors.sky700,
      appBar: AppBarCustom(title: 'Detail Customer', onRefresh: () {}),
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
                        Text('Not Visited', style: AppTextStyles.label2SemiBold.copyWith(color: AppColors.white)),
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
                AppButton(
                  label: 'Upload Foto',
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
                        content: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 430,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: AppColors.sky400,
                                    image: image != null ? DecorationImage(image: FileImage(image!), fit: BoxFit.cover) : null,
                                  ),
                                  child: image == null ? Icon(Icons.image, size: 64, color: AppColors.sky400) : null,
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                      child: Container(
                                        height: 78,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.3), // sedikit transparan agar blur kelihatan
                                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SvgPicture.asset(AssetIcons.ggPin, width: 24, height: 24, color: Colors.white),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Current Location', style: AppTextStyles.label3Medium.copyWith(color: Colors.white)),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      'Jl. Pucang Anom Timur III No.12, Kertajaya, Kec. Gubeng, Surabaya, Jawa Timur 60282',
                                                      style: AppTextStyles.body4Medium.copyWith(color: Colors.white),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: double.infinity,
                              height: 70,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [SvgPicture.asset(AssetIcons.circlePicture, width: 48, height: 48, color: AppColors.neutral950)],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: 12),
                Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: AppButton(
                        label: 'Order',
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
                        label: 'Adjustment',
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
                        label: 'Return',
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
