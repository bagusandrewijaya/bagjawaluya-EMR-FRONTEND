import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sibagjaapps/models/M_modelsTableRekamMedis.dart';
import 'package:sibagjaapps/views/rekam_medis/components/parts/datatable/datasources.dart';

class TableResumeMedis extends StatefulWidget {
  final List<MDataTableResumeMedis> data;

  TableResumeMedis({required this.data});

  @override
  State<TableResumeMedis> createState() => _TableResumeMedisState();
}

class _TableResumeMedisState extends State<TableResumeMedis> {
  String filterValue = '';

  @override
  Widget build(BuildContext context) {
    List<MDataTableResumeMedis> filteredData = widget.data.where((user) =>
      user.namaPemeriksaan.toString().toLowerCase().contains(filterValue.toLowerCase()) ||
      user.penanggungJawab.toString().toLowerCase().contains(filterValue.toLowerCase())
    ).toList();

    return Expanded(
      child: Theme(
        data: ThemeData(
          cardColor: Color.fromARGB(0, 255, 255, 255),
          cardTheme: CardTheme(
            color: Color.fromARGB(0, 255, 255, 255),
            surfaceTintColor: Color.fromARGB(0, 255, 255, 255),
            shadowColor: Color.fromARGB(0, 255, 255, 255),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(146, 255, 255, 255),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: PaginatedDataTable2(
            header: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Resume Medis'),
                Gap(16),
                Container(
                  width: 250,
                  height: 100,
                  child: TextField(
                    decoration: InputDecoration(
                    hintText: "Cari Nama"
                    ),
                    onChanged: (value) {
                      setState(() {
                        filterValue = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            columns: [
              DataColumn(label: Text('Nama Pemeriksaan')),
              DataColumn(label: Text('Penanggung Jawab')),
              DataColumn(label: Text('Tanggal Pemeriksaan')),
              DataColumn(label: Text('Action')),
            ],
            source: UserDataSource(filterValue.isEmpty ? widget.data : filteredData, context),
            onRowsPerPageChanged: (rowsPerPage) {
              // Do something when rows per page changes
            },
            dataRowHeight: 80,
          ),
        ),
      ),
    );
  }
}
