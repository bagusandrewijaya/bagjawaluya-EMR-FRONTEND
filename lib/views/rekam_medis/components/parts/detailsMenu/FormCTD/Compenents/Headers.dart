
import 'package:flutter/material.dart';
import 'package:sibagjaapps/utils/downloaders/Url_Launcher.dart';
import 'package:fluent_ui/fluent_ui.dart' as ft;
import '../../../../../../../utils/Api_Services.dart';

class Header extends StatelessWidget {
  final String IdForms;

  const Header( {super.key,required this.IdForms});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),

      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Image.network('https://upload.wikimedia.org/wikipedia/commons/d/de/Logo_of_the_Ministry_of_Health_of_the_Republic_of_Indonesia.png', height: 50), // Ganti dengan logo RSU Madani
              SizedBox(width: 10),
              Text(
                'YAYASAN BAGJA WALUYA',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ],
          ),
          SizedBox(height: 10),
     
          Divider(thickness: 2),
          SizedBox(height: 10),
          Text(
            'LEMBAR CATATAN DOKTER',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child:  GestureDetector(
                                            onTap: () {
                                            if(IdForms != "-" ){
                                                bukaBrowser("${API.CetakCTD}?id=$IdForms");
                                            }
                                            },
                                             child: Container(
                                              padding: EdgeInsets.all(10),
                                              color:IdForms != "-" ? Colors.green: Colors.grey,
                                              child:Icon( ft.FluentIcons.download_document,color: Colors.white,),
                                             ),
                                           ),
          )
        ],
      ),
    );
  }
}