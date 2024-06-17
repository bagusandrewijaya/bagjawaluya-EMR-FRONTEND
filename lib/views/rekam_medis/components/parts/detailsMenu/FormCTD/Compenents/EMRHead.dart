
import 'package:flutter/material.dart';

class MedicalRecordTableHead extends StatefulWidget {
final String name;
final String rm;
final String Date;

  const MedicalRecordTableHead({super.key, required this.name, required this.rm, required this.Date});


  @override
  _MedicalRecordTableHeadState createState() => _MedicalRecordTableHeadState();
}

class _MedicalRecordTableHeadState extends State<MedicalRecordTableHead> {
  @override
  Widget build(BuildContext context) {
    return Table(
        border: TableBorder.all(),
        columnWidths: {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(2),

        },
        children: [
          TableRow(
            children: [
              TableCell(child: Center(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('PEMERIKSAAN DOKTER ' ),
              ))),
              TableCell(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Nama : ${widget.name.toString()}'),
                     Text('No.RM : ${widget.rm}'),
                      Text('Tanggal : ${widget.Date}'),
                  ],
                ),
              )),
          
            ],
          ),
 
        ],
      );
  }
}
