import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sibagjaapps/models/M_DetailsTagiham.dart';
import 'package:sibagjaapps/models/M_ModelTagihanDiluar.dart';
import 'package:sibagjaapps/utils/Api_Services.dart';
import 'package:sibagjaapps/utils/classLogerInit.dart';
import 'package:sibagjaapps/utils/encryption/decryptions.dart';

class APIDetailsBilling {
  Future<List<ModelsDetailsTagihan>> FetchBilling(idTagihan) async{
   final response = await http.post(Uri.parse(API.DetailsBilling), headers: API.credentialsMap,body: {
    "idTagihan" : idTagihan
   });

    if (response.statusCode == 200) {
      var dataOpen = decrypt(jsonDecode(response.body)['response']);
      LOG.logger.t(dataOpen);
      // Ensure the decrypted data is parsed as a List
      List<dynamic> data = jsonDecode(dataOpen);
      
      List<ModelsDetailsTagihan> Users = data.map((json) => ModelsDetailsTagihan.fromJson(json)).toList();
      return Users;
    } else {
      return [];
    }
  
  }

  Future<List<ModelTagihanDiluar>> FetchBillingDiluarLayanan(idTagihan) async{
   final response = await http.post(Uri.parse(API.DetailsPaketLayananDiluar), headers: API.credentialsMap,body: {
    "idTagihan" : idTagihan
   });

    if (response.statusCode == 200) {
      var dataOpen = decrypt(jsonDecode(response.body)['response']);
      LOG.logger.t(dataOpen);
      // Ensure the decrypted data is parsed as a List
      List<dynamic> data = jsonDecode(dataOpen);
      
      List<ModelTagihanDiluar> Users = data.map((json) => ModelTagihanDiluar.fromJson(json)).toList();
      return Users;
    } else {
      return [];
    }
  
  }



  Future<int> DeletePaketLayanan(idlayanan) async{
   final response = await http.post(Uri.parse(API.DeletePaketDiluarLayanan), headers: API.credentialsMap,body: {
    "idKEY" : idlayanan
   });

print(
jsonDecode(response.body));
     return response.statusCode;
  
  }


  
}
