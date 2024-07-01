import 'package:auto_size_text/auto_size_text.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as ft;
import 'package:gap/gap.dart';
import 'package:sibagjaapps/controllers/providers/P_detailsBilling.dart';
import 'package:sibagjaapps/views/settings/components/billingPages.dart';
class WidgetPelayananDiluar extends StatelessWidget {
  ProvidersDetailsBilling p;
  String idTagihan;
  String statusTag;
   WidgetPelayananDiluar({super.key,required this.p,required this.idTagihan,required this.statusTag});

  @override
  Widget build(BuildContext context) {
    return Expanded(
                          child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Biaya luar Pelayanan',
                                          style:
                                              TextStyle(fontWeight: FontWeight.bold)),
                                      ft.Row(
                                        children: [
                                       if(statusTag == "0")   GestureDetector(
                                            onTap: () {
                                              showModalBottomSheet(
                                                context: context,
                                                constraints: BoxConstraints(
                                                  maxWidth: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.3,
                                                ),
                                                builder: (BuildContext context) {
                                                  return Container(
                                                    padding: EdgeInsets.all(8),
                                                    color: Colors.white,
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: <Widget>[
                                                        Text("Tambah Biaya Diluar Pelayanan",style: TextStyle(
                                                          fontWeight: FontWeight.bold,fontSize: 18
                                                        ),),
                                                        Gap(8),
                                                        Container(
                                                            width:MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.3,
                                                          child: TextField(
                                                            controller: p.layanan,
                                                            keyboardType:
                                                                TextInputType.text,
                                                            onChanged: (value) {},
                                                            decoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  'Masukan Nama',
                                                              border:
                                                                  OutlineInputBorder(),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: const Color
                                                                        .fromARGB(
                                                                        126, 0, 0, 0),
                                                                    width: 1.0),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: const Color
                                                                        .fromARGB(255,
                                                                        96, 96, 96),
                                                                    width: 2.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Gap(8),
                                                        Container(
                                                           width:MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.3,
                                                          child: TextField(
                                                            controller: p.harga,
                                                            keyboardType:
                                                                TextInputType.number,
                                                            inputFormatters: [
                                                              CurrencyTextInputFormatter
                                                                  .currency(
                                                                locale: 'id',
                                                                decimalDigits: 0,
                                                                symbol: 'RP. ',
                                                              ),
                                                            ],
                                                            onChanged: (value) {},
                                                            decoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  'Masukan jumlah biaya',
                                                              border:
                                                                  OutlineInputBorder(),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: const Color
                                                                        .fromARGB(
                                                                        126, 0, 0, 0),
                                                                    width: 1.0),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: const Color
                                                                        .fromARGB(255,
                                                                        96, 96, 96),
                                                                    width: 2.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Gap(8),
                        
                                                        Align(alignment: Alignment.bottomRight,child: 
                               GestureDetector(
                              onTap: () {
                                p.ADDpaketLayanan(idTagihan,context);
                              },
                              child: Container(
                                width: 250,
                                height: 50,
                                decoration: BoxDecoration(color: Color(0xff16181E)),
                                child: Center(
                                  child: AutoSizeText(
                                    "Simpan Layanan Tambahan",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )),)
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              decoration:
                                                  BoxDecoration(color:Color(0xff16181E),),
                                              padding: EdgeInsets.all(8),
                                              child: Text("Tambah Biaya",style: TextStyle(
                                                color: Colors.white
                                              ),),
                                            ),
                                          ),
                                          Gap(8),
                                          Text('${p.tagihan.length} items'),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16),
                          
                        
                                      Expanded(
                                        child: ListView(
                                                children: p.tagihan
                                                    .map(
                                                      (item) => ListPaketCard(
                                                        nama: item.namaTagihan.toString(),
                                                        price: item.harga.toString(),
                                                        delete: () {
                                                      if(statusTag == "0") {
                                                        showDialog<String>(
                            context: context,
                            builder: (context) => ft.ContentDialog(
                              title: const ft.Text('Hapus Item?'),
                              content: const Text(
                                'Jika Kamu Menghapus item ini maka tidak dapat di pulihkan',
                              ),
                              actions: [
                                ft.Button(
                                  child: const Text('Hapus'),
                                  onPressed: () {
                                     p.DeleteLayanan(item.idKEY,context);
                           
                                    // Delete file here
                                  },
                                ),
                                ft.FilledButton(
                                  child: const Text('Batal'),
                                  onPressed: () => Navigator.pop(context, 'User canceled dialog'),
                                ),
                              ],
                            ),
                          );
                                                      }
                                                            
                                                        },
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                      ),
                                ],
                              ),
                            ),
                          ),
                        );
  }
}