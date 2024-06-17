import 'dart:convert';

import 'package:http/http.dart' as  http;
import 'package:sibagjaapps/models/M_modelsTableRekamMedis.dart';
import 'package:sibagjaapps/utils/Api_Services.dart';
import 'package:sibagjaapps/utils/classLogerInit.dart';
import 'package:sibagjaapps/utils/encryption/decryptions.dart';


class FetchAllRekamMedis {
  Future<List<MDataTableResumeMedis>> FetchDataList(String rm)async{
      var response = await http.post(Uri.parse(API.ResumeMedis),headers:  API.credentialsMap,body: {
        "rm" : rm
      });
       LOG.logger.t(rm);
 var dataOpen = decrypt(jsonDecode(response.body)['response']);
      LOG.logger.t(dataOpen);
      List<dynamic> data = jsonDecode(dataOpen);
      List<MDataTableResumeMedis> patients = data.map((json) => MDataTableResumeMedis.fromJson(json)).toList();
      return patients;
  }
}