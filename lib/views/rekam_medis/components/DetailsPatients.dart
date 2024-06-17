import 'package:fluent_ui/fluent_ui.dart' as ft;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:line_icons/line_icons.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'package:sibagjaapps/controllers/providers/P_DetailsPatientsProviders.dart';
import 'package:sibagjaapps/controllers/providers/P_FetchResumeMedis.dart';
import 'package:sibagjaapps/views/rekam_medis/components/lineGradients.dart';
import 'package:sibagjaapps/views/rekam_medis/components/parts/datatable/datatablewidget.dart';
import 'package:sibagjaapps/views/rekam_medis/components/parts/detailsMenu/cardProfile.dart';
import 'package:sibagjaapps/views/rekam_medis/components/parts/detailsMenu/lastActivity.dart';
import 'package:sibagjaapps/views/rekam_medis/components/parts/detailsMenu/resumeMedis.dart';
import 'package:sibagjaapps/views/rekam_medis/components/refresbutton.dart';

class DetailsPatient extends ft.StatefulWidget {
  final String rm;
  DetailsPatient({super.key, required this.rm});

  @override
  ft.State<DetailsPatient> createState() => _DetailsPatientState();
}

class _DetailsPatientState extends ft.State<DetailsPatient> {
  bool isopen = true;
  bool isopenright = true;
  bool isopenleft = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: ChangeNotifierProvider(
            create: (context) => ProvidersDetailsPatients(widget.rm),
            child:
                Consumer<ProvidersDetailsPatients>(builder: (context, prov, w) {
              return Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      height: 35,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            Icon(Icons.arrow_back_ios_new),
                            Text("Kembali ")
                          ],
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      height: isopen
                          ? MediaQuery.of(context).size.height * 0.4
                          : 30,
                      child: Stack(
                        children: [
                          isopen
                              ? CardTop(
                                catatan: prov.catatanPasien,
                                  data: prov.data,
                                  savings: (){
                                  prov.updatecataatan(context);
                                  },
                                )
                              : Container(),
                          Positioned(
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isopen = !isopen;
                                });
                              },
                              child: Icon(
                                isopen
                                    ? Icons.fullscreen_exit
                                    : Icons.fullscreen,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(16),
                    SizedBox(
                        height: 16,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LineGradients(),
                            Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 24,
                                ),
                                child: Center(
                                    child: Row(
                                  children: [
                                 
                                    Text(
                                      "EMR BAGJA WALUYA",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ))),
                            LineGradients(),
                          ],
                        )),
                    Gap(8),
                    Expanded(
                      flex: 3,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (isopenleft == true)
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                    height: isopenleft ? 40 : 20,
                                    child: Container(
                                      color: Colors.white,
                                      height: 40,
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isopenleft = !isopenleft;
                                            });
                                          },
                                          child: Container(
                                            width: 50,
                                            height: 40,
                                            child: Icon(
                                              isopenleft
                                                  ? Icons.fullscreen_exit
                                                  : Icons.fullscreen,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  isopenleft == true
                                      ? LastActivity()
                                      : SizedBox()
                                ],
                              ),
                            )
                          else
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isopenleft = !isopenleft;
                                });
                              },
                              child: Container(
                                color: Colors.white,
                                width: 50,
                                height: 40,
                                child: Icon(
                                  isopenleft
                                      ? Icons.fullscreen_exit
                                      : Icons.fullscreen,
                                  size: 30,
                                ),
                              ),
                            ),
                          SizedBox(
                            width: 8,
                          ),
                          if (isopenright == true)
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ChangeNotifierProvider(
                                          create: (context) =>
                                              DataTableResumeProviders(
                                                  widget.rm),
                                          child: Consumer<
                                                  DataTableResumeProviders>(
                                              builder: (context, p, w) {
                                          return Expanded(
                                            child: ft.Column(
                                              children: [
                                                Container(
                                                  color: Colors.white,
                                                  height:  isopenright ? 40 : 20,
                                                  child: Align(
                                                    alignment: Alignment.bottomRight,
                                                    child: ft.Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              isopenright = !isopenright;
                                                            });
                                                          },
                                                          child: Container(
                                                            width: 50,
                                                            height: 40,
                                                            child: Icon(
                                                              isopenright
                                                                  ? Icons.fullscreen_exit
                                                                  : Icons.fullscreen,
                                                              size: 30,
                                                            ),
                                                          ),
                                                        ),
                                                        RefreshButton( fetchData: ( ) {    p.fetchData(widget.rm); },)
                                                        
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                 isopenright == true
                                                                                  ? TableResumeMedis(
                                                data: p.data,
                                              )
                                                                                    
                                                                                  : SizedBox()
                                              ],
                                            ),
                                          );
                                        }
                                      ),
                                    )
                                 
                                ],
                              ),
                            )
                          else
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isopenright = !isopenright;
                                });
                              },
                              child: Container(
                                color: Colors.white,
                                width: 50,
                                height: 40,
                                child: Icon(
                                  isopenright
                                      ? Icons.fullscreen_exit
                                      : Icons.fullscreen,
                                  size: 30,
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
