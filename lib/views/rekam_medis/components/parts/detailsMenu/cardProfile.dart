
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fluent_ui/fluent_ui.dart' as ft;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sibagjaapps/models/M_PasienModels.dart';
import 'package:sibagjaapps/models/M_detailsPatients.dart';
import 'package:sibagjaapps/utils/Api_Services.dart';
import 'package:sibagjaapps/utils/downloaders/Url_Launcher.dart';
import 'package:sibagjaapps/views/rekam_medis/components/parts/detailsMenu/dropdownParts.dart';

class CardTop extends StatefulWidget {
  List<DetailsPatients> data;
  TextEditingController catatan;
  bool? showed ;
 final void Function() savings;
  final void Function() statuschange;
   CardTop({
    super.key,
    required this.data,
    required this.catatan,
    required this.savings,
    required this.showed,
    required this.statuschange
  });



  @override
  State<CardTop> createState() => _CardTopState();
}

class _CardTopState extends State<CardTop> {

  bool issame = true;
  @override
  Widget build(BuildContext context) {
    return Container(
  
      width: double.infinity,
        decoration: BoxDecoration(
           
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(19, 0, 0, 0),
              blurRadius: 10,
              spreadRadius: 0.1,
              offset: Offset(0, 5),
            ),
          ],
        ),
      
        child: widget.data.length > 0 ? Row(
          children: [
            Expanded(
                flex: 2,
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                         ClipRRect(

          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              height: 120,
              width: 130,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
              
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
              child: Image.asset(widget.data[0].jenisKelamin == "P"? "assets/icons/fmle.png" :  "assets/icons/mle.png"),
            ),
          ),
        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text("${widget.data[0].namaPasien}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),),
                                            Gap(8),
                                            GestureDetector(
                                              onTap: () {
                                                showDialog<String>(
                                                  context: context,
                                                  builder: (context) => AlertDialog(
                                                    title: Text('Ubah Status Pasien'),
                                                    content: Text('apakah anda yakin akan mengubah status pasiene menjadi ${widget.data[0].status.toString() != "1" ?"Active" :"Unactive"}'),
                                                    actions: <Widget>[
                                                        TextButton(
                                                        onPressed: () {
                                                          // Add your action here
                                                    
                                                          Navigator.pop(context);
                                                        },
                                                        child: Text('tutup'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          // Add your action here
                                                         
                                                         widget.statuschange();
                                                          Navigator.pop(context);
                                                        },
                                                        child: Text('Ubah'),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  color: widget.data[0].status.toString() == "1" ? const Color.fromARGB(255, 10, 133, 73): Colors.red,
                                                  borderRadius: BorderRadius.circular(16)
                                                ),
                                                child: Text( widget.data[0].status.toString() == "1" ?"Active" :"Unactive", style: TextStyle(
                                                  color: Colors.white, fontSize: 12
                                                ),),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("${widget.data[0].umurSekarang}", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.redAccent),),
                                            Gap(4),
                                            Text(", ${widget.data[0].jenisKelamin!.toUpperCase() == 'P' ? "Perempuan" : "Laki-Laki"}", style: TextStyle(fontWeight: FontWeight.bold),),
                                          ],
                                        )
                                      ],
                                    ),
                                    
                                  if(widget.showed == true)  Row(
                                      children: [
                                          Center(
            child: Container(
              width: 200,
              height: 40,
              decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color(0xff92C7CF),
                                      
                                      ),
              child: CustDropDown(
                items:  [
                  CustDropdownMenuItem(
                    value: 0,
                    child: Text("Pengkajian Psikiater",style: TextStyle(
                      color: Colors.black,fontWeight: FontWeight.bold
                    ),),
                  ),
                  CustDropdownMenuItem(
                    value: 1,
                    child: Text("Catatan Dokter",style: TextStyle(
                      color: Colors.black,fontWeight: FontWeight.bold
                    ),),
                  )
                ],
                hintText: "Tambah Resume Medis",
              
                borderRadius: 5,
                onChanged: (val) {
                  if (val == 0) {
                    context.pushNamed('pengkajianPsikiater',pathParameters : {"data" : widget.data[0].noRM!,"idrequest" : '-'});
                  }else if (val == 1){
               final currentDate = DateTime.now();
               final formattedDate = '${currentDate.year}-${currentDate.month}-${currentDate.day}';
               context.pushNamed('CatatanDokkter',pathParameters : {"data" : widget.data[0].noRM!,"idrequest" : '-',"name" : widget.data[0].namaPasien!,"date" : formattedDate});
                  }
                },
              ),
            ),
          ),
                                         
                                    Gap(8),
                                        GestureDetector(
                                          onTap: () {
                                           context.pushNamed("editUsers",pathParameters: {"norekam" :widget.data[0].noRM!});
                                          },
                                          child: Container(
                                            height: 45,
                                            width: 45,
                                            decoration: BoxDecoration(
                                              color: Colors.blueAccent,
                                              shape: BoxShape.circle
                                            ),
                                            child: Center(
                                              child: Icon(LineIcons.pen, color: Colors.white,),
                                            ),
                                          ),
                                        ),
                                        Gap(8),
                                               GestureDetector(
                                          onTap: () {

                                            bukaBrowser('${API.CetakInfo}${widget.data[0].noRM}');
                                             },
                                          child: Container(
                                            height: 45,
                                            width: 45,
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              shape: BoxShape.circle
                                            ),
                                            child: Center(
                                              child: Icon(LineIcons.download, color: Colors.white,),
                                            ),
                                          ),
                                        ),

    
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 4),
                                height: 1.5,
                                width: double.infinity,
                                color: const Color.fromARGB(195, 158, 158, 158),
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("Norekam Medis", style: TextStyle(
                                          color: Colors.grey
                                        ),),
                                        Text("${widget.data[0].noRM}", style: TextStyle(
                                          color: Colors.redAccent, fontSize: 18
                                        ),)
                                      ],
                                    ),
                                    Gap(16),
                                  
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 16),
                      height: 1.5,
                      width: double.infinity,
                      color: const Color.fromARGB(195, 158, 158, 158),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                            children: [
                             Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                     Text("Informasi Pasien", style: TextStyle(
                                                  color: Colors.black, fontWeight: FontWeight.bold
                                                ),),
                                                Gap(8),
                                    Row(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                         Column(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                           children: [
                                             Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text("Tanggal Lahir", style: TextStyle(
                                                    color: Colors.grey
                                                  ),),
                                                  Container(
                                                  
                                                    child: AutoSizeText("${widget.data[0].tanggalLahir}", style: TextStyle(
                                                      color: Colors.black, fontWeight: FontWeight.bold
                                                    ),),
                                                  )
                                                ],
                                              ),
                                          
                                           ],
                                         ),
                                          Gap(21),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text("Alamat", style: TextStyle(
                                                color: Colors.grey
                                              ),),
                                              Container(
                                               width: 250,
                                                child: AutoSizeText("${widget.data[0].alamat}", style: TextStyle(
                                                  color: Colors.black, fontWeight: FontWeight.bold
                                                ),),
                                              )
                                            ],
                                          )
                                      ],
                                    ),
                                  ],
                                ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                     Text("Informasi Keluarga Pasien", style: TextStyle(
                                                  color: Colors.black, fontWeight: FontWeight.bold
                                                ),),
                                                Gap(8),
                                    Row(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                         Column(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                           children: [
                                           
                                               Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text("Kontak", style: TextStyle(
                                                color: Colors.grey
                                              ),),
                                              Container(
                                              
                                                child: AutoSizeText("${widget.data[0].kontak}", style: TextStyle(
                                                  color: Colors.black, fontWeight: FontWeight.bold
                                                ),),
                                              )
                                            ],
                                          ),
                                           ],
                                         ),
                                          Gap(21),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text("Alamat", style: TextStyle(
                                                  color: Colors.grey
                                                ),),
                                                Container(
                                                                                   
                                                  child: AutoSizeText("${widget.data[0].alamatKeluarga}", style: 
                                                  TextStyle(
                                                    color: Colors.black,fontWeight: FontWeight.bold
                                                  ),),
                                                )
                                              ],
                                            ),
                                          )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          
                      ),
                    )
                  ],
                ),
              )
            ),
         if(widget.showed == true)   Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                color: Color(0xff7286D3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                  
                    Gap(8),
                     Expanded(
                      
                       child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Catatan Pasien :",style: TextStyle(
                                      color: Colors.white,
                                    ),),
                              Gap(8),
                                  if(!issame)  GestureDetector(
                                    onTap:    widget.savings,
                                    child: Icon(ft.FluentIcons.save_as,color: const Color.fromARGB(95, 255, 255, 255),)),
                            ],
                          ),
                           Expanded(
                             child: Container(
                               padding: EdgeInsets.all(8),
                               decoration: BoxDecoration(
                              
                                 borderRadius: BorderRadius.circular(8),
                               
                               ),
                               child: TextField(
                                controller: widget.catatan,
                                 maxLines: 10,
                                 decoration: InputDecoration(
                                  hintText: "masukan catatan pengingat disini",
                                   border: InputBorder.none,
                               
                                 ),
                                 style: TextStyle(color: Colors.white),
                                 buildCounter: (BuildContext context, {int? currentLength, int? maxLength, bool? isFocused}) {
                                   return null; // Hide the counter
                                 },
                                 onChanged: (value) {
                                 
                                   if (value != widget.catatan) {
                                    setState(() {
                                       issame = false;
                                    });
                                   }else{
                                    setState(() {
                                        issame = true;
                                    });
                                   }
                                 },
                               ),
                             ),
                           ),
                         ],
                       ),
                     )
          ]),
              )
            )
          ],
        ) : Center(child: CircularProgressIndicator()),
      );
  }
}

