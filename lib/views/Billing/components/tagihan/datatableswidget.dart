

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sibagjaapps/models/M_billingList.dart';

class DataSourceTables extends DataTableSource {
  final List<MBillingList> _data;
BuildContext context;
  DataSourceTables(this._data,this.context);

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

      DataCell(Text(_data[index].total.toString())),
      DataCell(GestureDetector(
        onTap: () {
         
          context.pushNamed('checkout',pathParameters: {"idtagihan" : _data[index].idTagihan.toString()});
        },
        child: Container(
          child: AutoSizeText(_data[index].statusPaid == "0" ? "Belum Bayarkan": "Sudah Dibayarkan",style: TextStyle(
            color: Colors.white
          ), ),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color:_data[index].statusPaid == "1" ? Colors.green: Colors.red )
          
        ),
      )),
    ]);
  }
}
