import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as ft;
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:sibagjaapps/controllers/providers/P_FindPatientsProviders.dart';
import 'package:sibagjaapps/utils/Api_Services.dart';
import 'package:sibagjaapps/utils/downloaders/Url_Launcher.dart';

import '../../../../models/M_PasienModels.dart';

class ModalRekapanPayment extends StatefulWidget {
  const ModalRekapanPayment({
    super.key,
  });

  @override
  State<ModalRekapanPayment> createState() => _ModalRekapTahunanState();
}

class _ModalRekapTahunanState extends State<ModalRekapanPayment> {
  DateTime? selected;
  DateTime? selected2;

  String? selectedType;
  String selectedname = '';
  String SelectedRM ='';
  @override
  void initState() {
  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: EdgeInsets.all(8),
      color: Color.fromARGB(222, 242, 242, 242),
      child: ft.Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ft.Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText("Dari Tanggal :"),
                      Gap(8),
                      ft.Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: ft.Color.fromARGB(255, 46, 133, 255)),
                            borderRadius: BorderRadius.circular(4)),
                        child: ft.DatePicker(
                          showDay: false,
                          selected: selected,
                          onChanged: (time) => setState(() => selected = time),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText("Sampai :"),
                      Gap(8),
                      ft.Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: ft.Color.fromARGB(255, 46, 133, 255)),
                            borderRadius: BorderRadius.circular(4)),
                        child: ft.DatePicker(
                          showDay: false,
                          selected: selected2,
                          onChanged: (time) => setState(() => selected2 = time),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Gap(8),
            
              Row(
                children: [
              
                  Gap(8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                       Text(
                "Nama Pasien",
              ),
                 Gap(4),
                      ChangeNotifierProvider(
                        create: (context) => FindPatienProvider(),
                        child: Consumer<FindPatienProvider>(
                          
                            builder: (context, provider, state) {
                          return Container(
                            margin: EdgeInsets.only(right: 16),
                            width: 250,
                            child: ft.AutoSuggestBox<ModelPasien>(
                              placeholder: selectedname == ''
                                  ? "Cari Nama Pasien"
                                  : selectedname,
                              items: provider.finderName
                                  .map<ft.AutoSuggestBoxItem<ModelPasien>>(
                                    (users) => ft.AutoSuggestBoxItem<ModelPasien>(
                                      value: users,
                                      label: users.namaPasien!,
                                      onFocusChange: (focused) {
                                        if (focused) {}
                                      },
                                    ),
                                  )
                                  .toList(),
                              onOverlayVisibilityChanged: (value) {
                          print("object");
                              },
                              onChanged: (text, reason) {
                                print(text);
                                if(reason == ft.TextChangedReason.cleared){

                                  setState(() {
                                    selectedname = '';
                                    SelectedRM = '';
                                  });
                                };
                                provider.fetchByName(text);
                              },
                            clearButtonEnabled: true,
                          
                              onSelected: (item) {
                                print(item.value!.noRMFK);
                      
                                setState(() {
                                  selectedname = item.value!.namaPasien!;
                                  SelectedRM = item.value!.noRMFK!;
                                });
                              },
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () {
                 // Memformat tanggal ke format yang diinginkan (YYYY-MM)
    String? formattedStartDate = selected?.toString().substring(0, 7);
    String? formattedEndDate = selected2?.toString().substring(0, 7);



    // Membuat query string untuk URL
    String queryString = '';
    if (formattedStartDate != null) {
      queryString += 'tanggalAwal=$formattedStartDate';
    }
    if (formattedEndDate != null) {
      queryString += queryString.isNotEmpty ? '&' : '';
      queryString += 'tanggalAkhir=$formattedEndDate';
    }

    if (SelectedRM.isNotEmpty) {
      queryString += queryString.isNotEmpty ? '&' : '';
      queryString += 'NoRM=$SelectedRM'; // Asumsikan selectedname adalah NoRM
    }

    // Membuat URL lengkap
    String url = '${API.TableLaporanPayments}?$queryString';

    // Memanggil fungsi untuk membuka browser
    bukaBrowser(url);
  
              },
              child: Container(
                width: 250,
                height: 50,
                decoration: BoxDecoration(color: Color(0xff16181E)),
                child: Center(
                  child: Text(
                    "LIHAT",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
