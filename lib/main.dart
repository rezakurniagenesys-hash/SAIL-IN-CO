import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sail_in_co/app.dart';
import 'package:sail_in_co/providers/providers.dart';
import 'package:sail_in_co/services/locale_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final localeService = LocaleService();
  await localeService.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LocaleService>.value(value: localeService),
        ...appProviders, 
      ],
      child: const MyApp(),
    ),
  );
}
