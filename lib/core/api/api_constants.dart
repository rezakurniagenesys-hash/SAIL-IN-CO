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
  // Customer 
  // =======================================================
  static const String customerSearch = "/sales/api/callsheets/customer/search";
  static const String customerDetail = "/sales/api/callsheets/customer/{id}";
  static const String customerUpdatePhoto = "/sales/api/callsheets/customer/{id}/upload";

  // Dashboard
  static const String summaryChart = "/sales/api/callsheets/summary";

  // Stock
  static const String stockUrl = "/sales/api/callsheets/stock";
}
