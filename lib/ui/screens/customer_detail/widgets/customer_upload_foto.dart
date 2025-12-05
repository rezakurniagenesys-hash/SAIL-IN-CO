// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sail_in_co/core/constants/asset_icons.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/providers/customer/customer_detail_provider.dart';
import 'package:sail_in_co/ui/widgets/app_button.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

enum CustomerUploadFotoAction { repick, submit }

class CustomerUploadFoto extends StatefulWidget {
  const CustomerUploadFoto({super.key, this.image, required this.customerId, required this.scheduleId});
  final File? image;
  final String customerId;
  final String scheduleId;

  @override
  State<CustomerUploadFoto> createState() => _CustomerUploadFotoState();
}

class _CustomerUploadFotoState extends State<CustomerUploadFoto> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider = context.read<CustomerDetailProvider>();
      provider.initLocation(context);
      provider.startDateTimeCounter(DateTime.now());
    });
  }

  @override
  void dispose() {
    context.read<CustomerDetailProvider>().stopTimer();
    super.dispose();
  }

  Widget _shimmerLine({double? width, double height = 12}) {
    return Shimmer(
      duration: const Duration(milliseconds: 1500),
      interval: const Duration(milliseconds: 300),
      color: Colors.grey.shade500,
      colorOpacity: 0.3,
      enabled: true,
      direction: ShimmerDirection.fromLeftToRight(),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(color: Colors.grey.shade400, borderRadius: BorderRadius.circular(4)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerDetailProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 600,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.sky400,
                    image: widget.image != null ? DecorationImage(image: FileImage(widget.image!), fit: BoxFit.cover) : null,
                  ),
                  child: widget.image == null ? Icon(Icons.image, size: 64, color: AppColors.sky400) : null,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      // switch store on off
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                              child: Container(
                                width: 155,
                                height: 42,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text('Toko Buka?', style: AppTextStyles.label3Medium.copyWith(color: Colors.white)),
                                      Transform.scale(
                                        scale: 0.7,
                                        child: Switch(
                                          value: provider.isStoreOpen,
                                          onChanged: (value) {
                                            provider.setStoreOpen(value);
                                          },
                                          activeColor: Colors.white,
                                          activeTrackColor: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      ClipRRect(
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(8)),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(8)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(AssetIcons.ggPin, width: 24, height: 24, color: Colors.white),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Current Location', style: AppTextStyles.label3Medium.copyWith(color: Colors.white)),
                                            Text(provider.time, style: AppTextStyles.label3Medium.copyWith(color: Colors.white)),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        provider.isLoadingLocation
                                            ? _shimmerLine(width: MediaQuery.of(context).size.width * 0.6, height: 14)
                                            : Text(
                                                provider.address,
                                                style: AppTextStyles.body4Medium.copyWith(color: Colors.white),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                        const SizedBox(height: 8),
                                        provider.isLoadingLocation
                                            ? _shimmerLine(width: 140, height: 12)
                                            : Text(
                                                provider.coords,
                                                style: AppTextStyles.body4Medium.copyWith(color: Colors.white),
                                                maxLines: 1,
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
                    ],
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AppButton(
                        label: 'Foto Ulang',
                        type: AppButtonType.neutral400,
                        height: 44,
                        onPressed: () async {
                          Navigator.pop(context, CustomerUploadFotoAction.repick);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppButton(
                        label: 'Simpan Foto',
                        isLoading: provider.isSubmitting,
                        height: 44,
                        isDisabled: provider.isLoadingLocation,
                        onPressed: () async {
                          provider.submitPhoto(widget.customerId, widget.scheduleId, context).then((res) {
                            if (res != null && res.status == true) {
                              Navigator.pop(context, CustomerUploadFotoAction.submit);
                            } else {
                              // show error
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(SnackBar(content: Text(res?.message ?? 'Gagal mengunggah foto. Silakan coba lagi.'), backgroundColor: Colors.red));
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
