import 'package:auto_size_text/auto_size_text.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:fluent_ui/fluent_ui.dart' as ft;
import 'package:flutter/material.dart';
import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart' as ft;
import 'package:modal_side_sheet/modal_side_sheet.dart';
import 'package:provider/provider.dart';
import 'package:sibagjaapps/controllers/providers/P_FindPatientsProviders.dart';
import 'package:sibagjaapps/controllers/providers/P_reportBillingProvider.dart';
import 'package:sibagjaapps/models/M_ChartsPendapatan.dart';
import 'package:sibagjaapps/models/M_bilingReport.dart';
import 'package:sibagjaapps/utils/Api_Services.dart';
import 'package:sibagjaapps/utils/idCurrencyFormater/currencyIdr.dart';
import 'package:sibagjaapps/views/Billing/components/charts/headerCharts.dart';
import 'package:go_router/go_router.dart';
import 'package:sibagjaapps/views/Billing/components/modal/ModalRekapanPayment.dart';
import 'package:sibagjaapps/views/Billing/components/modal/modalRekapanTahunan.dart';
import '../../models/M_PasienModels.dart';
import '../../utils/downloaders/Url_Launcher.dart';

class InvoiceReportPage extends StatefulWidget {
  final List titles;

  const InvoiceReportPage({super.key, required this.titles});
  @override
  _InvoiceReportPageState createState() => _InvoiceReportPageState();
}

class _InvoiceReportPageState extends State<InvoiceReportPage> {
  String getDateRangeFromIndex(int index) {
    final DateTime now = DateTime.now();

    switch (index) {
      case 0: // Last 7 Days
        final startDate = now.subtract(Duration(days: 7));
        return "${startDate.toString().substring(0, 11)}- ${now.toString().substring(0, 11)}";
      case 1: // Last Month
        final startDate = DateTime(now.year, now.month - 1, now.day);
        return "${startDate.toString().substring(0, 11)}- ${now.toString().substring(0, 11)}";
      case 2: // Last 3 Months
        final startDate = DateTime(now.year, now.month - 3, now.day);
        return "${startDate.toString().substring(0, 11)}- ${now.toString().substring(0, 11)}";
      case 3: // Last 12 Months
        final startDate = DateTime(now.year - 1, now.month, now.day);
        return "${startDate.toString().substring(0, 11)}- ${now.toString().substring(0, 11)}";
      default:
        return "${now.toString().substring(0, 11)}- ${now.toString().substring(0, 11)}";
    }
  }

  DateTime _fromDate = DateTime(2017, 7, 1);
  DateTime _toDate = DateTime(2017, 8, 31);
  final currencyFormat = NumberFormat("#,##0.00", "en_US");

  DateRange? selectedDateRange;

