import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sail_in_co/providers/auth/auth_provider.dart';
import 'package:sail_in_co/providers/callsheet/finish_task_provider.dart';
import 'package:sail_in_co/providers/connection_provider.dart';
import 'package:sail_in_co/providers/customer/customer_detail_provider.dart';
import 'package:sail_in_co/providers/customer/customer_management_provider.dart';
import 'package:sail_in_co/providers/generals/general_providers.dart';
import 'package:sail_in_co/providers/home/home_provider.dart';
import 'package:sail_in_co/providers/order/general_order_provider.dart';
import 'package:sail_in_co/providers/order/quick_sales_provider.dart';
import 'package:sail_in_co/providers/order/sales_order_provider.dart';
import 'package:sail_in_co/providers/payment/payment_provider.dart';
import 'package:sail_in_co/providers/return/return_provider.dart';
import 'package:sail_in_co/providers/sales/sales_provider.dart';
import 'package:sail_in_co/providers/stock/stock_provider.dart';
import 'package:sail_in_co/providers/sync/sync_provider.dart';

/// Daftar semua provider global
List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider(create: (_) => ConnectionProvider()),
  ChangeNotifierProvider(create: (_) => AuthProvider()),
  ChangeNotifierProvider(create: (_) => HomeProvider()),
  ChangeNotifierProvider(create: (_) => CustomerManagementProvider()),
  ChangeNotifierProvider(create: (_) => CustomerDetailProvider()),
  ChangeNotifierProvider(create: (_) => StockProvider()),
  ChangeNotifierProvider(create: (_) => GeneralProviders()),

  // Callsheet
  ChangeNotifierProvider(create: (_) => FinishTaskProvider()),

  //Payment
  ChangeNotifierProvider(create: (_) => PaymentProvider()),

  // Sync
  ChangeNotifierProvider(create: (_) => SyncProvider()),

  // Order
  ChangeNotifierProvider(create: (_) => GeneralOrderProvider()),
  ChangeNotifierProvider(create: (_) => QuickSalesProvider()),
  ChangeNotifierProvider(create: (_) => SalesOrderProvider()),

  // Return
  ChangeNotifierProvider(create: (_) => ReturnProvider()),

  //Sales
  ChangeNotifierProvider(create: (_) => SalesProvider()),
];
