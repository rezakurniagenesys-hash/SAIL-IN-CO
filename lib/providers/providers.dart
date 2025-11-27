import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sail_in_co/providers/auth/auth_provider.dart';
import 'package:sail_in_co/providers/connection_provider.dart';
import 'package:sail_in_co/providers/customer/customer_management_provider.dart';
import 'package:sail_in_co/providers/home/home_provider.dart';

/// Daftar semua provider global
List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider(create: (_) => ConnectionProvider()),
  ChangeNotifierProvider(create: (_) => AuthProvider()),
  ChangeNotifierProvider(create: (_) => HomeProvider()),
  ChangeNotifierProvider(create: (_) => CustomerManagementProvider()),
];
