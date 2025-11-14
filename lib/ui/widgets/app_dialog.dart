import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';

class AppDialog {
  static Future<void> show({
    required BuildContext context,
    required String title,
    required Widget content,
    Widget? actionButton,
    bool dismissible = false,
    double paddingContent = 16.0,
  }) {
    final heightScreen = MediaQuery.of(context).size.height;

    return showGeneralDialog(
      context: context,
      barrierDismissible: dismissible,
      barrierLabel: "Dialog",
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 280),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Dialog(
              backgroundColor: AppColors.white,
              insetPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: heightScreen * 0.8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //Header
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.sky950,
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.white),
                              onPressed: () => Navigator.pop(context),
                            ),
                            Expanded(
                              child: Text(title, style: AppTextStyles.body1Medium.copyWith(fontSize: 16, color: AppColors.white)),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //Scrollable content
                    Flexible(
                      child: SingleChildScrollView(padding: EdgeInsets.all(paddingContent), child: content),
                    ),

                    // Action button
                    if (actionButton != null) Padding(padding: const EdgeInsets.fromLTRB(16, 0, 16, 16), child: actionButton),
                  ],
                ),
              ),
            ),
          ),
        );
      },

      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.easeInOutCubicEmphasized);

        return FadeTransition(
          opacity: curvedAnimation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.06), // begin
              end: Offset.zero,
            ).animate(curvedAnimation),
            child: child,
          ),
        );
      },
    );
  }
}
