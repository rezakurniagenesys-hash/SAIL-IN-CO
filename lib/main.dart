import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sail_in_co/app.dart';
import 'package:sail_in_co/providers/providers.dart';

void main() {
  runApp(MultiProvider(providers: appProviders, child: const MyApp()));
}
