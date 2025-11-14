import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sail_in_co/core/constants/asset_icons.dart';
import 'package:sail_in_co/core/theme/app_color.dart';

class DevelopemntIconsScreen extends StatelessWidget {
  const DevelopemntIconsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final icons = {
      'carbonViewFilled': AssetIcons.carbonViewFilled,
      'f7Person2Fill': AssetIcons.f7Person2Fill,
      'fluentPayment20Filled': AssetIcons.fluentPayment20Filled,
      'fluentPersonSquareAdd16Filled': AssetIcons.fluentPersonSquareAdd16Filled,
      'formkitArrowRight': AssetIcons.formkitArrowRight,
      'frame180': AssetIcons.frame180,
      'ggPin': AssetIcons.ggPin,
      'icBaselinePlus': AssetIcons.icBaselinePlus,
      'icRoundDateRange': AssetIcons.icRoundDateRange,
      'materialSymbolsDelete': AssetIcons.materialSymbolsDelete,
      'materialSymbolsLocalShippingRounded': AssetIcons.materialSymbolsLocalShippingRounded,
      'materialSymbolsPersonOutlineRounded': AssetIcons.materialSymbolsPersonOutlineRounded,
      'materialSymbolsPrintRounded': AssetIcons.materialSymbolsPrintRounded,
      'materialSymbolsRefreshRounded': AssetIcons.materialSymbolsRefreshRounded,
      'mingcuteCarFill': AssetIcons.mingcuteCarFill,
      'mingcutePaperFill': AssetIcons.mingcutePaperFill,
      'qlementineIconsMenuDots16': AssetIcons.qlementineIconsMenuDots16,
      'riEditFill': AssetIcons.riEditFill,
      'typcnHome': AssetIcons.typcnHome,
    };

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.white),
        title: Text(
          'Icons',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textWhite),
        ),
        backgroundColor: AppColors.sky950,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: icons.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 12, mainAxisSpacing: 12),
          itemBuilder: (context, index) {
            final name = icons.keys.elementAt(index);
            final path = icons.values.elementAt(index);
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: SvgPicture.asset(path, width: 32, height: 32, colorFilter: const ColorFilter.mode(AppColors.sky950, BlendMode.srcIn))),
                    const SizedBox(height: 8),
                    Text(name, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10), maxLines: 2, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
