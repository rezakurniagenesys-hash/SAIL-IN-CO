import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
import 'package:sail_in_co/ui/screens/transport/add_transport/add_transport_screen.dart';
import 'package:sail_in_co/ui/screens/transport/components/item_transport_history.dart';
import 'package:sail_in_co/ui/widgets/app_bar_custom.dart';
import 'package:sail_in_co/ui/widgets/app_button.dart';
import 'package:sail_in_co/ui/widgets/app_dialog.dart';

class TransportScreen extends StatelessWidget {
  const TransportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarCustom(title: l.transportation_management, onRefresh: () {}, showBack: false),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          spacing: 12,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l.transportation_history, style: AppTextStyles.body2Medium.copyWith(fontSize: 16)),
                AppButton(
                  label: l.transportation_add,
                  type: AppButtonType.sky950,
                  onPressed: () {
                    AppDialog.show(
                      context: context,
                      title: l.transportation_addTransportation,
                      content: const AddTransportScreen(),
                      actionButton: AppButton(
                        isFullWidth: true,
                        label: l.transportation_insert,
                        height: 42,
                        type: AppButtonType.primary,
                        onPressed: () => Navigator.pop(context),
                      ),
                    );
                  },
                ),
              ],
            ),
            Divider(color: AppColors.grey),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ItemTransportHistory();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
