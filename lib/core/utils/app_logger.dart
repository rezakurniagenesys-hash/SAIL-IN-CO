// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';

class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 100,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
    level: kDebugMode ? Level.debug : Level.warning,
  );

  // ============================
  // BASIC LEVEL LOG
  // ============================
  static void v(
    dynamic message, {
    Object? error,
    StackTrace? stackTrace,
    DateTime? time,
  }) {
    _logger.v(_format(message, time), error: error, stackTrace: stackTrace);
  }

  static void d(
    dynamic message, {
    Object? error,
    StackTrace? stackTrace,
    DateTime? time,
  }) {
    _logger.d(_format(message, time), error: error, stackTrace: stackTrace);
  }

  static void i(
    dynamic message, {
    Object? error,
    StackTrace? stackTrace,
    DateTime? time,
  }) {
    _logger.i(_format(message, time), error: error, stackTrace: stackTrace);
  }

  static void w(
    dynamic message, {
    Object? error,
    StackTrace? stackTrace,
    DateTime? time,
  }) {
    _logger.w(_format(message, time), error: error, stackTrace: stackTrace);
  }

  static void e(
    dynamic message, {
    Object? error,
    StackTrace? stackTrace,
    DateTime? time,
  }) {
    _logger.e(_format(message, time), error: error, stackTrace: stackTrace);
  }

  // ============================
  // NETWORK HELPERS
  // ============================
  static void networkRequest(String method, Uri uri, {dynamic data}) {
    _logger.i('➡️ [REQUEST] $method $uri\n${_prettyJson(data)}');
  }

  static void networkResponse(int? statusCode, dynamic data) {
    _logger.i('✅ [RESPONSE] Status: $statusCode\n${_prettyJson(data)}');
  }

  static void networkError(DioException err) {
    _logger.e(
      '❌ [ERROR] ${err.type} - ${err.message}',
      error: err,
      stackTrace: err.stackTrace,
    );
  }

  // ============================
  // PROGRESS LOGGING
  // ============================
  static void uploadProgress(int sent, int total) {
    final percent = (sent / total * 100).toStringAsFixed(2);
    _logger.d('📤 Upload: $percent% ($sent/$total bytes)');
  }

  static void downloadProgress(int received, int total) {
    final percent = (received / total * 100).toStringAsFixed(2);
    _logger.d('📥 Download: $percent% ($received/$total bytes)');
  }

  // ============================
  // PRIVATE UTILITIES
  // ============================
  static String _format(dynamic message, DateTime? time) {
    final t = time ?? DateTime.now();
    final ts =
        '[${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}:${t.second.toString().padLeft(2, '0')}]';
    return '$ts ${_prettyJson(message)}';
  }

  static String _prettyJson(dynamic message) {
    try {
      if (message is Map || message is List) {
        return const JsonEncoder.withIndent('  ').convert(message);
      }
      return message.toString();
    } catch (_) {
      return message.toString();
    }
  }
}
