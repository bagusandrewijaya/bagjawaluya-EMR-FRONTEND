
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sibagjaapps/controllers/providers/P_Billing_Views.dart';
import 'package:sibagjaapps/models/M_billingList.dart';
import 'package:sibagjaapps/views/settings/components/tagihan/datatableswidget.dart';

class WidgetListBilling extends StatefulWidget {
  final List<MBillingList> data ;
 final List titles ;
  ProviderBilling p;
  WidgetListBilling({super.key, required this.data, required this.titles,required this.p});
  @override
  _WidgetListBillingState createState() => _WidgetListBillingState();
}

class _WidgetListBillingState extends State<WidgetListBilling> {
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
      final startDate = DateTime(now.year, now.month- 3, now.day);
      return "${startDate.toString().substring(0, 11)}- ${now.toString().substring(0, 11)}";
    case 3: // Last 12 Months
      final startDate = DateTime(now.year - 1, now.month, now.day);
      return "${startDate.toString().substring(0, 11)}- ${now.toString().substring(0, 11)}";
    default:
      return "${now.toString().substring(0, 11)}- ${now.toString().substring(0, 11)}";
  }
}
    DateRange? selectedDateRange;
    
      int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
  
    return Container(
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
                       widget.p.changeDatePicker(selectedDateRange.toString());
                    
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
                                    final dateRange = getDateRangeFromIndex(index);
                                                    widget.p.changeDatePicker(dateRange);

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
                height: MediaQuery.of(context).size.height ,
                child: Container(
                    color: Colors.white,
                    child: PaginatedDataTable2(
                      showCheckboxColumn: false,
                      horizontalMargin: 20,
                      checkboxHorizontalMargin: 12,
                      rowsPerPage: 50,
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
                      source: DataSourceTables(widget.data,context),
                    )),
              ),
            ],
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