  int selectedIndex = -2;
  Map<String, String> types = {'--': '', 'LUNAS': '1', 'BELUM LUNAS': '0'};
  String? selectedType;
  String selectedname = '';
  DateTime? selected;
  @override
  void initState() {
    selectedType = types.keys.first;
    // Print nilai default yang dipilih
    print(types[selectedType]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (ctx) => ProviderReportBilling(),
        child: Consumer<ProviderReportBilling>(builder: (context, p, w) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PaymentReportChart(
                    data: p.paymentdata,
                  ),
                  Container(
                    padding: EdgeInsets.all(4),
                    color: Color.fromARGB(255, 89, 148, 250),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          child: DateRangeField(
                            decoration: InputDecoration(
                              label: Icon(
                                ft.LineIcons.calendarWithDayFocus,
                                size: 30,
                              ),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              filled: true,
                              fillColor: Color.fromARGB(255, 255, 255, 255),
                            ),
                            onDateRangeSelected: (DateRange? value) {
                              setState(() {
                                selectedDateRange = value;
                              });

                              p.changeDatePicker(selectedDateRange.toString());
                            },
                            selectedDateRange: selectedDateRange,
                            pickerBuilder: datePickerBuilder,
                          ),
                        ),
                        Gap(4),
                        ...List.generate(
                          widget.titles.length,
                          (index) {
                            return Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                    final dateRange =
                                        getDateRangeFromIndex(index);
                                    p.changeDatePicker(dateRange);
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  color: selectedIndex == index
                                      ? Color(0xffFFC233)
                                      : Colors.transparent,
                                  child:
                                      Center(child: Text(widget.titles[index])),
                                ),
                              ),
                            );
                          },
                        ),
                        Gap(2),
                        GestureDetector(
                          onTap: () {
                            showModalSideSheet(
                              context: context,
                              barrierDismissible: true,
                              barrierColor: Colors.transparent,
                              body: ft.Builder(builder: (context) {
                                return StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return Container(
                                    padding: EdgeInsets.all(8),
                                    color: Colors.transparent,
                                    child: ft.Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text(
                                              "Pencarian Dan Rekapan Billing",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            SizedBox(height: 8),
                                            ChangeNotifierProvider(
                                              create: (context) =>
                                                  FindPatienProvider(),
                                              child:
                                                  Consumer<FindPatienProvider>(
                                                      builder: (context,
                                                          provider, state) {
                                                return Container(
                                                  margin: EdgeInsets.only(
                                                      right: 16),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: ft.AutoSuggestBox<
                                                      ModelPasien>(
                                                    placeholder:
                                                        selectedname == ''
                                                            ? "Cari Nama Pasien"
                                                            : selectedname,
                                                    items: provider.finderName
                                                        .map<
                                                            ft
                                                            .AutoSuggestBoxItem<
                                                                ModelPasien>>(
                                                          (users) => ft
                                                              .AutoSuggestBoxItem<
                                                                  ModelPasien>(
                                                            value: users,
                                                            label: users
                                                                .namaPasien!,
                                                            onFocusChange:
                                                                (focused) {
                                                              if (focused) {}
                                                            },
                                                          ),
                                                        )
                                                        .toList(),
                                                    onOverlayVisibilityChanged:
                                                        (value) {
                                                      if (value == false) {}
                                                      print(value);
                                                    },
                                                    onChanged: (text, reason) {
                                                      print(text);
                                                      print(reason);
                                                      provider
                                                          .fetchByName(text);
                                                    },
                                                    onSelected: (item) {
                                                      print(item.value!.noRMFK);
                                                      p.setname(
                                                          item.value!.noRMFK);
                                                      setState(() {
                                                        selectedname = item
                                                            .value!.namaPasien!;
                                                      });
                                                    },
                                                  ),
                                                );
                                              }),
                                            ),
                                            Gap(8),
                                            ft.ComboBox<String>(
                                                value: selectedType,
                                                items: types.entries.map((e) {
                                                  return ft.ComboBoxItem(
                                                    child: Text(e.key),
                                                    value: e.key,
                                                  );
                                                }).toList(),
                                                onChanged: (z) {
                                                  setState(() {
                                                    selectedType = z!;
                                                    print(types[selectedType]
                                                        .toString());
                                                    p.setype(types[selectedType]
                                                        .toString());
                                                  });
                                                }),
                                            SizedBox(height: 8),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: GestureDetector(
                                                onTap: () {
                                                  showModalBottomSheet(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return ModalRekapanPayment();
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xff16181E)),
                                                  child: Center(
                                                    child: Text(
                                                      "LIHAT REKAPAN UANG MASUK ",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            
                                            Gap(8),
                                            GestureDetector(
                                                onTap: () {
                                                  showModalBottomSheet(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return ModalRekapTahunan();
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xff16181E)),
                                                  child: Center(
                                                    child: Text(
                                                      "LIHAT REKAPAN TAHUNAN",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              )
                                          ],
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: GestureDetector(
                                            onTap: () {
                                              p.FetchAllBilling();
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              width: 250,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: Color(0xff16181E)),
                                              child: Center(
                                                child: Text(
                                                  "Simpan",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                });
                              }),
                            );
                          },
                          child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Icon(
                                ft.LineIcons.search,
                                size: 21,
                              )),
                        ),
                        Gap(8),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = -2;
                              selectedDateRange = null;
                            });
                            p.clearButton();
                          },
                          child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Icon(
                                ft.LineIcons.eraser,
                                size: 21,
                              )),
                        ),
                        Gap(8)
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  _buildInvoiceTable(p.billing),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildInvoiceTable(datatableValue) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: PaginatedDataTable2(
        source: InvoiceDataSource(datatableValue, context),
      rowsPerPage: 50,
        horizontalMargin: 20,
        checkboxHorizontalMargin: 0,
        columnSpacing: 0,
        wrapInCard: false,
        renderEmptyRowsInTheEnd: false,
        fit: FlexFit.tight,
        headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
        columns: [
          DataColumn2(label: Text('Date'), size: ColumnSize.L),
          DataColumn2(label: Text('No Invoice'), size: ColumnSize.L),
          DataColumn2(label: Text('Pasien'), size: ColumnSize.M),
          DataColumn2(label: Text('Tagihan'), size: ColumnSize.L),
          DataColumn2(label: Text('Dibayarkan'), size: ColumnSize.L),
          DataColumn2(label: Text('Sisa Tagihan'), size: ColumnSize.L),
          DataColumn2(label: Text('Pembayaran\nTerbaru'), size: ColumnSize.L),
          DataColumn2(
              label: Text(
                'Payment\nStatus',
              ),
              size: ColumnSize.L),
          DataColumn2(label: Text('Verifikasi Oleh'), size: ColumnSize.L),
          DataColumn2(label: Text('Action'), size: ColumnSize.L),
          DataColumn2(label: Text(''), size: ColumnSize.L),
        ],
      ),
    );
  }

  Widget datePickerBuilder(
          BuildContext context, dynamic Function(DateRange?) onDateRangeChanged,
          [bool doubleMonth = true]) =>
      DateRangePickerWidget(
        doubleMonth: doubleMonth,
        quickDateRanges: [],
        minimumDateRangeLength: 3,
        initialDateRange: selectedDateRange,
        initialDisplayedDate: selectedDateRange?.start ?? DateTime.now(),
        onDateRangeChanged: onDateRangeChanged,
        height: 350,
        theme: const CalendarTheme(
          selectedColor: Colors.blue,
          dayNameTextStyle: TextStyle(color: Colors.black45, fontSize: 10),
          inRangeColor: Color(0xFFD9EDFA),
          inRangeTextStyle: TextStyle(color: Colors.blue),
          selectedTextStyle: TextStyle(color: Colors.white),
          todayTextStyle: TextStyle(fontWeight: FontWeight.bold),
          defaultTextStyle: TextStyle(color: Colors.black, fontSize: 12),
          radius: 10,
          tileSize: 40,
          disabledTextStyle: TextStyle(color: Colors.grey),
          selectedQuickDateRangeColor: Colors.blue,
        ),
      );
}


