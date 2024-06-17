
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as ft;
import 'package:gap/gap.dart';
class MyCustomForm extends StatefulWidget {
  final Function(Map<String, String>) onFieldTap;
final Function() onFieldsaveTap;
  MyCustomForm({Key? key, required this.onFieldTap,required this.onFieldsaveTap}) : super(key: key);

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final TextEditingController _pesanController = TextEditingController();
  final TextEditingController _namaObatController = TextEditingController();

DateTime _time = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
   
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,

          children: [
         ft.Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: const ft.Color.fromARGB(94, 0, 0, 0)),
                            borderRadius: BorderRadius.circular(8)),
                        child: ft.DatePicker(
                          selected: _time,
                          onChanged: (time) {
                            setState(() {
                              _time = time;
                            });
                          }
                        ),
                      ),
                Gap(16),
           TextField(
                style: TextStyle(fontSize: 16.0),
                controller: _namaObatController,
                decoration: InputDecoration(
                    alignLabelWithHint: true, 
                  labelText: 'Pengobatan ',
                  labelStyle: TextStyle(fontSize: 16.0),
                  border: OutlineInputBorder(),
                ),
              maxLines: 3,
              ),
               Gap(16),
           TextField(
  style: TextStyle(fontSize: 16.0),
  controller: _pesanController,
  decoration: InputDecoration(
    labelText: 'PESAN',
    labelStyle: TextStyle(fontSize: 16.0),
    border: OutlineInputBorder(),
    alignLabelWithHint: true, // Menempatkan label di atas TextField
  ),
  maxLines: 10,
),

              Gap(8),
           Row(
            children: [
               GestureDetector(
              onTap: () {
                widget.onFieldTap({
                  "pesan": _pesanController.text,
                  "obat": _namaObatController.text,
                  "tanggal":_time.toString().substring(0,11).replaceAll('-', '/'),
                });
              },
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  "Tambah",
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                ),
              ),
            ),
               Gap(16),
          
            ],
           ),
         
          ],
        ),
      ),
    );
  }
}