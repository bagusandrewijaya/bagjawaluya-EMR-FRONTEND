import 'dart:convert';


import 'package:auto_size_text/auto_size_text.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:fluent_ui/fluent_ui.dart' as ft;
import 'package:flutter/material.dart';
import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';

import 'package:gap/gap.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:sibagjaapps/controllers/providers/P_Billing_Views.dart';
import 'package:sibagjaapps/models/M_billingList.dart';
import 'package:sibagjaapps/views/settings/components/Checkoutpages.dart';
import 'package:sibagjaapps/views/settings/components/createpembayaran.dart';
import 'package:sibagjaapps/views/settings/components/masterbiaya.dart';
import 'package:go_router/go_router.dart' as ct ;
import '../../models/M_ListButton.dart';

class KeuanganModules extends StatefulWidget {
  const KeuanganModules({super.key});
  @override
  State<KeuanganModules> createState() => _KeuanganModulesState();
}

class _KeuanganModulesState extends State<KeuanganModules> {


  final List<String> titles = [
    "Last 7 Days",
    "Last Month",
    "Last 3 Months",
    "Last 12 Months"
  ];



int i = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body:  ChangeNotifierProvider(
                create: (context) => ProviderBilling(),
                child:Consumer<ProviderBilling>(
            builder: (context,p,w) {
            return Row(
              children: [
                // Children row pertama
                 SizedBox(
              width: 280,
              child: SideMenuContainer(data2: p.data, tapindex: (int z) {
                setState(() {
                  i = z;
                });
              
               },)
            ),
            if( p.data.length > 0 )
                if(i == 0)...[
             Container(
                  child: Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: const [
                                          Text(
                                            "Billing Pasien",
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: const [
                                          Icon(
                                            ft.FluentIcons.print,
                                            color: Colors.grey,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                         
                          MyHomePage(
                            data: p.billing, 
                            titles: titles,
                          )
                        ],
                      ),
                    ),
                  ),
                )
                ]else if(i==1)...[
            
                ]else if(i== 2)...[
               CheckoutPageManual()
                ]else if(i == 3)...[
              BillingInformationWidget(idTagihan: '',)
                ]
              ],
            );
          }
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final List<MBillingList> data ;
 final List titles ;
  MyHomePage({super.key, required this.data, required this.titles});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    DateRange? selectedDateRange;
      int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.transparent,
        child: SingleChildScrollView(
          child: Column(
            children: [

               Container(
                      color: Color(0xffF0F0F0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                             Container(

                              width:50,
                              height: 50,
                              child:DateRangeField(
                      decoration:  InputDecoration(
                        label: Icon(LineIcons.filter),
                        enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                filled: true,
                fillColor: Colors.white,
           
                      ),
                      onDateRangeSelected: (DateRange? value) {
                        setState(() {
                          selectedDateRange = value;
                         
                        });
                      },
                      selectedDateRange: selectedDateRange,
                      pickerBuilder: datePickerBuilder,
                    ),
                  ),
                         ...List.generate(widget.titles.length, (index) {
                            return Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  color: selectedIndex == index
                                      ? Color(0xffFFC233)
                                      : Colors.transparent,
                                  child: Center(child: Text(widget.titles[index])),
                                ),
                              ),
                            );
                          }),
                       
                          Gap(8)

                          
                        ],
                      ),
                    ),
               
              Container(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari Transaksi...',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  ),
                ),
              ),
              SizedBox(
                height: 600,
                child: Container(
                    color: Colors.white,
                    child: PaginatedDataTable2(
                      showCheckboxColumn: false,
                      horizontalMargin: 20,
                      checkboxHorizontalMargin: 12,
                      wrapInCard: false,
                      renderEmptyRowsInTheEnd: true,
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.grey[200]!),
                      minWidth: 600,
                      columns: [
                        DataColumn(label: Text('Tanggal')),
                        DataColumn(label: Text('Nama Pasien')),
                        DataColumn(label: Text('Tanggal Batas Transakasi')),
                        DataColumn(label: Text('Rp')),
                        DataColumn(label: Text('Status Pembayaran')),
                      ],
                      source: _DataSource(widget.data,context),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

 Widget datePickerBuilder(
          BuildContext context, dynamic Function(DateRange?) onDateRangeChanged,
          [bool doubleMonth = true]) =>
      DateRangePickerWidget(
        doubleMonth: doubleMonth,
    
        quickDateRanges: [
        
        ],
        minimumDateRangeLength: 3,
        initialDateRange: selectedDateRange,
   
        initialDisplayedDate:
            selectedDateRange?.start ?? DateTime.now(),
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



class _DataSource extends DataTableSource {
  final List<MBillingList> _data;
BuildContext context;
  _DataSource(this._data,this.context);

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_data[index].createdAt.toString().substring(0,11))),
      DataCell(Text(_data[index].namaPasien.toString())),
      DataCell(Text(_data[index].batasBayar.toString().substring(0,11))),
      DataCell(Text(_data[index].total.toString())),
      DataCell(GestureDetector(
        onTap: () {
         
          context.pushNamed('checkout',pathParameters: {"idtagihan" : _data[index].idTagihan.toString()});
        },
        child: Container(
          child: AutoSizeText(_data[index].statusPaid == "0" ? "Belum DiBayarkan": "Sudah Dibayarkan" ),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color:_data[index].statusPaid != "0" ? Colors.green: Colors.red )
          
        ),
      )),
    ]);
  }
}


