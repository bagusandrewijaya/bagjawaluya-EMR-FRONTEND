// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fluent_ui/fluent_ui.dart' as ft;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import 'package:sibagjaapps/controllers/providers/P_detailsBilling.dart';
import 'package:sibagjaapps/views/rekam_medis/components/parts/detailsMenu/cardProfile.dart';

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
                  Text('List Biaya Di luar Pelayanan',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('${p.tagihan.length} items'),
                ],
              ),
              SizedBox(height: 16),
              ...p.tagihan
                  .map((item) => ListPaketCard(
                        nama: p.tagihan[0].namaTagihan.toString(),
                        price: p.tagihan[0].harga.toString(),
                        delete: () {
                          p.DeleteLayanan(p.tagihan[0].idKEY);
                          print("object");
                        },
                      ))
                  .toList(),
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
                  '${p.data.isNotEmpty ? p.data[0].tagihanBulanan.toString() : "Mohon Tunggu"}'),
              _buildSummaryRow(
                  'Biaya Obat',
                  ' ${p.data.isNotEmpty ? p.data[0].tagihanObat == null ? "Kosong" : p.data[0].tagihanObat : "Mohon Tunggu"}'),
              _buildSummaryRow(
                  'Biaya Luar Pelayanan',
                  ' ${p.data.isNotEmpty ? p.data[0].tagihanDiluarLayanan == null ? "Kosong" : p.data[0].tagihanDiluarLayanan : "Mohon Tunggu"}'),
              Divider(),
              _buildSummaryRow(
                  'Total Biaya',
                  ' ${p.data.isNotEmpty ? p.data[0].total == null ? "Kosong" : p.data[0].total : "Mohon Tunggu"}',
                  isTotal: true),
              SizedBox(height: 16),
              Text('Payment Details',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedPaymentMode,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Select Payment Mode',
                ),
                items: ['BCA', 'BRI', 'BNI', 'BSI', 'OTHER', 'CASH']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedPaymentMode = newValue;
                  });
                  // Additional logic here
                },
              ),
              SizedBox(height: 8),
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
              SizedBox(height: 8),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Cetak Tagihan',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
              Gap(8),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Verifikasi Pembayaran',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
              Gap(8),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Tambah Biaya',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent,
                  minimumSize: Size(double.infinity, 50),
                ),
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
                  Text(price, style: TextStyle(color: Colors.green)),
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
