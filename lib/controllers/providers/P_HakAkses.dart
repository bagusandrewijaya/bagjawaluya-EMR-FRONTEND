import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String? _userLevel;

  String? get userLevel => _userLevel;

  AuthProvider() {
    _loadUserLevel();
    
  }

  Future<void> _loadUserLevel() async {
    final prefs = await SharedPreferences.getInstance();
    _userLevel = prefs.getString('level');
    prefs.clear();
    notifyListeners();
  }



  bool canAccess(String requiredLevel) {
    if (_userLevel == null) return false;
    switch (_userLevel) {
      case '1':
        return true; // Level 1 has access to everything
      case '2':
        return requiredLevel == '2' || requiredLevel == '3';
      case '3':
        return requiredLevel == '3';
      default:
        return false;
    }
  }
}
