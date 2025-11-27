import 'package:flutter/material.dart';
import 'package:sail_in_co/data/repositories/customer_repository.dart';

class CustomerDetailProvider extends ChangeNotifier {
  final _repo = CustomerRepository();
}
