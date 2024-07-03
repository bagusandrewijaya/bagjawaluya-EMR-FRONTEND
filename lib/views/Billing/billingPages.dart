// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:fluent_ui/fluent_ui.dart' as ft;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:sibagjaapps/controllers/providers/P_detailsBilling.dart';
import 'package:sibagjaapps/utils/Api_Services.dart';
import 'package:sibagjaapps/utils/downloaders/Url_Launcher.dart';
import 'package:sibagjaapps/utils/idCurrencyFormater/currencyIdr.dart';
import 'package:sibagjaapps/views/rekam_medis/components/parts/detailsMenu/cardProfile.dart';

import 'components/tagihan/widgetlistobat.dart';
import 'components/tagihan/widgetlistpelayanan.dart';

class HideScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: ScrollConfiguration(
                behavior: HideScrollBehavior(),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                            Text(" ${widget.idTagihan}",
                                style: TextStyle(
                                    color: const Color.fromARGB(
                                        103, 158, 158, 158))),
                          ],
                        ),
                      ),
                      Gap(8),
                      CardTop(
                        showed: false,
                        data: p.patients,
                        catatan: TextEditingController(),
                        savings: () {},
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 400,
                        child: Row(
                          children: [
                            WidgetPelayananDiluar(
                                p: p, idTagihan: widget.idTagihan.toString(),
                               statusTag: p.data[0].statusPaid!,
                                ),
                            Gap(8),
                            WidgetTagihanObat(
                                p: p, idTagihan: widget.idTagihan.toString(),
                                statusTag:  p.data[0].statusPaid!,
                                ),
                          ],
                        ),
                      ),
                      Gap(8),
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Riwayat Uang Masuk Pada Tagihan ini',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text('${p.payment.length} Riwayat'),
                                ],
                              ),
                              SizedBox(height: 16),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: p.payment.length,
                                itemBuilder: (context, index) {
                                  var item = p.payment[index];
                                  return ListPayment(
                                    nama:
                                        "${item.deskripsi.toString()} [${item.createat.toString().substring(0, 10)}]",
                                    price: item.amount.toString(),
                                    delete: () {
                                           
                                      if (p.data[0].statusPaid == "0") {
                                        showDialog<String>(
                                          context: context,
                                          builder: (context) =>
                                              ft.ContentDialog(
                                            title: const ft.Text('Hapus Item?'),
                                            content: const Text(
                                              'Jika Kamu Menghapus item ini maka tidak dapat di pulihkan',
                                            ),
                                            actions: [
                                              ft.Button(
                                                child: const Text('Hapus'),
                                                onPressed: () {
                                           
                                               p.DeletePayment(item.idpayment, context);
                                                  // Delete file here
                                                },
                                              ),
                                              ft.FilledButton(
                                                child: const Text('Batal'),
                                                onPressed: () => Navigator.pop(
                                                    context,
                                                    'User canceled dialog'),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        showDialog<String>(
                                          context: context,
                                          builder: (context) =>
                                              ft.ContentDialog(
                                            title: const ft.Text('DIKUNCI'),
                                            content: const Text(
                                              'Tagihan Sudah di verifikasi tagihan tidak dapat diubah Hubungi Kepala Administrasi Untuk Membuka Billing ini',
                                            ),
                                            actions: [
                                              ft.FilledButton(
                                                child: const Text('Batal'),
                                                onPressed: () => Navigator.pop(
                                                    context,
                                                    'User canceled dialog'),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
      child: SingleChildScrollView(
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
                        controller: p.flagging,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'No Transfer',
                        ),
                      ),
                      Gap(8),
                      TextFormField(
                        controller: p.description,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Nama Atau Tanda Pengirim',
                        ),
                      ),
                      Gap(8),
                      TextFormField(
                        controller: p.amountpay,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          CurrencyTextInputFormatter.currency(
                            locale: 'id',
                            decimalDigits: 0,
                            symbol: 'RP. ',
                          ),
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Jumlah Transfer',
                        ),
                      ),
                      SizedBox(height: 8),
                    if (p.data[0].statusPaid == "0")  GestureDetector(
                          onTap: () {
                            p.AddBillingOnpaymentP(context);
                          },
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
                    bukaBrowser('${API.Cetakinv}?id=${widget.idTagihan}');
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
                if (p.data[0].statusPaid == "0")
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
                if (p.data[0].statusPaid == "0")
                  GestureDetector(
                    onTap: () {
 showDialog<String>(
                                          context: context,
                                          builder: (context) =>
                                              ft.ContentDialog(
                                            title: const ft.Text('Perbarui Status'),
                                            content: const Text(
                                              'Apakah Kamu Yakin Akan Mengubah Status Pembayaran? Pastikan Total Pembayaran Dan total yang dibayarkan sudah sesuai',
                                            ),
                                            actions: [
                                              ft.Button(
                                                child: const Text('Yakin Dan Simpan'),
                                                onPressed: () {
                                           p.updatestatusBilling('1', context);
                                            
                                                  // Delete file here
                                                },
                                              ),
                                              ft.FilledButton(
                                                child: const Text('Batal'),
                                                onPressed: () => Navigator.pop(
                                                    context,
                                                    'User canceled dialog'),
                                              ),
                                            ],
                                          ),
                                        );

                    },
                    child: ft.Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: ft.Color.fromARGB(255, 255, 174, 34)),
                        child: Center(
                          child: AutoSizeText(
                            'Kunci dan selesaikan Billing',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                  ),

                Gap(8),
                if (p.data[0].statusPaid == "1")
                  GestureDetector(
                    onTap: () {
 showDialog<String>(
                                          context: context,
                                          builder: (context) =>
                                              ft.ContentDialog(
                                            title: const ft.Text('Perbarui Status'),
                                            content: const Text(
                                              'Apakah Kamu Yakin Akan Membuka Billing ini pastikan tindakan ini hanya dalam situasi insidentil',
                                            ),
                                            actions: [
                                              ft.Button(
                                                child: const Text('Yakin Dan Simpan'),
                                                onPressed: () {
                                           p.updatestatusBilling('0', context);
                                            
                                                  // Delete file here
                                                },
                                              ),
                                              ft.FilledButton(
                                                child: const Text('Batal'),
                                                onPressed: () => Navigator.pop(
                                                    context,
                                                    'User canceled dialog'),
                                              ),
                                            ],
                                          ),
                                        );

                    },
                    child: ft.Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: ft.Color.fromARGB(255, 255, 82, 34)),
                        child: Center(
                          child: AutoSizeText(
                            'Buka Billing',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                  ),
              ],
            ),
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
                  Text(toIDRCurrency(price),
                      style: TextStyle(color: Colors.green)),
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

class ListPayment extends StatelessWidget {
  String nama;
  String price;
  Function delete;
  ListPayment({
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
              color: Colors.green[300],
              child: Icon(
                Icons.money_off_csred,
                color: Colors.white,
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
                  Text(toIDRCurrency(price),
                      style: TextStyle(color: Colors.green)),
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
