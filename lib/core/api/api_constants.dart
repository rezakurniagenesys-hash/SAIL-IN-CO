class ApiConstants {
  // =======================================================
  // BASE URL
  // =======================================================
  static const String baseUrl = "https://qc-arthasalesforceapi.salmonacc.com";
  static const String baseLocalUrl = "http://192.168.57.68:3001";

  // =======================================================
  // AUTH ENDPOINTS
  // =======================================================
  static const String loginUrl = "/auth/api/login";
  static const String verifyTokenUrl = "/auth/api/verifyToken";
  static const String refreshTokenUrl = "/auth/api/refreshToken";

  // =======================================================
  // Generals
  // =======================================================
  static const String generalInventory = "/stock/api/inventory";
  // static const String generalUOMs = "/sales/api/inventory/{id}/uoms";

  // =======================================================
  // Customer
  // =======================================================
  static const String customerSearch = "/sales/api/callsheets/customer/search";
  static const String customerSearchVisit = "/sales/api/callsheets/customer/search-visit";
  static const String customerDetail = "/sales/api/callsheets/customer/{id}";
  static const String customerUpdatePhoto = "/sales/api/callsheets/customer/{id}/upload";

  //Patty Case
  static const String pattyCash = "/sales/api/sales/pettyCashSaldo";

  // Dashboard
  static const String summaryChart = "/sales/api/callsheets/summary";

  // Stock
  static const String stockUrl = "/sales/api/callsheets/stock";

  // Payment
  static const String salesReturns = "/stock/api/sales-returns?customer_id={customerId}";
  static const String paymentMethods = "/stock/api/payment-methods?no_acc6={noAcc6}";

  static const String quickSales = "/stock/api/quick-sales";
  static const String salesOrders = "/stock/api/sales-orders";
  static const String shippings = "/stock/api/shippings";
  static const String returnPayments = "/stock/api/sales-returns";

  static const String historyTransactions = "/sales/api/callsheets/transactions";
  static const String invoicePaymentJournal = "/stock/api/invoices/payment-journal";
}
