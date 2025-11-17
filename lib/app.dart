import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
import 'package:sail_in_co/services/locale_service.dart';
import 'package:sail_in_co/ui/screens/login/login_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeService = Provider.of<LocaleService>(context);

    return MaterialApp(
      title: 'Sail In Co',
      debugShowCheckedModeBanner: false,

      // SETTING LOCALE
      locale: localeService.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // THEME
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.sky950),
        useMaterial3: true,
      ),

      home: const LoginScreen(),
    );
  }
}
