import 'package:encrypt/encrypt.dart';
import 'package:mysacco/utils/configuration/Configuration.dart';

class Crypto {
    static String encrypt(String strClearText) {
        try {
            final key = Key.fromUtf8(Configurations.ENCRYPTION_KEY);
            final iv = IV.fromLength(16);

            Encrypted encEncrypted = Encrypter(AES(key, mode: AESMode.cbc)).encrypt(strClearText, iv: iv);
            return encEncrypted.base64;
        } catch (e, s) {
            print("ERROR ON ENCRYTPION:\n $e");
            print('STACK TRACE:\n $s');
        }
        return null;
    }

    static String decrypt(String strEncrypted) {
        try {
            final key = Key.fromUtf8(Configurations.ENCRYPTION_KEY);
            final iv = IV.fromLength(16);

            Encrypted encEncrypted = Encrypted.fromBase64(strEncrypted);

            return Encrypter(AES(key)).decrypt(encEncrypted, iv: iv).toString();
        } catch (e, s) {
            print("ERROR ON DECRYPTION:\n $e");
            print('STACK TRACE:\n $s');
        }
        return null;
    }
}