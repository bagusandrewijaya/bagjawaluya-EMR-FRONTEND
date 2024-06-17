
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sibagjaapps/utils/Api_Services.dart';
import 'package:sibagjaapps/utils/classLogerInit.dart';

import '../../models/M_UsersShort.dart';
import '../../utils/encryption/decryptions.dart';
class AuthLoginApiService {

  Future<List<ModelsUsersShort>> Login (String u,String p,context)async{
    
    final response = await http.post(Uri.parse(API.auth),headers: API.credentialsMap,body:  {
      "username" :u,
      "password" : p
    });
      LOG.logger.t(jsonDecode(response.body));
    if (response.statusCode == 200) {

      var dataOpen =  decrypt(jsonDecode(response.body)['response']);
      List<dynamic> data = jsonDecode(dataOpen);
      
      List<ModelsUsersShort> Users = data.map((json) => ModelsUsersShort.fromJson(json)).toList();
      return Users;
 
    }else{
      
  ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.center,
      children: [
        Text(
          "OOPS :/   ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('Periksa Kembali Username Dan Password'),
      ],
    
    ),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.symmetric(horizontal: 200, vertical: 16),
    backgroundColor: Color.fromARGB(239, 44, 41, 4),
  ),
);

   return [];
    }
 

  }
}