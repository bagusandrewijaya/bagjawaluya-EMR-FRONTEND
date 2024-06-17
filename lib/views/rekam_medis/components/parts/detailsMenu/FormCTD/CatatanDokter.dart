import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:fluent_ui/fluent_ui.dart' as ft;
import 'package:provider/provider.dart';
import 'package:sibagjaapps/controllers/providers/P_CatatanDokter.dart';
import 'package:sibagjaapps/models/M_TableCtd.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:sibagjaapps/utils/classLogerInit.dart';

import 'Compenents/CustomForms.dart';
import 'Compenents/EMRHead.dart';
import 'Compenents/EMR_table.dart';
import 'Compenents/Headers.dart';

class CatatanDokter extends StatefulWidget {
  final String rm;
  final String name;
  final String idforms;
  final String date;
  const CatatanDokter(
      {super.key, required this.rm, required this.name, required this.idforms, required this.date});

  @override
  State<CatatanDokter> createState() => _CatatanDokterState();
}

class _CatatanDokterState extends State<CatatanDokter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ChangeNotifierProvider(
        create: (context) => CatatanDokterNotifier(widget.idforms),
        child: Consumer<CatatanDokterNotifier>(builder: (context, p, w) {
          return SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(16),
              child: GestureDetector(
                onTap: () {},
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back_ios_new),
                          Text("Kembali / "),
                            Text("${widget.idforms}",style: TextStyle(color: Colors.grey),)
                        ],
                      ),
                    ),
                    Gap(8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.width * 0.5,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                Header(IdForms: widget.idforms,),
                                MedicalRecordTableHead(
                                  name: widget.name,
                                  rm: widget.rm,
                                  Date: widget.date,
                                ),
                                MedicalRecordTable(
                                  onRemove: (p0) {
                                    p.removeTableRow(p0,context);
                                  },
                                  tableRowsMap: p.tableRowsMap,
                                ),
                                
                              ],
                            ),
                          ),
                        ),
                        Gap(8),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    children: [
                                      MyCustomForm(
                                        onFieldsaveTap: () {
                            
                                        },
                                        onFieldTap: (data) {
                                          print(data);
                                          p.addTableRow(
                                            data['tanggal']!,
                                            data['pesan']!,
                                            data['obat']!,
                                            widget.rm,
                                            context
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Gap(8),
                              Text(
                                "Jangan Lupa Untuk Melakukan Simpan Pada Saat Selesai Menambah Catatan",
                                textAlign: TextAlign.center,
                                style:
                                    TextStyle(fontSize: 16, color: Colors.red),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