class InvoiceDataSource extends DataTableSource {
  final List<M_BillingReport> data;
  final BuildContext context;
  InvoiceDataSource(this.data, this.context);

  @override
  DataRow getRow(int index) {
    final invoice = data[index];
    final isEvenRow = index % 2 == 0;
    return DataRow(
      color: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (isEvenRow)
            return Colors.blue
                .withOpacity(0.1); // Warna biru muda untuk baris genap
          return Colors.white; // Warna putih untuk baris ganjil
        },
      ),
      cells: [
        DataCell(Padding(
            padding: EdgeInsets.all(4),
            child: Text(invoice.createdAt.toString().substring(0, 10)))),
        DataCell(Padding(
            padding: EdgeInsets.all(4),
            child: Row(
              children: [
                SizedBox(
                    width: 70,
                    child: Text(
                      invoice.idTagihan!,
                      maxLines: 1,
                    )),
                Icon(Icons.copy)
              ],
            ))),
        DataCell(Padding(
            padding: EdgeInsets.all(4), child: Text(invoice.namaPasien!))),
        DataCell(Text(toIDRCurrency(invoice.total!))),
        DataCell(Text(toIDRCurrency(invoice.totalDibayarkan)!)),
        DataCell(Text(toIDRCurrency(invoice.totalBelumDibayarkan!))),
        DataCell(Padding(
            padding: EdgeInsets.all(4),
            child: Text(invoice.tanggalTerakhirPayment!))),
        DataCell(Text(invoice.statusPaid == "0" ? "BELUM LUNAS" : "LUNAS",
            style: TextStyle(
                color: invoice.statusPaid == '0'
                    ? Colors.red
                    : Color.fromARGB(255, 32, 153, 64)))),
        DataCell(Text(invoice.approvedBy!)),
        DataCell(ft.Row(
          children: [
            GestureDetector(
              onTap: () {
                bukaBrowser('${API.Cetakinv}?id=${invoice.idTagihan}');
              },
              child: Container(
                  padding: EdgeInsets.all(4),
                  decoration:
                      BoxDecoration(color: ft.Color.fromARGB(120, 126, 242, 124)),
                  child: Icon(ft.FluentIcons.print,color: Colors.black,)),
            ),
            Gap(8),
            GestureDetector(
              onTap: () {
                bukaBrowser('${API.LaporanUangMasuk}?billing=${invoice.idTagihan}');
              },
              child: Container(
                  padding: EdgeInsets.all(4),
                  decoration:
                      BoxDecoration(color: ft.Color.fromARGB(120, 242, 146, 124)),
                  child: Icon(ft.FluentIcons.money,color: Colors.black,)),
            ),
          ],
        )),
        DataCell(
          ft.Padding(
            padding: const EdgeInsets.only(left: 2),
            child: GestureDetector(
              onTap: () {
                context.pushNamed('checkout',
                    pathParameters: {"idtagihan": invoice.idTagihan});
              },
              child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: ft.Color.fromARGB(255, 58, 121, 177)),
                  child: Text(
                    "LIHAT BILLING",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
            ),
          ),
        ),
        
        
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
