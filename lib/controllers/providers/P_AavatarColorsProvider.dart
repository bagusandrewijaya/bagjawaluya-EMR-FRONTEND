

import 'dart:math';

import 'package:flutter/material.dart';

class AvatarColorsProviders extends ChangeNotifier {
  Color _avatarColor = Colors.transparent;
  AvatarColorsProviders(name){
    updateAvatarColor(name);
  }
  Color get avatarColor => _avatarColor;

  void updateAvatarColor(String firstName) {
    // Ambil nama dari controller

    // Ubah nama depan menjadi kode ASCII
    int hashCode = firstName.runes.fold(0, (prev, code) => prev + code);
    // Gunakan kode ASCII untuk menentukan komponen warna (RGB)
    Random random = Random(hashCode);
    int red = random.nextInt(256);
    int green = random.nextInt(256);
    int blue = random.nextInt(256);
    // Tetapkan warna yang dihasilkan ke _avatarColor
    _avatarColor = Color.fromARGB(255, red, green, blue);
    notifyListeners();
  }
}