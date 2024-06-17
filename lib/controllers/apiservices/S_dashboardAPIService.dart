import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sibagjaapps/models/M_chartModels.dart';
import 'package:sibagjaapps/utils/Api_Services.dart';
import 'package:sibagjaapps/utils/classLogerInit.dart';
import 'package:sibagjaapps/utils/encryption/decryptions.dart';

class DashboardAPIService {
  Future<List<ChartModel>> FetchData() async {
    final response = await http.post(Uri.parse(API.ChartDataJumlah), headers: API.credentialsMap);

    if (response.statusCode == 200) {
      var dataOpen = decrypt(jsonDecode(response.body)['response']);
      LOG.logger.t(dataOpen);
      // Ensure the decrypted data is parsed as a List
      List<dynamic> data = jsonDecode(dataOpen);
      
      List<ChartModel> Users = data.map((json) => ChartModel.fromJson(json)).toList();
      return Users;
    } else {
      return [];
    }
  } 
}