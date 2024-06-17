import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sibagjaapps/utils/Api_Services.dart';
import 'package:sibagjaapps/utils/classLogerInit.dart';
import 'package:sibagjaapps/utils/encryption/decryptions.dart';
import 'package:toastification/toastification.dart';
class APICTDService {
 Future<String> PostCTD(rm,jk,catatan,context) async{

    final response = await http.post(Uri.parse(API.InsertCtd),headers: API.credentialsMap,body: {
      "RM" :rm ,
      "PJ" : jk,
      "catatan" : catatan,

    });
      LOG.logger.t(response.body);
    if (response.statusCode == 201) {
      toastification.show(
        type: ToastificationType.success,
        style: ToastificationStyle.flat,
  context: context, // optional if you use ToastificationWrapper
  title: Text('pasien berhasil di tambah!'),
  autoCloseDuration: const Duration(seconds: 5),

);
  return  jsonDecode(response.body)['metadata']['message'];
    }else{
        LOG.logger.t(jsonDecode(response.body));
        toastification.show(
        type: ToastificationType.error,
        style: ToastificationStyle.flat,
  context: context, // optional if you use ToastificationWrapper
  title: Text('gagal menambah!'),
  autoCloseDuration: const Duration(seconds: 5),
);
return '';
    }
  }

  Future<String> putCTD(id,jk,catatan,context) async{

    final response = await http.post(Uri.parse(API.UpdateCtd),headers: API.credentialsMap,body: {
      "id" :id ,
      "PJ" : jk,
      "catatan" : catatan,

    });
      LOG.logger.t(response.body);
    if (response.statusCode == 200) {
      toastification.show(
        type: ToastificationType.success,
        style: ToastificationStyle.flat,
  context: context, // optional if you use ToastificationWrapper
  title: Text('pasien berhasil di update!'),
  autoCloseDuration: const Duration(seconds: 5),

);
  return  jsonDecode(response.body)['metadata']['message'];
    }else{
        LOG.logger.t(jsonDecode(response.body));
        toastification.show(
        type: ToastificationType.error,
        style: ToastificationStyle.flat,
  context: context, // optional if you use ToastificationWrapper
  title: Text('gagal menambah!'),
  autoCloseDuration: const Duration(seconds: 5),
);
return '';
    }
  }



Future<List<Map<String, dynamic>>> getCatatanByID(String rm) async {
  var response = await http.post(
    Uri.parse(API.GetCtdById),
    headers: API.credentialsMap,
    body: {
      "id": rm
    }
  );

  var dataOpen = decrypt(jsonDecode(response.body)['response']);
  List<dynamic> data = jsonDecode(dataOpen);
  List<dynamic> catatanList = jsonDecode(data[0]['catatan']);
  LOG.logger.t(catatanList);

  List<Map<String, dynamic>> catatan = catatanList.map((json) => Map<String, dynamic>.from(json)).toList();

  return catatan;
}

}


