import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sail_in_co/core/constants/asset_icons.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';

class CustomerUploadFoto extends StatelessWidget {
  const CustomerUploadFoto({super.key, this.image});
  final File? image;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
