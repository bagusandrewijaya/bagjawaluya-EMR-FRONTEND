import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sibagjaapps/utils/Api_Services.dart';
import 'package:sibagjaapps/utils/classLogerInit.dart';
import 'package:sibagjaapps/utils/encryption/decryptions.dart';

import '../../models/M_PasienModels.dart';

class FindPatientApiService {
  Future<List<ModelPasien>> FetchData(name) async{
    final response = await http.post(Uri.parse(API.GETPatientUseName), headers: API.credentialsMap,body: {
      "nama" : name
    });

    if (response.statusCode == 200) {
       var dataOpen = decrypt(jsonDecode(response.body)['response']);
      LOG.logger.t(dataOpen);
      // Ensure the decrypted data is parsed as a List
      List<dynamic> data = jsonDecode(dataOpen);
      
      
      List<ModelPasien> Users = data.map((json) => ModelPasien.fromJson(json)).toList();
      return Users;
    } else {
     return [];
    }
    
   
   
  }
}