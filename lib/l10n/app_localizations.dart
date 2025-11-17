import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id')
  ];

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageSelect.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageSelect;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Sail In Co'**
  String get appTitle;

  /// dashboardGreeting (auto-generated)
  ///
  /// In en, this message translates to:
  /// **'Hello, {name}'**
  String dashboardGreeting(Object name);

  /// No description provided for @dashboard_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get dashboard_home;

  /// No description provided for @dashboard_customers.
  ///
  /// In en, this message translates to:
  /// **'Customers'**
  String get dashboard_customers;

  /// No description provided for @dashboard_transportation.
  ///
  /// In en, this message translates to:
  /// **'Transportation'**
  String get dashboard_transportation;

  /// No description provided for @dashboard_history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get dashboard_history;

  /// No description provided for @home_lastUpdate.
  ///
  /// In en, this message translates to:
  /// **'Last Update'**
  String get home_lastUpdate;

  /// No description provided for @home_status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get home_status;

  /// No description provided for @home_online.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get home_online;

  /// No description provided for @home_visited.
  ///
  /// In en, this message translates to:
  /// **'Visited'**
  String get home_visited;

  /// No description provided for @home_notVisited.
  ///
  /// In en, this message translates to:
  /// **'Not Visited'**
  String get home_notVisited;

  /// No description provided for @home_tasks.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get home_tasks;

  /// No description provided for @home_stock.
  ///
  /// In en, this message translates to:
  /// **'Stock'**
  String get home_stock;

  /// No description provided for @home_achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get home_achievements;

  /// No description provided for @home_registeredCustomers.
  ///
  /// In en, this message translates to:
  /// **'Registered Customers'**
  String get home_registeredCustomers;

  /// No description provided for @home_newCustomers.
  ///
  /// In en, this message translates to:
  /// **'New Customers'**
  String get home_newCustomers;

  /// No description provided for @home_soldStock.
  ///
  /// In en, this message translates to:
  /// **'Sold Stock'**
  String get home_soldStock;

  /// No description provided for @home_noInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get home_noInternet;

  /// No description provided for @home_seeDetail.
  ///
  /// In en, this message translates to:
  /// **'See Detail'**
  String get home_seeDetail;

  /// No description provided for @home_settlement.
  ///
  /// In en, this message translates to:
  /// **'Settlement'**
  String get home_settlement;

  /// No description provided for @homeDialog_syncTitle.
  ///
  /// In en, this message translates to:
  /// **'Data Synchronization'**
  String get homeDialog_syncTitle;

  /// No description provided for @homeDialog_syncSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Start synchronization to ensure you are using the latest data while offline'**
  String get homeDialog_syncSubtitle;

  /// No description provided for @homeDialog_inputKmStart.
  ///
  /// In en, this message translates to:
  /// **'Enter Starting Kilometer'**
  String get homeDialog_inputKmStart;

  /// No description provided for @homeDialog_km.
  ///
  /// In en, this message translates to:
  /// **'Km'**
  String get homeDialog_km;

  /// No description provided for @homeDialog_inputDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter description'**
  String get homeDialog_inputDescription;

  /// No description provided for @homeDialog_warningInternet.
  ///
  /// In en, this message translates to:
  /// **'Make sure Internet is active to synchronize data!'**
  String get homeDialog_warningInternet;

  /// No description provided for @homeDialog_syncButton.
  ///
  /// In en, this message translates to:
  /// **'Initial Data Synchronization'**
  String get homeDialog_syncButton;

  /// No description provided for @homeDialog_syncNote.
  ///
  /// In en, this message translates to:
  /// **'Stay online until synchronization is complete. You can continue using the application during the process.'**
  String get homeDialog_syncNote;

  /// No description provided for @customer_title.
  ///
  /// In en, this message translates to:
  /// **'Customer Management'**
  String get customer_title;

  /// No description provided for @customer_list.
  ///
  /// In en, this message translates to:
  /// **'Customer List'**
  String get customer_list;

  /// No description provided for @customer_search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get customer_search;

  /// No description provided for @customer_visit.
  ///
  /// In en, this message translates to:
  /// **'Visited'**
  String get customer_visit;

  /// No description provided for @customer_notVisit.
  ///
  /// In en, this message translates to:
  /// **'Not Visited'**
  String get customer_notVisit;

  /// No description provided for @customerDetail_title.
  ///
  /// In en, this message translates to:
  /// **'Customer Detail'**
  String get customerDetail_title;

  /// No description provided for @customerDetail_customerName.
  ///
  /// In en, this message translates to:
  /// **'Customer Name'**
  String get customerDetail_customerName;

  /// No description provided for @customerDetail_customerCode.
  ///
  /// In en, this message translates to:
  /// **'Customer Code'**
  String get customerDetail_customerCode;

  /// No description provided for @customerDetail_warehouseCode.
  ///
  /// In en, this message translates to:
  /// **'Warehouse Code'**
  String get customerDetail_warehouseCode;

  /// No description provided for @customerDetail_paymentType.
  ///
  /// In en, this message translates to:
  /// **'Payment Type'**
  String get customerDetail_paymentType;

  /// No description provided for @customerDetail_customerType.
  ///
  /// In en, this message translates to:
  /// **'Customer Type'**
  String get customerDetail_customerType;

  /// No description provided for @customerDetail_salesCode.
  ///
  /// In en, this message translates to:
  /// **'Sales Code'**
  String get customerDetail_salesCode;

  /// No description provided for @customerDetail_area.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get customerDetail_area;

  /// No description provided for @customerDetail_address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get customerDetail_address;

  /// No description provided for @customerDetail_city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get customerDetail_city;

  /// No description provided for @customerDetail_ktp.
  ///
  /// In en, this message translates to:
  /// **'ID Card'**
  String get customerDetail_ktp;

  /// No description provided for @customerDetail_phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get customerDetail_phoneNumber;

  /// No description provided for @customerDetail_creditLimit.
  ///
  /// In en, this message translates to:
  /// **'Credit Limit'**
  String get customerDetail_creditLimit;

  /// No description provided for @customerDetail_statusVisited.
  ///
  /// In en, this message translates to:
  /// **'Visited'**
  String get customerDetail_statusVisited;

  /// No description provided for @customerDetail_statusNotVisited.
  ///
  /// In en, this message translates to:
  /// **'Not Visited'**
  String get customerDetail_statusNotVisited;

  /// No description provided for @customerDetail_editData.
  ///
  /// In en, this message translates to:
  /// **'Edit Data'**
  String get customerDetail_editData;

  /// No description provided for @customerDetail_editCustomerData.
  ///
  /// In en, this message translates to:
  /// **'Edit Customer Data'**
  String get customerDetail_editCustomerData;

  /// No description provided for @customerDetail_uploadPhoto.
  ///
  /// In en, this message translates to:
  /// **'Upload Photo'**
  String get customerDetail_uploadPhoto;

  /// No description provided for @customerDetail_order.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get customerDetail_order;

  /// No description provided for @customerDetail_adjustment.
  ///
  /// In en, this message translates to:
  /// **'Adjustment'**
  String get customerDetail_adjustment;

  /// No description provided for @customerDetail_return.
  ///
  /// In en, this message translates to:
  /// **'Return'**
  String get customerDetail_return;

  /// No description provided for @customerDetail_activityHistory.
  ///
  /// In en, this message translates to:
  /// **'Activity History'**
  String get customerDetail_activityHistory;

  /// No description provided for @customerDetail_outstandingOrder.
  ///
  /// In en, this message translates to:
  /// **'Outstanding Order'**
  String get customerDetail_outstandingOrder;

  /// No description provided for @customerDetail_stock.
  ///
  /// In en, this message translates to:
  /// **'Stock'**
  String get customerDetail_stock;

  /// No description provided for @customerDetail_filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get customerDetail_filterAll;

  /// No description provided for @customerDetail_filterSales.
  ///
  /// In en, this message translates to:
  /// **'Sales'**
  String get customerDetail_filterSales;

  /// No description provided for @customerDetail_filterOrder.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get customerDetail_filterOrder;

  /// No description provided for @customerDetail_filterAdjustment.
  ///
  /// In en, this message translates to:
  /// **'Adjustment'**
  String get customerDetail_filterAdjustment;

  /// No description provided for @customerDetail_filterReturn.
  ///
  /// In en, this message translates to:
  /// **'Return'**
  String get customerDetail_filterReturn;

  /// No description provided for @customerDetail_labelCustomerName.
  ///
  /// In en, this message translates to:
  /// **'Customer Name'**
  String get customerDetail_labelCustomerName;

  /// No description provided for @customerDetail_labelAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get customerDetail_labelAddress;

  /// No description provided for @customerDetail_labelArea.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get customerDetail_labelArea;

  /// No description provided for @customerDetail_labelPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get customerDetail_labelPhoneNumber;

  /// No description provided for @customerDetail_labelCustomerType.
  ///
  /// In en, this message translates to:
  /// **'Customer Type'**
  String get customerDetail_labelCustomerType;

  /// No description provided for @customerDetail_labelPaymentType.
  ///
  /// In en, this message translates to:
  /// **'Payment Type'**
  String get customerDetail_labelPaymentType;

  /// No description provided for @customerDetail_customerTypeRetail.
  ///
  /// In en, this message translates to:
  /// **'Retail'**
  String get customerDetail_customerTypeRetail;

  /// No description provided for @customerDetail_customerTypeWholesale.
  ///
  /// In en, this message translates to:
  /// **'Wholesale'**
  String get customerDetail_customerTypeWholesale;

  /// No description provided for @customerDetail_paymentCash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get customerDetail_paymentCash;

  /// No description provided for @customerDetail_paymentCredit.
  ///
  /// In en, this message translates to:
  /// **'Credit'**
  String get customerDetail_paymentCredit;

  /// No description provided for @customerDetail_saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get customerDetail_saveChanges;

  /// No description provided for @customerDetail_returnPayment.
  ///
  /// In en, this message translates to:
  /// **'Return Payment'**
  String get customerDetail_returnPayment;

  /// No description provided for @order_quickSales.
  ///
  /// In en, this message translates to:
  /// **'Quick Sales'**
  String get order_quickSales;

  /// No description provided for @order_salesOrder.
  ///
  /// In en, this message translates to:
  /// **'Sales Order'**
  String get order_salesOrder;

  /// No description provided for @order_visit.
  ///
  /// In en, this message translates to:
  /// **'Visit'**
  String get order_visit;

  /// No description provided for @order_notVisit.
  ///
  /// In en, this message translates to:
  /// **'Not Visit'**
  String get order_notVisit;

  /// No description provided for @order_customerId.
  ///
  /// In en, this message translates to:
  /// **'Customer ID'**
  String get order_customerId;

  /// No description provided for @order_paymentType.
  ///
  /// In en, this message translates to:
  /// **'Payment Type'**
  String get order_paymentType;

  /// No description provided for @order_salesId.
  ///
  /// In en, this message translates to:
  /// **'Sales ID'**
  String get order_salesId;

  /// No description provided for @order_address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get order_address;

  /// No description provided for @order_ktp.
  ///
  /// In en, this message translates to:
  /// **'ID Card'**
  String get order_ktp;

  /// No description provided for @order_warehouseId.
  ///
  /// In en, this message translates to:
  /// **'Warehouse ID'**
  String get order_warehouseId;

  /// No description provided for @order_city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get order_city;

  /// No description provided for @order_area.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get order_area;

  /// No description provided for @order_phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get order_phoneNumber;

  /// No description provided for @order_inventoryDetail.
  ///
  /// In en, this message translates to:
  /// **'Inventory Detail'**
  String get order_inventoryDetail;

  /// No description provided for @order_addProduct.
  ///
  /// In en, this message translates to:
  /// **'Add Product'**
  String get order_addProduct;

  /// No description provided for @order_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get order_edit;

  /// No description provided for @order_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get order_delete;

  /// No description provided for @order_discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get order_discount;

  /// No description provided for @order_subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get order_subtotal;

  /// No description provided for @order_grandTotalPayment.
  ///
  /// In en, this message translates to:
  /// **'Grand Total'**
  String get order_grandTotalPayment;

  /// No description provided for @order_inventory.
  ///
  /// In en, this message translates to:
  /// **'Inventory'**
  String get order_inventory;

  /// No description provided for @order_qty.
  ///
  /// In en, this message translates to:
  /// **'Qty'**
  String get order_qty;

  /// No description provided for @order_price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get order_price;

  /// No description provided for @order_uom.
  ///
  /// In en, this message translates to:
  /// **'UoM'**
  String get order_uom;

  /// No description provided for @order_notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get order_notes;

  /// No description provided for @order_total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get order_total;

  /// No description provided for @order_insert.
  ///
  /// In en, this message translates to:
  /// **'Insert'**
  String get order_insert;

  /// No description provided for @order_payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get order_payment;

  /// No description provided for @order_searchInventory.
  ///
  /// In en, this message translates to:
  /// **'Search Inventory'**
  String get order_searchInventory;

  /// No description provided for @order_selectInventory.
  ///
  /// In en, this message translates to:
  /// **'Select Inventory'**
  String get order_selectInventory;

  /// No description provided for @transportation_management.
  ///
  /// In en, this message translates to:
  /// **'Transportation Management'**
  String get transportation_management;

  /// No description provided for @transportation_history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get transportation_history;

  /// No description provided for @transportation_add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get transportation_add;

  /// No description provided for @transportation_addTransportation.
  ///
  /// In en, this message translates to:
  /// **'Add Transportation Management'**
  String get transportation_addTransportation;

  /// No description provided for @transportation_editTransportation.
  ///
  /// In en, this message translates to:
  /// **'Edit Transportation Management'**
  String get transportation_editTransportation;

  /// No description provided for @transportation_viewTransportation.
  ///
  /// In en, this message translates to:
  /// **'View Transportation Management'**
  String get transportation_viewTransportation;

  /// No description provided for @transportation_type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get transportation_type;

  /// No description provided for @transportation_vehicleNumber.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Number'**
  String get transportation_vehicleNumber;

  /// No description provided for @transportation_date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get transportation_date;

  /// No description provided for @transportation_price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get transportation_price;

  /// No description provided for @transportation_notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get transportation_notes;

  /// No description provided for @transportation_total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get transportation_total;

  /// No description provided for @transportation_insert.
  ///
  /// In en, this message translates to:
  /// **'Insert'**
  String get transportation_insert;

  /// No description provided for @transportation_update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get transportation_update;

  /// No description provided for @transportation_photo.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get transportation_photo;

  /// No description provided for @transaction_transactionHistory.
  ///
  /// In en, this message translates to:
  /// **'Transaction History'**
  String get transaction_transactionHistory;

  /// No description provided for @transaction_customerFilter.
  ///
  /// In en, this message translates to:
  /// **'Customer Filter'**
  String get transaction_customerFilter;

  /// No description provided for @transaction_search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get transaction_search;

  /// No description provided for @transaction_all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get transaction_all;

  /// No description provided for @transaction_sales.
  ///
  /// In en, this message translates to:
  /// **'Sales'**
  String get transaction_sales;

  /// No description provided for @transaction_order.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get transaction_order;

  /// No description provided for @transaction_adjustment.
  ///
  /// In en, this message translates to:
  /// **'Adjustment'**
  String get transaction_adjustment;

  /// No description provided for @transaction_return.
  ///
  /// In en, this message translates to:
  /// **'Return'**
  String get transaction_return;

  /// No description provided for @transaction_visited.
  ///
  /// In en, this message translates to:
  /// **'Visited'**
  String get transaction_visited;

  /// No description provided for @transaction_notVisited.
  ///
  /// In en, this message translates to:
  /// **'Not Visited'**
  String get transaction_notVisited;

  /// No description provided for @transaction_salesTransaction.
  ///
  /// In en, this message translates to:
  /// **'Sales Transaction'**
  String get transaction_salesTransaction;

  /// No description provided for @transaction_date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get transaction_date;

  /// No description provided for @transaction_warehouse.
  ///
  /// In en, this message translates to:
  /// **'Warehouse'**
  String get transaction_warehouse;

  /// No description provided for @transaction_address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get transaction_address;

  /// No description provided for @transaction_idNumber.
  ///
  /// In en, this message translates to:
  /// **'ID Number'**
  String get transaction_idNumber;

  /// No description provided for @transaction_paymentType.
  ///
  /// In en, this message translates to:
  /// **'Payment Type'**
  String get transaction_paymentType;

  /// No description provided for @transaction_salesId.
  ///
  /// In en, this message translates to:
  /// **'Sales ID'**
  String get transaction_salesId;

  /// No description provided for @transaction_customerName.
  ///
  /// In en, this message translates to:
  /// **'Customer Name'**
  String get transaction_customerName;

  /// No description provided for @transaction_area.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get transaction_area;

  /// No description provided for @transaction_phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get transaction_phoneNumber;

  /// No description provided for @transaction_remarks.
  ///
  /// In en, this message translates to:
  /// **'Remarks'**
  String get transaction_remarks;

  /// No description provided for @transaction_inventoryDetail.
  ///
  /// In en, this message translates to:
  /// **'Inventory Detail'**
  String get transaction_inventoryDetail;

  /// No description provided for @transaction_add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get transaction_add;

  /// No description provided for @transaction_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get transaction_edit;

  /// No description provided for @transaction_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get transaction_delete;

  /// No description provided for @transaction_addProduct.
  ///
  /// In en, this message translates to:
  /// **'Add Product'**
  String get transaction_addProduct;

  /// No description provided for @transaction_inventory.
  ///
  /// In en, this message translates to:
  /// **'Inventory'**
  String get transaction_inventory;

  /// No description provided for @transaction_qty.
  ///
  /// In en, this message translates to:
  /// **'Qty'**
  String get transaction_qty;

  /// No description provided for @transaction_price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get transaction_price;

  /// No description provided for @transaction_uom.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get transaction_uom;

  /// No description provided for @transaction_discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get transaction_discount;

  /// No description provided for @transaction_notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get transaction_notes;

  /// No description provided for @transaction_total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get transaction_total;

  /// No description provided for @transaction_insert.
  ///
  /// In en, this message translates to:
  /// **'Insert'**
  String get transaction_insert;

  /// No description provided for @transaction_payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get transaction_payment;

  /// No description provided for @setting_title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get setting_title;

  /// No description provided for @setting_account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get setting_account;

  /// No description provided for @setting_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get setting_language;

  /// No description provided for @setting_helpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get setting_helpSupport;

  /// No description provided for @setting_about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get setting_about;

  /// No description provided for @setting_profilePhoto.
  ///
  /// In en, this message translates to:
  /// **'Profile Photo'**
  String get setting_profilePhoto;

  /// No description provided for @setting_displayName.
  ///
  /// In en, this message translates to:
  /// **'Display Name'**
  String get setting_displayName;

  /// No description provided for @setting_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get setting_email;

  /// No description provided for @setting_address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get setting_address;

  /// No description provided for @setting_phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get setting_phoneNumber;

  /// No description provided for @setting_newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get setting_newPassword;

  /// No description provided for @setting_saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get setting_saveChanges;

  /// No description provided for @payment_quickSalesPayment.
  ///
  /// In en, this message translates to:
  /// **'Quick Sales Payment'**
  String get payment_quickSalesPayment;

  /// No description provided for @payment_totalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get payment_totalAmount;

  /// No description provided for @payment_remainingPayment.
  ///
  /// In en, this message translates to:
  /// **'Remaining Payment'**
  String get payment_remainingPayment;

  /// No description provided for @payment_returnId.
  ///
  /// In en, this message translates to:
  /// **'Return ID'**
  String get payment_returnId;

  /// No description provided for @payment_returnValue.
  ///
  /// In en, this message translates to:
  /// **'Return Value'**
  String get payment_returnValue;

  /// No description provided for @payment_paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get payment_paymentMethod;

  /// No description provided for @payment_pendingPayment.
  ///
  /// In en, this message translates to:
  /// **'Pending Payment'**
  String get payment_pendingPayment;

  /// No description provided for @payment_confirmPayment.
  ///
  /// In en, this message translates to:
  /// **'Confirm Payment'**
  String get payment_confirmPayment;

  /// No description provided for @payment_salesOrderPayment.
  ///
  /// In en, this message translates to:
  /// **'Sales Order Payment'**
  String get payment_salesOrderPayment;

  /// No description provided for @payment_returnPayment.
  ///
  /// In en, this message translates to:
  /// **'Return Payment'**
  String get payment_returnPayment;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'id': return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
