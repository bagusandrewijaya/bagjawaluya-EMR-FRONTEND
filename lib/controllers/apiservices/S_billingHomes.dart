import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sibagjaapps/models/M_ListButton.dart';
import 'package:sibagjaapps/models/M_billingList.dart';
import 'package:sibagjaapps/models/M_detailsPatients.dart';
import 'package:sibagjaapps/utils/Api_Services.dart';
import 'package:sibagjaapps/utils/classLogerInit.dart';
import 'package:sibagjaapps/utils/encryption/decryptions.dart';

class ApiBillingHomes {
    Future<List<ButtonListKeuangan>> FetchDataButton() async{
    final response = await http.post(Uri.parse(API.GetListCard), headers: API.credentialsMap,body: {
    });
 var dataOpen = decrypt(jsonDecode(response.body)['response']);

      LOG.logger.t(dataOpen);
      List<dynamic> data = jsonDecode(dataOpen);
      List<ButtonListKeuangan> buttons = data.map((json) => ButtonListKeuangan.fromJson(json)).toList();
      return buttons;
  
}

 Future<List<MBillingList>> FetchDatarequest() async{
    final response = await http.post(Uri.parse(API.BillingGet), headers: API.credentialsMap,body: {
    });
 var dataOpen = decrypt(jsonDecode(response.body)['response']);

      LOG.logger.t(dataOpen);
      List<dynamic> data = jsonDecode(dataOpen);
      List<MBillingList> buttons = data.map((json) => MBillingList.fromJson(json)).toList();
      return buttons;
  
}
}