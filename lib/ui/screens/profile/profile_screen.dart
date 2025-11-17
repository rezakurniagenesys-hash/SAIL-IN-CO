import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
import 'package:sail_in_co/ui/widgets/app_bar_custom.dart';
import 'package:sail_in_co/ui/widgets/app_button.dart';
import 'package:sail_in_co/ui/widgets/app_input_field.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarCustom(title: l.setting_account),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l.setting_profilePhoto, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    Center(
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey[300]),
                      ),
                    ),
                    AppInputField(
                      label: l.setting_displayName,
                      hintText: l.setting_displayName,
                      borderSideColor: AppColors.neutral400,
                      type: AppInputType.text,
                      controller: TextEditingController(),
                      onChanged: (value) {
                        // handle search logic here
                      },
                    ),
                    AppInputField(
                      label: l.setting_email,
                      hintText: l.setting_email,
                      borderSideColor: AppColors.neutral400,
                      type: AppInputType.text,
                      controller: TextEditingController(),
                      onChanged: (value) {
                        // handle search logic here
                      },
                    ),
                    // Alamat
                    AppInputField(
                      label: l.setting_address,
                      hintText: l.setting_address,
                      borderSideColor: AppColors.neutral400,
                      type: AppInputType.textarea,
                      controller: TextEditingController(),
                      onChanged: (value) {
                        // handle search logic here
                      },
                    ),
                    // Nomor Telepon
                    AppInputField(
                      label: l.setting_phoneNumber,
                      hintText: l.setting_phoneNumber,
                      borderSideColor: AppColors.neutral400,
                      type: AppInputType.text,
                      controller: TextEditingController(),
                      onChanged: (value) {
                        // handle search logic here
                      },
                    ),
                    // Password Baru
                    AppInputField(
                      label: l.setting_newPassword,
                      hintText: l.setting_newPassword,
                      borderSideColor: AppColors.neutral400,
                      type: AppInputType.text,
                      controller: TextEditingController(),
                      onChanged: (value) {
                        // handle search logic here
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: AppButton(
              label: l.setting_saveChanges,
              type: AppButtonType.sky950,
              height: 48,
              isFullWidth: true,
              onPressed: () {
                // Handle save action
              },
            ),
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}
