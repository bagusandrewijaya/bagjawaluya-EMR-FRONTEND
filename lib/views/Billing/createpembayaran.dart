import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sibagjaapps/controllers/providers/P_CreateManualBilling.dart';
import 'package:sibagjaapps/models/M_PasienModels.dart';
import 'package:sibagjaapps/views/Billing/billingPages.dart';
import 'package:fluent_ui/fluent_ui.dart' as ft;
import 'package:sibagjaapps/views/rekam_medis/components/parts/detailsMenu/cardProfile.dart';
import '../../controllers/providers/P_FindPatientsProviders.dart';
import '../../utils/idCurrencyFormater/currencyIdr.dart';

class CheckoutPageManual extends StatefulWidget {
  @override
  State<CheckoutPageManual> createState() => _CheckoutPageManualState();
}

class _CheckoutPageManualState extends State<CheckoutPageManual> {
  bool ismanual = false;
  String selectedname = '';
  TextEditingController _txt = TextEditingController();
  DateTime? selected;
  @override  
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CreateManualBilling(),
      child: Consumer<CreateManualBilling>(builder: (context, p, w) {
        return  ChangeNotifierProvider(
                                    create: (context) => FindPatienProvider(),
                                    child: Consumer<FindPatienProvider>(
                                        builder: (context, providerz, state) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            height: MediaQuery.of(context).size.height,
                            color: Colors.white,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  AutoSizeText(
                                    "Informasi Pasien",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                        margin: EdgeInsets.only(right: 16),
                                        width: 250,
                                        child: ft.AutoSuggestBox<ModelPasien>(
                                          placeholder: selectedname == ''
                                              ? "Cari Nama Pasien"
                                              : selectedname,
                                          items: providerz.finderName
                                              .map<
                                                  ft.AutoSuggestBoxItem<ModelPasien>>(
                                                (users) => ft.AutoSuggestBoxItem<
                                                    ModelPasien>(
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
                                            if (reason ==
                                                ft.TextChangedReason.cleared) {
                                              setState(() {});
                                            }

                                             providerz.fetchByName(text);
                                          },
                                          clearButtonEnabled: true,
                                          onSelected: (item) {
                                            print(item.value!.noRMFK);
                                                     providerz.FetchForHeader(item.value!.noRMFK);
                                            setState(() {});
                                          },
                                        ),),
                                      
                               Gap(8),
                                 if(providerz.detailpatients.isNotEmpty) CardTop(
                                    showed: false,
                                    data: providerz.detailpatients,
                                    catatan: TextEditingController(),
                                    savings: () {},
                                    statuschange: () {},
                                  ),
                                 
                                  Gap(32),
                                  AutoSizeText(
                                    "Detail Pembayaran",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Gap(16),
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1,
                                          color: Color.fromARGB(123, 0, 0, 0)),
                                    ),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            AutoSizeText(
                                              "Total Biaya Bulanan",
                                              style:
                                                  TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            Gap(16),
                                            Container(
                                              width: 250,
                                              child: TextField(
                                                controller: p.totalBulanan,
                                                keyboardType: TextInputType.number,
                                                inputFormatters: [
                                                  CurrencyTextInputFormatter.currency(
                                                    locale: 'id',
                                                    decimalDigits: 0,
                                                    symbol: 'RP. ',
                                                  ),
                                                ],
                                                onChanged: (value) {
                                                  p.notifyUpdate();
                                                },
                                                decoration: InputDecoration(
                                                  hintText: 'Masukan Jumlah',
                                                  border: OutlineInputBorder(),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: const Color.fromARGB(
                                                            126, 0, 0, 0),
                                                        width: 1.0),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: const Color.fromARGB(
                                                            255, 96, 96, 96),
                                                        width: 2.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                           
                                          ],
                                        ),
Gap(8),
                                        Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText("Tanggal Tagihan ", style:
                                                  TextStyle(fontWeight: FontWeight.bold),),
                      Gap(16),
                      ft.Container(
                        height: 56,
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
                                      ],
                                    ),
                                  ),
                                 
                               
                                ],
                              ),
                            ),
                          )),
                      Gap(8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        "Order views",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      Divider(),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          AutoSizeText(
                                            "Biaya Bulanan",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          AutoSizeText(
                                            toIDRCurrency(p.totalBulanan.text),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Gap(8),
                                     
                                    ],
                                  ),
                                ),
                              ),
                            )),
                            GestureDetector(
                              onTap: () async{
                        String i = await p.pushData(providerz.detailpatients[0].noRM,p.totalBulanan.text,selected.toString(),context);
                            if(i.isNotEmpty){
                        // ignore: use_build_context_synchronously
                        context.pushReplacementNamed('checkout', pathParameters: {"idtagihan": i});
                            }
                                 },
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(color: Color(0xff16181E)),
                                child: Center(
                                  child: AutoSizeText(
                                    "Simpan dan lanjutkan",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(child: Container())
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          ),
        );
      }),
    );
  }
}
