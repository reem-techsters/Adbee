import 'package:encrypt/encrypt.dart' as encrypt_package;

class EncryptionUtils {
  static String encryptData(String data, encrypt_package.Key apiKey, String iv) {
    final ivData = encrypt_package.IV.fromUtf8(iv);
    final encrypter = encrypt_package.Encrypter(encrypt_package.AES(apiKey, mode: encrypt_package.AESMode.cbc));
    final encrypted = encrypter.encrypt(data, iv: ivData);
    return encrypted.base64;
  }

  static String decryptData(String encryptedBase64, encrypt_package.Key apiKey, String iv) {
    final ivData = encrypt_package.IV.fromUtf8(iv);
    final encrypter = encrypt_package.Encrypter(encrypt_package.AES(apiKey, mode: encrypt_package.AESMode.cbc));
    final encrypted = encrypt_package.Encrypted.fromBase64(encryptedBase64);
    final decrypted = encrypter.decrypt(encrypted, iv: ivData);
    return decrypted;
  }
}