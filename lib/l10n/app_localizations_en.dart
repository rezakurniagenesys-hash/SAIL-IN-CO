// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get language => 'Language';

  @override
  String get languageSelect => 'English';

  @override
  String get appTitle => 'Sail In Co';

  @override
  String dashboardGreeting(Object name) {
    return 'Hello, $name';
  }

  @override
  String get dashboard_home => 'Home';

  @override
  String get dashboard_customers => 'Customers';

  @override
  String get dashboard_transportation => 'Transportation';

  @override
  String get dashboard_history => 'History';

  @override
  String get home_lastUpdate => 'Last Update';

  @override
  String get home_status => 'Status';

  @override
  String get home_online => 'Online';

  @override
  String get home_visited => 'Visited';

  @override
  String get home_notVisited => 'Not Visited';

  @override
  String get home_tasks => 'Tasks';

  @override
  String get home_stock => 'Stock';

  @override
  String get home_achievements => 'Achievements';

  @override
  String get home_registeredCustomers => 'Registered Customers';

  @override
  String get home_newCustomers => 'New Customers';

  @override
  String get home_soldStock => 'Sold Stock';

  @override
  String get home_noInternet => 'No internet connection';

  @override
  String get home_seeDetail => 'See Detail';

  @override
  String get home_settlement => 'Settlement';

  @override
  String get homeDialog_syncTitle => 'Data Synchronization';

  @override
  String get homeDialog_syncSubtitle => 'Start synchronization to ensure you are using the latest data while offline';

  @override
  String get homeDialog_inputKmStart => 'Enter Starting Kilometer';

  @override
  String get homeDialog_km => 'Km';

  @override
  String get homeDialog_inputDescription => 'Enter description';

  @override
  String get homeDialog_warningInternet => 'Make sure Internet is active to synchronize data!';

  @override
  String get homeDialog_syncButton => 'Initial Data Synchronization';

  @override
  String get homeDialog_syncNote => 'Stay online until synchronization is complete. You can continue using the application during the process.';

  @override
  String get customer_title => 'Customer Management';

  @override
  String get customer_list => 'Customer List';

  @override
  String get customer_search => 'Search';

  @override
  String get customer_visit => 'Visited';

  @override
  String get customer_notVisit => 'Not Visited';

  @override
  String get customerDetail_title => 'Customer Detail';

  @override
  String get customerDetail_customerName => 'Customer Name';

  @override
  String get customerDetail_customerCode => 'Customer Code';

  @override
  String get customerDetail_warehouseCode => 'Warehouse Code';

  @override
  String get customerDetail_paymentType => 'Payment Type';

  @override
  String get customerDetail_customerType => 'Customer Type';

  @override
  String get customerDetail_salesCode => 'Sales Code';

  @override
  String get customerDetail_area => 'Area';

  @override
  String get customerDetail_address => 'Address';

  @override
  String get customerDetail_city => 'City';

  @override
  String get customerDetail_ktp => 'ID Card';

  @override
  String get customerDetail_phoneNumber => 'Phone Number';

  @override
  String get customerDetail_creditLimit => 'Credit Limit';

  @override
  String get customerDetail_statusVisited => 'Visited';

  @override
  String get customerDetail_statusNotVisited => 'Not Visited';

  @override
  String get customerDetail_editData => 'Edit Data';

  @override
  String get customerDetail_editCustomerData => 'Edit Customer Data';

  @override
  String get customerDetail_uploadPhoto => 'Upload Photo';

  @override
  String get customerDetail_order => 'Order';

  @override
  String get customerDetail_adjustment => 'Adjustment';

  @override
  String get customerDetail_return => 'Return';

  @override
  String get customerDetail_activityHistory => 'Activity History';

  @override
  String get customerDetail_outstandingOrder => 'Outstanding Order';

  @override
  String get customerDetail_stock => 'Stock';

  @override
  String get customerDetail_filterAll => 'All';

  @override
  String get customerDetail_filterSales => 'Sales';

  @override
  String get customerDetail_filterOrder => 'Order';

  @override
  String get customerDetail_filterAdjustment => 'Adjustment';

  @override
  String get customerDetail_filterReturn => 'Return';

  @override
  String get customerDetail_labelCustomerName => 'Customer Name';

  @override
  String get customerDetail_labelAddress => 'Address';

  @override
  String get customerDetail_labelArea => 'Area';

  @override
  String get customerDetail_labelPhoneNumber => 'Phone Number';

  @override
  String get customerDetail_labelCustomerType => 'Customer Type';

  @override
  String get customerDetail_labelPaymentType => 'Payment Type';

  @override
  String get customerDetail_customerTypeRetail => 'Retail';

  @override
  String get customerDetail_customerTypeWholesale => 'Wholesale';

  @override
  String get customerDetail_paymentCash => 'Cash';

  @override
  String get customerDetail_paymentCredit => 'Credit';

  @override
  String get customerDetail_saveChanges => 'Save Changes';

  @override
  String get customerDetail_returnPayment => 'Return Payment';

  @override
  String get order_quickSales => 'Quick Sales';

  @override
  String get order_salesOrder => 'Sales Order';

  @override
  String get order_visit => 'Visit';

  @override
  String get order_notVisit => 'Not Visit';

  @override
  String get order_customerId => 'Customer ID';

  @override
  String get order_paymentType => 'Payment Type';

  @override
  String get order_salesId => 'Sales ID';

  @override
  String get order_address => 'Address';

  @override
  String get order_ktp => 'ID Card';

  @override
  String get order_warehouseId => 'Warehouse ID';

  @override
  String get order_city => 'City';

  @override
  String get order_area => 'Area';

  @override
  String get order_phoneNumber => 'Phone Number';

  @override
  String get order_inventoryDetail => 'Inventory Detail';

  @override
  String get order_addProduct => 'Add Product';

  @override
  String get order_edit => 'Edit';

  @override
  String get order_delete => 'Delete';

  @override
  String get order_discount => 'Discount';

  @override
  String get order_subtotal => 'Subtotal';

  @override
  String get order_grandTotalPayment => 'Grand Total';

  @override
  String get order_inventory => 'Inventory';

  @override
  String get order_qty => 'Qty';

  @override
  String get order_price => 'Price';

  @override
  String get order_uom => 'UoM';

  @override
  String get order_notes => 'Notes';

  @override
  String get order_total => 'Total';

  @override
  String get order_insert => 'Insert';

  @override
  String get order_payment => 'Payment';

  @override
  String get order_searchInventory => 'Search Inventory';

  @override
  String get order_selectInventory => 'Select Inventory';

  @override
  String get transportation_management => 'Transportation Management';

  @override
  String get transportation_history => 'History';

  @override
  String get transportation_add => 'Add';

  @override
  String get transportation_addTransportation => 'Add Transportation Management';

  @override
  String get transportation_editTransportation => 'Edit Transportation Management';

  @override
  String get transportation_viewTransportation => 'View Transportation Management';

  @override
  String get transportation_type => 'Type';

  @override
  String get transportation_vehicleNumber => 'Vehicle Number';

  @override
  String get transportation_date => 'Date';

  @override
  String get transportation_price => 'Price';

  @override
  String get transportation_notes => 'Notes';

  @override
  String get transportation_total => 'Total';

  @override
  String get transportation_insert => 'Insert';

  @override
  String get transportation_update => 'Update';

  @override
  String get transportation_photo => 'Photo';

  @override
  String get transaction_transactionHistory => 'Transaction History';

  @override
  String get transaction_customerFilter => 'Customer Filter';

  @override
  String get transaction_search => 'Search';

  @override
  String get transaction_all => 'All';

  @override
  String get transaction_sales => 'Sales';

  @override
  String get transaction_order => 'Order';

  @override
  String get transaction_adjustment => 'Adjustment';

  @override
  String get transaction_return => 'Return';

  @override
  String get transaction_visited => 'Visited';

  @override
  String get transaction_notVisited => 'Not Visited';

  @override
  String get transaction_salesTransaction => 'Sales Transaction';

  @override
  String get transaction_date => 'Date';

  @override
  String get transaction_warehouse => 'Warehouse';

  @override
  String get transaction_address => 'Address';

  @override
  String get transaction_idNumber => 'ID Number';

  @override
  String get transaction_paymentType => 'Payment Type';

  @override
  String get transaction_salesId => 'Sales ID';

  @override
  String get transaction_customerName => 'Customer Name';

  @override
  String get transaction_area => 'Area';

  @override
  String get transaction_phoneNumber => 'Phone Number';

  @override
  String get transaction_remarks => 'Remarks';

  @override
  String get transaction_inventoryDetail => 'Inventory Detail';

  @override
  String get transaction_add => 'Add';

  @override
  String get transaction_edit => 'Edit';

  @override
  String get transaction_delete => 'Delete';

  @override
  String get transaction_addProduct => 'Add Product';

  @override
  String get transaction_inventory => 'Inventory';

  @override
  String get transaction_qty => 'Qty';

  @override
  String get transaction_price => 'Price';

  @override
  String get transaction_uom => 'Unit';

  @override
  String get transaction_discount => 'Discount';

  @override
  String get transaction_notes => 'Notes';

  @override
  String get transaction_total => 'Total';

  @override
  String get transaction_insert => 'Insert';

  @override
  String get transaction_payment => 'Payment';

  @override
  String get setting_title => 'Settings';

  @override
  String get setting_account => 'Account';

  @override
  String get setting_language => 'Language';

  @override
  String get setting_helpSupport => 'Help & Support';

  @override
  String get setting_about => 'About';

  @override
  String get setting_profilePhoto => 'Profile Photo';

  @override
  String get setting_displayName => 'Display Name';

  @override
  String get setting_email => 'Email';

  @override
  String get setting_address => 'Address';

  @override
  String get setting_phoneNumber => 'Phone Number';

  @override
  String get setting_newPassword => 'New Password';

  @override
  String get setting_saveChanges => 'Save Changes';
}
