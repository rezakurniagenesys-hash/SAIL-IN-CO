import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/providers/auth_provider.dart';
import 'package:sail_in_co/ui/widgets/app_button.dart';
import 'package:sail_in_co/ui/widgets/app_input_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.sky950,
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  padding: EdgeInsets.all(12),
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
                            ).showSnackBar(SnackBar(content: Text('Username dan kata sandi harus diisi'), behavior: SnackBarBehavior.floating));
                            return;
                          }
                          if (authProvider.isLoading) return;
                          authProvider.actionLogin(context);
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
                        },
                      ),
                    ],
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
