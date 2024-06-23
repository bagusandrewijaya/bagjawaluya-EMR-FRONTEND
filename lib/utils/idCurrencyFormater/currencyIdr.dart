import 'package:intl/intl.dart';

String toIDRCurrency(String value) {
  if (value.isEmpty) return "Rp 0";
  if (value.trim().toLowerCase().startsWith('rp')) {
    // Jika sudah ada "Rp", kembalikan nilai aslinya
    return value.trim();
  }
  // Jika tidak ada "Rp", konversi ke format IDR
  final valueInt = int.parse(value.replaceAll(RegExp(r'[^\d]'), ''));
  final formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );
  return formatter.format(valueInt);
}