class InformasiSaldo extends StatelessWidget {
  const InformasiSaldo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
    Container(
                      width:200,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        
                        color: Color.fromARGB(192, 39, 48, 87)
                      ),
                      child: Row(
                        children: [
                          Icon(LineIcons.wallet,color: Colors.white,size: 32,),
                          Gap(8),
                          Text("Saldo Pasien",style: TextStyle(
                            fontWeight: FontWeight.normal,fontSize: 21,color: Colors.white
                          ),),
                        ],
                      ),
                    ),
                    Gap(8),
                    Container(
            
                      padding: EdgeInsets.all(4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            
                          Container(
                            padding: EdgeInsets.all(8),
                              margin: EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            color: Color.fromARGB(192, 39, 48, 87)
                                        ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("Saldo",style: TextStyle(
                                      color: Colors.white,fontSize: 21
                                    ),),
                                   AutoSizeText("Rp.11243,.323",style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    minFontSize: 17,
                                    maxFontSize: 21,
                                    ),
                                  ],
                                )
                            ),
                          Container(
                                 padding: EdgeInsets.all(8),
                                  margin: EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            color: Color.fromARGB(192, 39, 48, 87)
                                        ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("Penjamin",style: TextStyle(
                                    color: Colors.white,fontSize: 21
                                  ),),
                                 AutoSizeText("Rp.11243,.323",style: TextStyle(
                                    color: Colors.white,
                                  ),
                                   minFontSize: 17,
                                  maxFontSize: 21,
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: const Color.fromARGB(90, 255, 255, 255),
                    ),
      ],
    );
  }
}
