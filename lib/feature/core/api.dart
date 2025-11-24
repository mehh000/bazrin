// ignore_for_file: non_constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiAddress {
  static String HOST_AUTH = dotenv.env['HOST_AUTH'] ?? '';
  static String HOST_STORE = dotenv.env['HOST_STORE'] ?? '';
  static String HOST_CATALOG = dotenv.env['HOST_CATALOG'] ?? '';
  static String HOST_IMAGE = dotenv.env['HOST_IMAGE'] ?? '';
  static String HOST_PROFILE = dotenv.env['HOST_PROFILE'] ?? '';
  static String HOST_INVENTORY = dotenv.env['HOST_INVENTORY'] ?? '';
  static String HOST_NOTIFICATION = dotenv.env['HOST_NOTIFICATION'] ?? '';
  static String HOST_ADMIN = dotenv.env['HOST_ADMIN'] ?? '';
  static String HOST_CART = dotenv.env['HOST_CART'] ?? '';
  static String AUTHORIZATION_TOKEN_URL =
      dotenv.env['AUTHORIZATION_TOKEN_URL'] ?? '';
  static String AUTHORIZATION_CLIENT_ID =
      dotenv.env['AUTHORIZATION_CLIENT_ID'] ?? '';
  static String AUTHORIZATION_CLIENT_SECRET =
      dotenv.env['AUTHORIZATION_CLIENT_SECRET'] ?? '';
  static String AUTHORIZATION_SCOPE = dotenv.env['AUTHORIZATION_SCOPE'] ?? '';
  static String AUTH_ACCESS_TOKEN_EXPIRATION =
      dotenv.env['AUTH_ACCESS_TOKEN_EXPIRATION'] ?? '';
  static String AUTH_REFRESH_TOKEN = dotenv.env['AUTH_REFRESH_TOKEN'] ?? '';
  static String AUTH_LOGIN_URL = dotenv.env['AUTH_LOGIN_URL'] ?? '';
  static printApi(baseUrl) {
    print('API URL: $baseUrl');
  }
}
