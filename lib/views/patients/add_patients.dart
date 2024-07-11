import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:sibagjaapps/controllers/providers/P_AddPatientsProviders.dart';
import 'package:intl/intl.dart';
import 'package:sibagjaapps/views/components/headertitle.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
class AddPatients extends StatefulWidget {
  final String norekam;
  const AddPatients({super.key, required this.norekam});

  @override
  State<AddPatients> createState() => _AddPatientsState();
}

class _AddPatientsState extends State<AddPatients> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ChangeNotifierProvider(
        create: (context) => AddPatientsProviders(widget.norekam),
        child:
            Consumer<AddPatientsProviders>(builder: (context, provider, state) {
          return OverlayLoaderWithAppIcon(
            circularProgressColor: Colors.grey,
            isLoading: provider.isLoading,
            appIcon: Image.asset('assets/images/bagjawaluya.png'),
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
                        Text("Kembali /"),
                        Text(" ${widget.norekam}",
                            style: TextStyle(
                                color: const Color.fromARGB(163, 158, 158, 158)))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 75,
                                  height: 75,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: provider.avatarColor),
                                  child: Center(
                                      child: Text(
                                    provider.nama.text != ""
                                        ? provider.nama.text
                                            .substring(0, 1)
                                            .toUpperCase()
                                        : "-",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 21,
                                        color: Colors.white),
                                  )),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  provider.nama.text,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Alamat",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(provider.alamat.text),
                                      ],
                                    )),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Riwayat Medis Bawaan",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(provider.riwayatMedis.text),
                                      ],
                                    ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                            flex: 2,
                            child: SingleChildScrollView(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        HeaderTitleGradient(
                                          text: "Informasi Pasien*",
                                        ),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                              Container(
                                              width:
                                                  120, // Atur lebar sesuai kebutuhan
                                              height:
                                                  50, // Atur tinggi sesuai kebutuhan
                                              child: TextField(
                                                controller: provider.tanggalmasuk,
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                  hintText: 'Tanggal Masuk',
                                                  isDense: true, // Added this
                                                  contentPadding:
                                                      EdgeInsets.all(10),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(10.0),
                                                  ),
                                                ),
                                                onTap: () =>
                                                    provider.selectDate2(context),
                                              ),
                                            ),
                                            Gap(8),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2, // Atur lebar sesuai kebutuhan
                                              child: TextField(
                                                maxLines: 4,
                                                minLines: 1,
                                                controller: provider.suku,
                                                onChanged: (value) {
                                                  provider.notifyUpdate();
                                                },
                                                decoration: InputDecoration(
                                                  isDense: true, // Added this
                                                  contentPadding: EdgeInsets.all(8),
                              
                                                  hintText: 'Bangsa/Suku',
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(10.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Gap(8),
                                               Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2, // Atur lebar sesuai kebutuhan
                                              child: TextField(
                                                maxLines: 4,
                                                minLines: 1,
                                                controller: provider.pendidikan,
                                                onChanged: (value) {
                                                  provider.notifyUpdate();
                                                },
                                                decoration: InputDecoration(
                                                  isDense: true, // Added this
                                                  contentPadding: EdgeInsets.all(8),
                              
                                                  hintText: 'Pendidikan',
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(10.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Gap(16),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            
                                            Container(
                                              width:
                                                  300, // Atur lebar sesuai kebutuhan
                                              height:
                                                  50, // Atur tinggi sesuai kebutuhan
                                              child: TextField(
                                                controller: provider.nama,
                                                onChanged: (value) {
                                                  provider.updateAvatarColor();
                                                },
                                                decoration: InputDecoration(
                                                  hintText: 'Nama Lengkap',
                                                  isDense: true, // Added this
                                                  contentPadding: EdgeInsets.all(8),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(10.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 16,
                                            ),
                                            Container(
                                              width:
                                                  120, // Atur lebar sesuai kebutuhan
                                              height:
                                                  50, // Atur tinggi sesuai kebutuhan
                                              child: TextField(
                                                controller: provider.dateController,
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                  hintText: 'Tanggal Lahir',
                                                  isDense: true, // Added this
                                                  contentPadding:
                                                      EdgeInsets.all(10),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(10.0),
                                                  ),
                                                ),
                                                onTap: () =>
                                                    provider.selectDate(context),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 16,
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Color.fromARGB(
                                                          144, 0, 0, 0))),
                                              width:
                                                  130, // Atur lebar sesuai kebutuhan
                                              height: 35,
                                              child: DropdownButtonHideUnderline(
                                                child: DropdownButton<String>(
                                                  value: provider.selectedGender,
                                                  onChanged: (String? newValue) {
                                                    provider.changevalueGender(
                                                        newValue);
                                                  },
                                                  items: <String>[
                                                    'Laki-Laki',
                                                    'Perempuan'
                                                  ].map((String value) {
                                                    return DropdownMenuItem<String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width:
                                                  300, // Atur lebar sesuai kebutuhan
                                              // Atur tinggi sesuai kebutuhan
                                              child: TextField(
                                                maxLines: 3,
                                                minLines: 1,
                                                controller: provider.alamat,
                                                onChanged: (value) {
                                                  provider.notifyUpdate();
                                                },
                                                decoration: InputDecoration(
                                                  hintText: 'Alamat',
                                                  isDense: true, // Added this
                                                  contentPadding: EdgeInsets.all(8),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(10.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 16,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3, // Atur lebar sesuai kebutuhan
                                              // Atur tinggi sesuai kebutuhan
                                              child: TextField(
                                                maxLines: 4,
                                                minLines: 1,
                                                controller: provider.riwayatMedis,
                                                onChanged: (value) {
                                                  provider.notifyUpdate();
                                                },
                                                decoration: InputDecoration(
                                                  isDense: true, // Added this
                                                  contentPadding: EdgeInsets.all(8),
                              
                                                  hintText: 'Diagnosis',
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(10.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Gap(8),
                                        Row(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2, // Atur lebar sesuai kebutuhan
                                              child: TextField(
                                                maxLines: 4,
                                                minLines: 1,
                                                controller: provider.pekerjaan,
                                                onChanged: (value) {
                                                  provider.notifyUpdate();
                                                },
                                                decoration: InputDecoration(
                                                  isDense: true, // Added this
                                                  contentPadding: EdgeInsets.all(8),
                              
                                                  hintText: 'Pekerjaan',
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(10.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Gap(8),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2, // Atur lebar sesuai kebutuhan
                                              child: TextField(
                                                maxLines: 4,
                                                minLines: 1,
                                                controller: provider.agama,
                                                onChanged: (value) {
                                                  provider.notifyUpdate();
                                                },
                                                decoration: InputDecoration(
                                                  isDense: true, // Added this
                                                  contentPadding: EdgeInsets.all(8),
                              
                                                  hintText: 'Agama',
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(10.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        HeaderTitleGradient(
                                          text: "Informasi Keluarga*",
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width:
                                                  300, // Atur lebar sesuai kebutuhan
                                              // Atur tinggi sesuai kebutuhan
                                              child: TextField(
                                                controller: provider.namayah,
                                                decoration: InputDecoration(
                                                  isDense: true, // Added this
                                                  contentPadding: EdgeInsets.all(8),
                              
                                                  hintText: 'Nama Ayah',
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(10.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 16,
                                            ),
                                            Container(
                                              width:
                                                  300, // Atur lebar sesuai kebutuhan
                                              // Atur tinggi sesuai kebutuhan
                                              child: TextField(
                                                controller: provider.namaibu,
                                                decoration: InputDecoration(
                                                  isDense: true, // Added this
                                                  contentPadding: EdgeInsets.all(8),
                              
                                                  hintText: 'Nama Ibu',
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(10.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Gap(8),
                                           
                                           
                                          ],
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                         Row(
                                           children: [
                                             Container(
                                                  width:
                                                      300, // Atur lebar sesuai kebutuhan
                                                  // Atur tinggi sesuai kebutuhan
                                                  child: TextField(
                                                    controller: provider.ktp,
                                                    keyboardType: TextInputType.number,
                                                    decoration: InputDecoration(
                                                      isDense: true, // Added this
                                                      contentPadding: EdgeInsets.all(8),
                                             
                                                      hintText:
                                                          'No Ktp Penanggung Jawab',
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(10.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Gap(16),
                                                 Container(
                                              width:
                                                  300, // Atur lebar sesuai kebutuhan
                                              // Atur tinggi sesuai kebutuhan
                                              child: TextField(
                                                controller: provider.kontak,
                                                keyboardType: TextInputType.number,
                                                decoration: InputDecoration(
                                                  isDense: true, // Added this
                                                  contentPadding: EdgeInsets.all(8),
                              
                                                  hintText: 'Nomor Telpon',
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(10.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                           ],
                                         ),
                              
                                          Gap(16),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width:
                                                  300, // Atur lebar sesuai kebutuhan
                                              // Atur tinggi sesuai kebutuhan
                                              child: TextField(
                                                maxLines: 4,
                                                minLines: 1,
                                                controller: provider.alamatk,
                                                decoration: InputDecoration(
                                                  isDense: true, // Added this
                                                  contentPadding: EdgeInsets.all(8),
                              
                                                  hintText:
                                                      'Alamat Lengkap Penanggung Jawab',
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(10.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Gap(16),
                                            Container(
                                              width:
                                                  300, // Atur lebar sesuai kebutuhan
                                              // Atur tinggi sesuai kebutuhan
                                              child: TextField(
                                                maxLines: 4,
                                                minLines: 1,
                                                controller: provider.pekerjaank,
                                                decoration: InputDecoration(
                                                  isDense: true, // Added this
                                                  contentPadding: EdgeInsets.all(8),
                              
                                                  hintText: 'Pekerjaan',
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(10.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Gap(8),
                              Container(
                                              width:
                                                  300, // Atur lebar sesuai kebutuhan
                                              // Atur tinggi sesuai kebutuhan
                                              child: TextField(
                                                maxLines: 4,
                                                minLines: 1,
                                                controller: provider.hubungan,
                                                decoration: InputDecoration(
                                                  isDense: true, // Added this
                                                  contentPadding: EdgeInsets.all(8),
                              
                                                  hintText:
                                                      'hubungan dengan keluarga',
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(10.0),
                                                  ),
                                                ),
                                              ),
                                            ),
            
                                      SingleChildScrollView(
                                child: Column(
                                  children: provider.controllers.keys.map((key) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                        horizontal: 16.0,
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 150,
                                            child: Text(
                                              key == "tkd" ? "Tekanan Darah" : key.replaceAll('-', ' '),
                                            ),
                                          ),
                                          Expanded(
                                            child: TextFormField(
                                              maxLines: 3,
                                              minLines: 1,
                                              controller: provider.controllers[key],
                                              decoration: InputDecoration(
                                                hintText: key == "tkd"
                                                    ? "Tekanan Darah"
                                                    : key.replaceAll('-', ' '),
                                                border: UnderlineInputBorder(),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 16),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                                
                                        if (widget.norekam == '-') ...[
                                          HeaderTitleGradient(
                                            text: "Penjamin Pasien*",
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width:
                                                    300, // Atur lebar sesuai kebutuhan
                                                // Atur tinggi sesuai kebutuhan
                                                child: TextField(
                                                  keyboardType: TextInputType
                                                      .numberWithOptions(
                                                          decimal: true),
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp(
                                                            r'^\d+\.?\d{0,2}')),
                                                  ],
                                                  controller: provider.penjamin,
                                                  decoration: InputDecoration(
                                                    isDense: true, // Added this
                                                    contentPadding:
                                                        EdgeInsets.all(8),
                                                    prefixText: 'Rp ',
                                                    hintText: 'Deposit Penjamin',
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 16,
                                              ),
                                             
                                            ],
                                          ),
                                        ]
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        provider.PostPatient(context);
                                      },
                                      child: Container(
                                        width: 200,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(16),
                                          color: Colors.blue,
                                        ),
                                        padding: EdgeInsets.all(8),
                                        child: Center(
                                          child: Text(
                                            "SIMPAN",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
