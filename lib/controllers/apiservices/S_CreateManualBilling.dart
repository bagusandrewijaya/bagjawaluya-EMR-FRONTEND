import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sibagjaapps/utils/Api_Services.dart';
import 'package:toastification/toastification.dart';



class APICreateManualBilling {
  
  Future<String> CreatePayment({
required String RM,
required String biayaBulanan,
required String tanggal,


  })async{
    final response = await http.post(Uri.parse(API.CreateManualBilling),headers: API.credentialsMap,body: {
      "rm" :RM ,
      "tagihanBulanan" : biayaBulanan,
      "tagihanObat" : '0',
      "biayaDiluarLayanan" :  '0',
      "tanggal" : tanggal
    });
  print( jsonDecode(response.body)['metadata']['message']);

    return jsonDecode(response.body)['metadata']['message'];
  }
}