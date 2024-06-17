import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:sibagjaapps/models/M_detailsPatients.dart';
import 'package:sibagjaapps/utils/classLogerInit.dart';
import 'package:sibagjaapps/utils/encryption/decryptions.dart';
import 'package:toastification/toastification.dart';

import '../../utils/Api_Services.dart';

class ApiDetailsPatients {
  
 Future<List<DetailsPatients>> FetchDataDetails(String rm)async{
      var response = await http.post(Uri.parse(API.GetUserForUpdate),headers:  API.credentialsMap,body: {
        "rm" : rm
      });
 var dataOpen = decrypt(jsonDecode(response.body)['response']);
      LOG.logger.t(dataOpen);
      List<dynamic> data = jsonDecode(dataOpen);
      List<DetailsPatients> patients = data.map((json) => DetailsPatients.fromJson(json)).toList();
      return patients;
  }

  PutCatatan(rm,catatan,context)async{

  var response = await http.post(Uri.parse(API.UpdateCatatanPasien),headers:  API.credentialsMap,body: {
        "rm" : rm,
        "catatan" : catatan
      });
 LOG.logger.t(jsonDecode(response.body));
      toastification.show(
          type: ToastificationType.success,
          style: ToastificationStyle.flat,
          context: context,
          title: Text('Berhasil'),
          description: Text("catatan disimpan"),
          autoCloseDuration: const Duration(seconds: 5),
        );

  }
}