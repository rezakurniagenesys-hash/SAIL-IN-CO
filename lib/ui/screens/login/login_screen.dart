import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/providers/auth/auth_provider.dart';
import 'package:sail_in_co/ui/widgets/app_button.dart';
import 'package:sail_in_co/ui/widgets/app_dialog.dart';
import 'package:sail_in_co/ui/widgets/app_input_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.sky950,
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 12,
                        children: [
                          InkWell(
                            onDoubleTap: () => authProvider.setDebugLogin(),
                            child: Container(
                              height: 100,
                              width: double.infinity,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColors.sky800),
                            ),
                          ),
                          AppInputField(
                            title: 'Username',
                            height: 40,
                            hintText: 'Masukkan username',
                            borderSideColor: AppColors.neutral400,
                            controller: authProvider.usernameController,
                          ),
                          AppInputField(
                            title: 'Kata Sandi',
                            height: 40,
                            hintText: 'Masukkan kata sandi',
                            borderSideColor: AppColors.neutral400,
                            controller: authProvider.passwordController,
                          ),
                          AppButton(
                            isFullWidth: true,
                            label: 'Login',
                            isLoading: authProvider.isLoading,
                            onPressed: () {
                              if (authProvider.usernameController.text.isEmpty || authProvider.passwordController.text.isEmpty) {
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(const SnackBar(content: Text('Username dan kata sandi harus diisi'), behavior: SnackBarBehavior.floating));
                                return;
                              }
                              if (authProvider.isLoading) return;
                              authProvider.actionLogin(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              /// ------------------------------------------
              /// 🔽 BUTTON GANTI ENV DI BAGIAN BAWAH LAYAR
              /// ------------------------------------------
              Positioned(
                bottom: 38,
                left: 0,
                right: 0,
                child: Center(
                  child: InkWell(
                    onTap: () {
                      AppDialog.show(
                        context: context,
                        title: 'Ganti Environment',
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Pilih environment yang diinginkan:', style: AppTextStyles.body3Regular),
                            const SizedBox(height: 12),
                            AppButton(
                              isFullWidth: true,
                              label: 'LIVE',
                              type: AppButtonType.primary,
                              onPressed: () {
                                // AuthService.setEnvironment(isLive: true);
                                Navigator.pop(context);
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(const SnackBar(content: Text('Environment diubah ke LIVE'), behavior: SnackBarBehavior.floating));
                              },
                            ),
                            const SizedBox(height: 8),
                            AppButton(
                              isFullWidth: true,
                              label: 'DEV',
                              hasBorder: true,
                              borderColor: AppColors.sky700,
                              type: AppButtonType.sky50,
                              onPressed: () {
                                // AuthService.setEnvironment(isLive: false);
                                Navigator.pop(context);
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(const SnackBar(content: Text('Environment diubah ke DEV'), behavior: SnackBarBehavior.floating));
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white30),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.cloud_sync, color: Colors.white, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            // "Environment: ${authProvider.isLive ? "LIVE" : "DEV"}",
                            "Environment: ",
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
