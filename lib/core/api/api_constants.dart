class ApiConstants {
  // =======================================================
  // 🔗 BASE URL DAN API VERSION
  // =======================================================
  static const String baseUrl = "https://qc-arthasalesforceapi.salmonacc.com";
  static const String baseLocalUrl = "http://192.168.57.68:3001";

  // =======================================================
  // 🔐 AUTH ENDPOINTS
  // =======================================================
  static const String loginUrl = "/auth/api/login";
  static const String verifyTokenUrl = "/auth/api/verifyToken";
  static const String refreshTokenUrl = "/auth/api/refreshToken";

  // =======================================================
  // Customer Management
  // =======================================================
  static const String customerSearch = "/api/callsheets/customer/search";
}
