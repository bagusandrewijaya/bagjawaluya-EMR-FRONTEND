// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:fluent_ui/fluent_ui.dart' as ft;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:sibagjaapps/controllers/providers/P_detailsBilling.dart';
import 'package:sibagjaapps/utils/downloaders/Url_Launcher.dart';
import 'package:sibagjaapps/utils/idCurrencyFormater/currencyIdr.dart';
import 'package:sibagjaapps/views/rekam_medis/components/parts/detailsMenu/cardProfile.dart';

import 'tagihan/widgetlistobat.dart';
import 'tagihan/widgetlistpelayanan.dart';

class CheckoutPage extends StatefulWidget {
  final String? idTagihan;

  const CheckoutPage({super.key, this.idTagihan});
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String? selectedPaymentMode;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProvidersDetailsBilling(widget.idTagihan),
      child: Consumer<ProvidersDetailsBilling>(builder: (context, p, w) {
        return Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(ft.FluentIcons.back),
                        SizedBox(width: 8),
                        Text('Kembali / ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                          " ${widget.idTagihan}",
                          style: TextStyle(
                              color: const Color.fromARGB(103, 158, 158, 158)),
                        )
                      ],
                    ),
                  ),
                  Gap(8),
                  Expanded(
                    child: CardTop(
                      showed: false,
                      data: p.patients,
                      catatan: TextEditingController(),
                      savings: () {},
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: Row(
                      children: [
                        WidgetPelayananDiluar(p: p, idTagihan: widget.idTagihan.toString(),),
                        Gap(8),
                       WidgetTagihanObat(p: p, idTagihan: widget.idTagihan.toString(),),
                       
                      ],
                    ),
                  ),
                  Gap(8),
                  Expanded(
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
                                Text('Riwayat Uang Masuk Pada Tagihan ini ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text('${p.tagihan.length} items'),
                              ],
                            ),
                            SizedBox(height: 16),
                            
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            _buildOrderSummary(p),
          ],
        );
      }),
    );
  }

  Widget _buildOrderSummary(ProvidersDetailsBilling p) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Informasi Tagihan',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('TIPE TAGIHAN',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color.fromARGB(255, 154, 64, 251)),
                      child: Text(
                          ' ${p.data.isNotEmpty ? p.data[0].flaggingType == null ? "Kosong" : p.data[0].flaggingType : "Mohon Tunggu"}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)))
                ],
              ),
              SizedBox(height: 16),
              _buildSummaryRow('Total Biaya Bulanan',
                  '${p.data.isNotEmpty ? toIDRCurrency(p.data[0].tagihanBulanan!) : "Mohon Tunggu"}'),
              _buildSummaryRow(
                  'Biaya Obat',
                  ' ${p.data.isNotEmpty ? p.data[0].tagihanObat == null ? "Kosong" : toIDRCurrency(p.data[0].tagihanObat!) : "Mohon Tunggu"}'),
              _buildSummaryRow(
                  'Biaya Luar Pelayanan',
                  ' ${p.data.isNotEmpty ? p.data[0].tagihanDiluarLayanan == null ? "Kosong" : toIDRCurrency(p.data[0].tagihanDiluarLayanan!) : "Mohon Tunggu"}'),
              Divider(),
              _buildSummaryRow(
                  'Total Biaya',
                  ' ${p.data.isNotEmpty ? p.data[0].total == null ? "Kosong" : toIDRCurrency(p.data[0].total!) : "Mohon Tunggu"}',
                  isTotal: true),
              _buildTotalPayment(
                  'Total sudah dibayarkan sejumlah',
                  ' ${p.data.isNotEmpty ? p.data[0].total == null ? "Kosong" : toIDRCurrency(p.data[0].totalDibayarkan!) : "Mohon Tunggu"}',
                  Colors.blueAccent,
                  isTotal: true),
              _buildTotalPayment(
                  'Sisa Yang Harus Dibayarkan',
                  ' ${p.data.isNotEmpty ? p.data[0].total == null ? "Kosong" : toIDRCurrency(p.data[0].totalBelumDibayarkan!) : "Mohon Tunggu"}',
                  Colors.red,
                  isTotal: true),
              SizedBox(height: 16),
              Text('Payment Details',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1, color: Colors.grey)),
                child: Column(
                  crossAxisAlignment: ft.CrossAxisAlignment.end,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'No Transfer',
                      ),
                    ),
                    Gap(8),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nama Pengirim',
                      ),
                    ),
                    Gap(8),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Jumlah',
                      ),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 250,
                          height: 50,
                          decoration: BoxDecoration(color: Color(0xff16181E)),
                          child: Center(
                            child: AutoSizeText(
                              "Simpan Pembayaran",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {

                  bukaBrowser('https://api.vpscloudtrx.online/Cetakinv');
                },
                child: ft.Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: ft.Color.fromARGB(255, 13, 198, 69)),
                    child: Center(
                      child: AutoSizeText(
                        'Cetak Pembayaran',
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ),
              Gap(8),
              GestureDetector(
                  onTap: () {},
                  child: ft.Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: ft.Color.fromARGB(255, 34, 90, 255)),
                    child: Center(
                      child: AutoSizeText(
                        'Bayar Tagihan Menggunakan Saldo Pasien',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )),
              Gap(8),
              GestureDetector(
                onTap: () {},
                child: ft.Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: ft.Color.fromARGB(255, 255, 174, 34)),
                    child: Center(
                      child: AutoSizeText(
                        'Verifikasi Pembayaran',
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: isTotal ? TextStyle(fontWeight: FontWeight.bold) : null),
          Text(value,
              style: isTotal
                  ? TextStyle(fontWeight: FontWeight.bold, color: Colors.green)
                  : null),
        ],
      ),
    );
  }

  Widget _buildTotalPayment(String label, String value, Color z,
      {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: isTotal ? TextStyle(fontWeight: FontWeight.bold) : null),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: z)),
        ],
      ),
    );
  }
}

class ListPaketCard extends StatelessWidget {
  String nama;
  String price;
  Function delete;
  ListPaketCard({
    Key? key,
    required this.nama,
    required this.price,
    required this.delete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 60,
              height: 60,
              color: Colors.grey[300],
              child: Icon(
                Icons.medical_services,
                color: Colors.grey,
              ),
              // You can add an image here
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(nama, style: TextStyle(fontWeight: FontWeight.bold)),
                  Gap(8),
                  Text(toIDRCurrency(price), style: TextStyle(color: Colors.green)),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      delete();
                    }),
              ],
            ),
          ],
        ),
        Divider(),
      ],
    );
  }
}



