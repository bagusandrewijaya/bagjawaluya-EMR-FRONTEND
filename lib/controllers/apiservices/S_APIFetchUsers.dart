import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sibagjaapps/models/M_Pengguna.dart';
import 'package:sibagjaapps/utils/Api_Services.dart';
import 'package:sibagjaapps/utils/classLogerInit.dart';
import 'package:sibagjaapps/utils/encryption/decryptions.dart';

class APIFetchPengguna {
  Future<List<M_Pengguna>> FetchDataUsers() async{
    final response = await http.post(Uri.parse(API.FetchUsers), headers: API.credentialsMap,body: {
    });
 var dataOpen = decrypt(jsonDecode(response.body)['response']);

      LOG.logger.t(dataOpen);
      List<dynamic> data = jsonDecode(dataOpen);
      List<M_Pengguna> pengguna = data.map((json) => M_Pengguna.fromJson(json)).toList();
      return pengguna;
  
}
}