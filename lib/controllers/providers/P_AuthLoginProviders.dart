import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sibagjaapps/controllers/apiservices/S_AuthLoginApiService.dart';
import 'package:sibagjaapps/models/M_UsersShort.dart';
import 'package:go_router/go_router.dart';
import 'package:sibagjaapps/utils/navigation/main_navigation.dart';
import 'package:sibagjaapps/views/login/components/initGorouter.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class AuthLoginProviders extends ChangeNotifier {
  final AuthLoginApiService _service = AuthLoginApiService();
  TextEditingController _uname = TextEditingController();
  TextEditingController _password = TextEditingController();
  List<ModelsUsersShort> _data = [];
  String level = '';
  String name = '';
  bool _loading = false;
AuthLoginProviders(){
getaname();

}
  TextEditingController get username => _uname;
  TextEditingController get password => _password;
  bool get loading => _loading;
getaname()async{
     final prefs = await SharedPreferences.getInstance();

     bool login =  prefs.getBool('isLoggedIn')!;
     if(login){
     name = prefs.getString('name')!;
     level = prefs.getString('level')!;
     notifyListeners();
}
}

getLevel() async{


}
  login( context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _loading = true;
      notifyListeners();
      _data = await _service.Login(_uname.text, _password.text, context);
      _loading = false;
      notifyListeners();
      if(_data.length > 0){
        prefs.setString('name', _data[0].username!);
          prefs.setString('level', _data[0].level!);
        prefs.setBool('isLoggedIn', true);
notifyListeners();
        G.R(context,'/home');
      }
    } catch (e) {
      // Handle errors
      print('Login failed: $e');
    }
  }

  Logout(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.clear();

    notifyListeners();
Navigator.pop(context, 'User deleted file');
   AppNavigation.router.go('/');
  }
}
