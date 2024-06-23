import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:sibagjaapps/controllers/providers/P_CreateManualBilling.dart';
import 'package:sibagjaapps/views/settings/components/Checkoutpages.dart';

import '../../../utils/idCurrencyFormater/currencyIdr.dart';

class CheckoutPageManual extends StatefulWidget {
  @override
  State<CheckoutPageManual> createState() => _CheckoutPageManualState();
}

class _CheckoutPageManualState extends State<CheckoutPageManual> {
  bool ismanual = false;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CreateManualBilling(),
      child: Consumer<CreateManualBilling>(builder: (context, p, w) {
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
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: Color.fromARGB(123, 0, 0, 0)),
                              ),
                              height: 100,
                            ),
                            Gap(32),
                            AutoSizeText(
                              "Informasi Keluarga",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Gap(16),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: Color.fromARGB(123, 0, 0, 0)),
                              ),
                              height: 100,
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
                              child: Column(
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
                                  Gap(16),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          AutoSizeText(
                                            "Total Biaya Obat",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Gap(8),
                                          Container(
                                            width: 250,
                                            child: TextField(
                                              controller: p.totalObat,
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
                                              onChanged: (value) {
                                                p.notifyUpdate();
                                              },
                                              decoration: InputDecoration(
                                                hintText: 'Masukan Jumlah',
                                                border: OutlineInputBorder(),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          const Color.fromARGB(
                                                              126, 0, 0, 0),
                                                      width: 1.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 96, 96, 96),
                                                      width: 2.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Gap(16),
                                      if (!ismanual)
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            AutoSizeText(
                                              "Total Biaya Paket Diluar",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Gap(8),
                                            Container(
                                              width: 250,
                                              child: TextField(
                                                controller: p.totalBiayaDiluar,
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
                                                onChanged: (value) {
                                                  p.notifyUpdate();
                                                },
                                                decoration: InputDecoration(
                                                  hintText: 'Masukan Jumlah',
                                                  border: OutlineInputBorder(),
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
                                                            .fromARGB(
                                                            255, 96, 96, 96),
                                                        width: 2.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      Gap(16),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          AutoSizeText(
                                            "",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Gap(8),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                ismanual = !ismanual;
                                              });
                                              p.clearvar();
                                            },
                                            child: Container(
                                              width: 250,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: !ismanual
                                                      ? Color(0xff16181E)
                                                      : Color.fromARGB(
                                                          124, 22, 24, 30)),
                                              child: Center(
                                                child: AutoSizeText(
                                                  "Gunakan Detail Paket Diluar",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Gap(32),
                            if (ismanual)
                              AutoSizeText(
                                "Detail Paket Diluar",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            Gap(16),
                            if (ismanual)
                              Container(
                                padding: EdgeInsets.all(8),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color: Color.fromARGB(123, 0, 0, 0)),
                                ),
                                child: Column(
                                  children: [
                                    Gap(8),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            AutoSizeText(
                                              "Masukan Nama Pelayanan",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Gap(8),
                                            Container(
                                              width: 250,
                                              child: TextField(
                                                controller: p.namaLayanan,
                                                decoration: InputDecoration(
                                                  hintText:
                                                      'Masukan Nama Pelayanan',
                                                  border: OutlineInputBorder(),
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
                                                            .fromARGB(
                                                            255, 96, 96, 96),
                                                        width: 2.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Gap(16),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            AutoSizeText(
                                              "Harga Layanan",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Gap(8),
                                            Container(
                                              width: 250,
                                              child: TextField(
                                                controller: p.hargaLayanan,
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
                                                decoration: InputDecoration(
                                                  hintText: 'Masukan Jumlah',
                                                  border: OutlineInputBorder(),
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
                                                            .fromARGB(
                                                            255, 96, 96, 96),
                                                        width: 2.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Gap(16),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            AutoSizeText(
                                              "",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Gap(8),
                                            GestureDetector(
                                              onTap: () {
                                                p.TambahData(context);
                                              },
                                              child: Container(
                                                width: 250,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    color: Color(0xff16181E)),
                                                child: Center(
                                                  child: AutoSizeText(
                                                    "Tambah Data",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    Gap(16),
                                    SizedBox(
                                      height: 500,
                                      child: ListView(
                                        children: p.listdata
                                            .map(
                                              (item) => ListPaketCard(
                                                nama: item['namaLayanan'],
                                                price: item['harga'],
                                                delete: () {
                                                  // Implementasi fungsi delete
                                                  p.removeItemByIdKey(
                                                      item['idKEY']);
                                                },
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    )
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
                                  "Order Details",
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
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AutoSizeText(
                                      "Biaya Total Obat",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    AutoSizeText(
                                      toIDRCurrency(p.totalObat.text),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Gap(8),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AutoSizeText(
                                      "Diluar Pelayanan",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    AutoSizeText(
                                      toIDRCurrency(p.total.toString()),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AutoSizeText(
                                      "Total Biaya ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    AutoSizeText(
                                      toIDRCurrency(p.totalbiaya.toString()),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                      GestureDetector(
                        onTap: () {
                          p.TambahData(context);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(color: Color(0xff16181E)),
                          child: Center(
                            child: AutoSizeText(
                              "Simpan Dan Cetak",
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
      }),
    );
  }
}
