
import 'package:flutter/material.dart';
import 'package:sibagjaapps/models/M_TableCtd.dart';

class MedicalRecordTable extends StatefulWidget {
  final Map<String, TableRowData> tableRowsMap;
  final Function(String) onRemove;

  MedicalRecordTable({Key? key, required this.tableRowsMap, required this.onRemove}) : super(key: key);

  @override
  _MedicalRecordTableState createState() => _MedicalRecordTableState();
}

class _MedicalRecordTableState extends State<MedicalRecordTable> {
  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      columnWidths: {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(1),
      },
      children: [
        TableRow(
          children: [
            TableCell(child: Center(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Tanggal / Pukul',style: TextStyle(
                fontWeight: FontWeight.bold
              ),),
            ))),
            TableCell(child: Center(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Pemeriksaan Keaadan Pasien/Perkembangan\nPerubahan Diagnosis',style: TextStyle(
                fontWeight: FontWeight.bold
              ),),
            ))),
            TableCell(child: Center(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Pengobatan',style: TextStyle(
                fontWeight: FontWeight.bold
              ),),
            ))),
            TableCell(child: Center(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('check',style: TextStyle(
                fontWeight: FontWeight.bold
              ),),
            ))),
          ],
        ),
        ...widget.tableRowsMap.values.map((rowData) {
          return TableRow(
            children: [
              TableCell(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(rowData.tanggal),
              )),
              TableCell(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(rowData.pesan),
              )),
              TableCell(child: Text(rowData.obat)),
              TableCell(child: GestureDetector(
                onTap: () => widget.onRemove(rowData.id),
                child: Container(
                  margin: EdgeInsets.all(32),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Icon(Icons.delete,color: Colors.white,),
                  ),
                ),
              )),
            ],
          );
        }).toList(),
      ],
    );
  }
}
