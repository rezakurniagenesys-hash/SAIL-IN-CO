
class ApiConstants {
  // =======================================================
  // 🔗 BASE URL DAN API VERSION
  // =======================================================
  static const String baseUrl = "https://api.example.com";
  static const String apiVersion = "/v1";

  // =======================================================
  // 🔐 AUTH ENDPOINTS
  // =======================================================
  static const String login = "$apiVersion/auth/login";
  static const String register = "$apiVersion/auth/register";
  static const String logout = "$apiVersion/auth/logout";
  static const String refreshToken = "$apiVersion/auth/refresh";

  // =======================================================
  // 👤 USER ENDPOINTS
  // =======================================================
  static const String userProfile = "$apiVersion/user/profile";
  static const String updateProfile = "$apiVersion/user/update";
  static const String changePassword = "$apiVersion/user/change-password";
  static const String uploadAvatar = "$apiVersion/user/upload-avatar";

  // =======================================================
  // 🛍️ PRODUCT ENDPOINTS
  // =======================================================
  static const String productList = "$apiVersion/products";
  static String productDetail(int id) => "$apiVersion/products/$id";
  static const String productCreate = "$apiVersion/products/create";
  static String productUpdate(int id) => "$apiVersion/products/update/$id";
  static String productDelete(int id) => "$apiVersion/products/delete/$id";

  // =======================================================
  // 🧾 ORDER ENDPOINTS
  // =======================================================
  static const String orderList = "$apiVersion/orders";
  static String orderDetail(int id) => "$apiVersion/orders/$id";
  static const String createOrder = "$apiVersion/orders/create";
  static String cancelOrder(int id) => "$apiVersion/orders/cancel/$id";

  // =======================================================
  // 🖼️ FILE / UPLOAD ENDPOINTS
  // =======================================================
  static const String uploadFile = "$apiVersion/files/upload";
  static const String uploadMultiFile = "$apiVersion/files/upload-multiple";

  // =======================================================
  // 📍 GENERAL / UTILITIES
  // =======================================================
  static const String appVersionCheck = "$apiVersion/app/version";
  static const String appMaintenance = "$apiVersion/app/maintenance";
}