class SideMenuContainer extends StatefulWidget {
  final List <ButtonListKeuangan>data2;
    void Function(int) tapindex;
   SideMenuContainer({super.key, required this.data2,required this.tapindex});

  @override
  _SideMenuContainerState createState() => _SideMenuContainerState();
}

class _SideMenuContainerState extends State<SideMenuContainer> {
  int _selectedIndex = 0; // Tidak ada indeks yang dipilih pada awalnya

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ft.Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.data2.length,
              itemBuilder: (context, index) {
                var i = widget.data2[index];
                return GestureDetector(
                  onTap: () {
               
                    setState(() {
                      _selectedIndex = index;
                           widget.tapindex(_selectedIndex);
                    });
                  },
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: (_selectedIndex == index) ? ft.Color.fromARGB(255, 253, 252, 252) :   Color(0xffF0F0F0),
                      border: Border.all(width: 1, color:  Colors.grey),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${i.title == null ? "0" : i.title}",style: TextStyle(
                            fontWeight: FontWeight.bold,fontSize: 18
                          ),),
                          SizedBox(height: 8.0),
                         if(i.title!.toLowerCase() != "sudah dibayar") Text(
                            'Rp ${i.total == null ?   "0" : i.total}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0,
                            ),
                          ),
                          Gap(8),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            height: (_selectedIndex == index) ? 10 : 5,
                            width: (_selectedIndex == index) ? 200 : 5,
                            decoration: BoxDecoration(
                              color:  (_selectedIndex == index) ? Colors.green : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

            GestureDetector(
              onTap: () {
                
                setState(() {
               widget.tapindex(2);
                });
              },
              child: Container(
              color: ft.Color.fromARGB(255, 54, 203, 200),
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              child: Center(child: Text("Master Biaya",style: TextStyle(
                color: Colors.white,fontWeight: FontWeight.bold
              ),)),
                        ),
            ),
            Gap(8),
          GestureDetector(
            onTap: () {
                setState(() {
              widget.tapindex(3);
                });
            },
            child: Container(
              color: Color(0xffCB3694),
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              child: Center(child: Text("Cari Tagihan Pasien",style: TextStyle(
                color: Colors.white,fontWeight: FontWeight.bold
              ),)),
            ),
          )
        ],
      ),
    );
  }
}