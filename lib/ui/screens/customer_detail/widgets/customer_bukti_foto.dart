// ignore_for_file: use_build_context_synchronously, deprecated_member_use
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sail_in_co/core/constants/asset_icons.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/data/models/customer/customer_detail_response.dart';

class CustomerBuktiFoto extends StatelessWidget {
  const CustomerBuktiFoto({super.key, this.data});
  final CustomerDetailData? data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 600,
              width: double.infinity,
              decoration: BoxDecoration(color: AppColors.sky400),
              child: data?.customer?.linkPath == null || data!.customer!.linkPath!.isEmpty
                  ? Icon(Icons.image, size: 64, color: AppColors.sky400)
                  : Image.network(
                      data!.customer!.linkPath!,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;

                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(child: Icon(Icons.broken_image, size: 64));
                      },
                    ),
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
                                      value: data?.customer?.statusVisit == 2 ? true : false,
                                      onChanged: (value) {},
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
                                        Text(
                                          formatTime(data?.customer?.visitDate ?? DateTime.now()),
                                          style: AppTextStyles.label3Medium.copyWith(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      data?.customer?.visitAddress ?? '-',
                                      style: AppTextStyles.body4Medium.copyWith(color: Colors.white),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Lat: ${data?.customer?.latitude ?? '-'}, Long: ${data?.customer?.longitude ?? '-'}',
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
      ],
    );
  }

  // Format time HH:MM:SS
  String formatTime(DateTime time) {
    final localTime = time.toUtc().add(const Duration(hours: 7));
    final hh = localTime.hour.toString().padLeft(2, '0');
    final mm = localTime.minute.toString().padLeft(2, '0');
    final ss = localTime.second.toString().padLeft(2, '0');
    return '$hh:$mm:$ss';
  }
}
