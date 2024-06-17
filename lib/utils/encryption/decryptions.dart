import 'dart:convert';
import 'package:encrypt/encrypt.dart' as enc;


final iv = enc.IV.fromUtf8('SMbaikQ9RsHGixTV');
 decrypt(String text) {
  try {
    List<String> parts = text.split('.');
    String decodedKey64 = utf8.decode(base64.decode(parts[0]));
    String decodedKey = utf8.decode(base64.decode(decodedKey64));
    String ciphertext = utf8.decode(base64.decode(parts[1]));
    final encrypter = enc.Encrypter(enc.AES(enc.Key.fromUtf8(decodedKey), mode: enc.AESMode.cbc));
    final decrypted = encrypter.decrypt(enc.Encrypted.fromBase64(ciphertext), iv: iv);
    return decrypted;
  } catch (e) {
    return 'DCR#FAILED';
  }
}
