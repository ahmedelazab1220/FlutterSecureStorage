import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttersecurestorage/Core/utils/secure_storage_keys.dart';

class SecureStorage {
  static late final FlutterSecureStorage _secureStorage;

  // Initialize the secure storage
  static void init() {
    if (Platform.isIOS) {
      _secureStorage = const FlutterSecureStorage(
        iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
      );
    } else if (Platform.isAndroid) {
      _secureStorage = const FlutterSecureStorage(
        // used to encrypt by shared preferences
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
      );
    } else {
      _secureStorage = const FlutterSecureStorage();
    }
  }

  // Retrieve the API key from secure storage
  Future<String> getApiKey() async {
    return await _secureStorage.read(key: SecureStorageKeys.apiKey.name) ?? '';
  }

  // Check if the API key exists in secure storage
  Future<bool> hasApiKey() async {
    return await _secureStorage.containsKey(key: SecureStorageKeys.apiKey.name);
  }

  // Store the API key in secure storage
  Future<void> setApiKey(String value) async {
    await _secureStorage.write(
      key: SecureStorageKeys.apiKey.name,
      value: value,
    );
  }
}
