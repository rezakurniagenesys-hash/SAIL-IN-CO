import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sail_in_co/providers/connection_provider.dart';

/// Daftar semua provider global
List<SingleChildWidget> appProviders = [ChangeNotifierProvider(create: (_) => ConnectionProvider())];
