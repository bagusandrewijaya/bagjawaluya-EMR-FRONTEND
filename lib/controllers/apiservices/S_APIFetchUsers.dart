import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sibagjaapps/models/M_Pengguna.dart';
import 'package:sibagjaapps/utils/Api_Services.dart';
import 'package:sibagjaapps/utils/classLogerInit.dart';
import 'package:sibagjaapps/utils/encryption/decryptions.dart';

class APIPengguna {
  Future<List<M_Pengguna>> FetchDataUsers() async{
    final response = await http.post(Uri.parse(API.FetchUsers), headers: API.credentialsMap,body: {
    });
 var dataOpen = decrypt(jsonDecode(response.body)['response']);

      LOG.logger.t(dataOpen);
      List<dynamic> data = jsonDecode(dataOpen);
      List<M_Pengguna> pengguna = data.map((json) => M_Pengguna.fromJson(json)).toList();
      return pengguna;
  
}


  Future<int> createUser({
    required String username,
    required String password,
    required String level,
    required String nama,
    required String notlpn,
    required String alamat,
  }) async {
    final response = await http.post(
      Uri.parse(API.CreateUsers),
      headers: API.credentialsMap,
      body:{
     'username': username,
        'password': password,
        'level': level,
        'nama': nama,
        'notlpn': notlpn,
        'alamat': alamat
    
      }
    );


    print(jsonDecode(response.body));
    return jsonDecode(response.body)['metadata']['code'];
  }

  Future<List<M_Pengguna>> FetchDataUsersbyid({required String idusers}) async{
    final response = await http.post(Uri.parse(API.FetchUsersByid), headers: API.credentialsMap,body: {
      "idusers" : idusers
    });
 var dataOpen = decrypt(jsonDecode(response.body)['response']);

      LOG.logger.t(dataOpen);
      List<dynamic> data = jsonDecode(dataOpen);
      List<M_Pengguna> pengguna = data.map((json) => M_Pengguna.fromJson(json)).toList();
      return pengguna;
  
}

 Future<int> updatePassword({
    required String idusers,
    required String newPassword,
  }) async {
    final response = await http.post(
      Uri.parse(API.updatePassword), // Assume you have this endpoint defined
      headers: API.credentialsMap,
      body: {
        'idusers': idusers,
        'pass': newPassword,
      },
    );

    var responseBody = jsonDecode(response.body);
    return responseBody['metadata']['code'];
  }
  Future<int> Updatestatus({
    required String idusers,
    required String status,
  }) async {
    final response = await http.post(
      Uri.parse(API.updatestatusPengguna), // Assume you have this endpoint defined
      headers: API.credentialsMap,
      body: {
        'idusers': idusers,
        'status': status,
      },
    );
print(jsonDecode(response.body));
    var responseBody = jsonDecode(response.body);
    return responseBody['metadata']['code'];
  }

}