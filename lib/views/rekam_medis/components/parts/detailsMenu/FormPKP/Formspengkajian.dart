import 'dart:convert';
import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart' as ft;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sibagjaapps/controllers/providers/P_PKP_Providers.dart';
import 'package:sibagjaapps/utils/Api_Services.dart';
import 'package:sibagjaapps/utils/downloaders/Url_Launcher.dart';
import 'package:sibagjaapps/views/components/headertitle.dart';
import 'package:page_flip/page_flip.dart';

class PengkajianPsikiater extends StatefulWidget {
  final String Norekam;
  final String IdForms;
  PengkajianPsikiater(
      {super.key, required this.Norekam, required this.IdForms});

  @override
  State<PengkajianPsikiater> createState() => _PengkajianPsikiaterState();
}

class _PengkajianPsikiaterState extends State<PengkajianPsikiater> {
  final _formKey = GlobalKey<FormState>();
  final _formKeyz = GlobalKey<FormState>();
  final _controller = GlobalKey<PageFlipWidgetState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ChangeNotifierProvider(
          create: (context) => ProviderPKP(widget.IdForms),
          child: Consumer<ProviderPKP>(builder: (context, pw, w) {
            return SingleChildScrollView(
              child: ft.Column(
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
                          Text("Kembali / "),
                          Text(
                            "${widget.IdForms}",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.9,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "YAYASAN BAGJA WALUYA",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "PENGKAJIAN KEPERAWATAN PSIKIATRI",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ft.Container(
                            margin: const EdgeInsets.all(8.0),
                            child: ft.Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ft.Container(
                                    child: GestureDetector(
                                  onTap: () {
                                    Map<String, String> dataMentalStatus = {};
                                    Map<String, String> controllersiiivalui = {};
                                    pw.controllers.forEach((key, controller) {
                                      dataMentalStatus[key] = controller.text;
                                    });
                                     pw.controllersiii.forEach((key, controller) {
                                      controllersiiivalui[key] = controller.text;
                                    });
                                    pw.tapped(widget.Norekam,
                                        jsonEncode(dataMentalStatus),jsonEncode(controllersiiivalui), context);
                                  },
                                  child: ft.Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: Colors.blueAccent),
                                      child: Text(
                                        "SIMPAN HASIL PSIKIATRI",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      )),
                                )),
                                Gap(8),
                                ft.Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (widget.IdForms != "-") {
                                          bukaBrowser(
                                              "${API.PsikiatriDocs}?id=${widget.IdForms}");
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        color: widget.IdForms != "-"
                                            ? Colors.green
                                            : Colors.grey,
                                        child: Icon(
                                          ft.FluentIcons.download_document,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Gap(8),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        color: widget.IdForms != "-"
                                            ? Colors.red
                                            : Colors.grey,
                                        child: Icon(
                                          ft.FluentIcons.delete,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(),
                        Gap(8),
                        Expanded(
                          child: SingleChildScrollView(
                            child: ft.Column(
                              children: [
                                Forms(pw),
                                Column(
                                  children: [
                                    HeaderTitleGradient(
                                      text: "II.Status Mental",
                                    ),
                                    Form(
                                      key: _formKeyz,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children:
                                              pw.controllers.keys.map((key) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 16),
                                              child: Row(
                                                children: [
                                                  Container(
                                                      width: 150,
                                                      child: Text(key == "tkd"
                                                          ? "Tekanan Darah"
                                                          : key.replaceAll(
                                                              '-', ' '))),
                                                  Expanded(
                                                    child: TextFormField(
                                                      maxLines: 3,
                                                      minLines: 1,
                                                      controller:
                                                          pw.controllers[key],
                                                      decoration: InputDecoration(
                                                          hintText: key == "tkd"
                                                              ? "Tekanan Darah"
                                                              : key.replaceAll(
                                                                  '-', ' '),
                                                          border:
                                                              UnderlineInputBorder()),
                                                    ),
                                                  ),
                                                  Gap(16)
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    HeaderTitleGradient(
                                      text: "III.Pemeriksaan Lanjutan",
                                    ),
                                    Form(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children:
                                              pw.controllersiii.keys.map((key) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 16),
                                              child: Row(
                                                children: [
                                                  Container(
                                                      width: 150,
                                                      child: Text(key == "tkd"
                                                          ? "Tekanan Darah"
                                                          : key.replaceAll(
                                                              '-', ' '))),
                                                  Expanded(
                                                    child: TextFormField(
                                                      maxLines: 3,
                                                      minLines: 1,
                                                      controller: pw
                                                          .controllersiii[key],
                                                      decoration: InputDecoration(
                                                          hintText: key == "tkd"
                                                              ? "Tekanan Darah"
                                                              : key.replaceAll(
                                                                  '-', ' '),
                                                          border:
                                                              UnderlineInputBorder()),
                                                    ),
                                                  ),
                                                  Gap(16)
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget Forms(ProviderPKP p) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Gap(8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      HeaderTitleGradient(
                        text: "Tanggal Masuk",
                      ),
                      ft.Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: const ft.Color.fromARGB(94, 0, 0, 0)),
                            borderRadius: BorderRadius.circular(8)),
                        child: ft.DatePicker(
                            selected: p.selectedYMD,
                            onChanged: (time) => p.ChangeDate(time)),
                      ),
                      HeaderTitleGradient(
                        text: "Jam Masuk",
                      ),
                      ft.Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: const ft.Color.fromARGB(94, 0, 0, 0)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ft.TimePicker(
                          selected: p.selectedTime,
                          onChanged: (time) => p.ChangeTime(time),
                          hourFormat: HourFormat.HH,
                        ),
                      ),
                      HeaderTitleGradient(
                        text: "1.Alasan Masuk Rumah Sakit",
                      ),
                      ft.Row(
                        children: [
                          Text("Klien Dibawah kye yayasan oleh"),
                          Gap(8),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: TextField(
                                controller: p.PJ,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ft.Row(
                        children: [
                          Text("Sejak"),
                          Gap(8),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: TextField(
                                controller: p.Sejak,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          Gap(8),
                          Text("Menampakan Gejala :")
                        ],
                      ),
                      Gap(8),
                      Wrap(
                        children: p.checkGejala.keys.map((key) {
                          return IntrinsicWidth(
                            child: Container(
                              width: 200,
                              child: CheckboxListTile(
                                title: Text(key),
                                value: p.checkGejala[key],
                                onChanged: (value) =>
                                    p.changedItem2(key, value),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                        ft.Row(
                          children: [
                            Text("Gaf Skor :"),
                            Gap(8),
                            Container(
                              width: 100,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.black,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: TextField(
                                    controller: p.gafskor,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                          ],
                        ),
                      HeaderTitleGradient(
                        text: "2.Faktor Preseptasi (Pencetus)",
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          controller: p.Faktor,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: "Faktor pencetus",
                            border: InputBorder.none,
                          ),
                          style: TextStyle(color: Colors.black),
                          buildCounter: (BuildContext context,
                              {int? currentLength,
                              int? maxLength,
                              bool? isFocused}) {
                            return null; // Hide the counter
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      HeaderTitleGradient(
                        text: "3.Keadaan Saat Datang",
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            ...p.checkboxValues.keys.map((key) {
                              return CheckboxListTile(
                                title: Text(key),
                                value: p.checkboxValues[key],
                                onChanged: (value) => p.changedItem(key, value),
                              );
                            }).toList(),
                            TextFormField(
                              controller: p.HalusanisasiDengar,
                              decoration: InputDecoration(
                                  labelText: 'Halusinasi dengar'),
                            ),
                            TextFormField(
                              controller: p.HalusanisasiLihat,
                              decoration: InputDecoration(
                                  labelText: 'Halusinasi lihat'),
                            ),
                            TextFormField(
                              controller: p.Waham,
                              decoration: InputDecoration(labelText: 'Waham'),
                            ),
                            TextFormField(
                              controller: p.Curiga,
                              decoration: InputDecoration(labelText: 'Curiga'),
                            ),
                            TextFormField(
                              controller: p.Lainnya,
                              decoration: InputDecoration(
                                  labelText: 'LAin-lain, jelaskan:'),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: ft.Column(
                          children: [
                            HeaderTitleGradient(
                              text: "3.Keadaan Saat Datang",
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Tekanan Darah"),
                                            TextFormField(
                                              controller: p.TD,
                                              decoration: InputDecoration(
                                                hintText: '.../... mmHg',
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Nadi"),
                                            TextFormField(
                                              controller: p.nadi,
                                              decoration: InputDecoration(
                                                hintText: '... x/menit',
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Suhu"),
                                            TextFormField(
                                              controller: p.Suhu,
                                              decoration: InputDecoration(
                                                hintText: '... °C',
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Pernafasan"),
                                            TextFormField(
                                              controller: p.Pernafasan,
                                              decoration: InputDecoration(
                                                hintText: '... x/menit',
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Text("Lain-lain, jelaskan:"),
                                  TextFormField(
                                    controller: p.LainLain,
                                    decoration: InputDecoration(
                                      hintText: '...',
                                      border: InputBorder.none,
                                    ),
                                    maxLines: 3,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
