
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:sibagjaapps/controllers/providers/P_AavatarColorsProvider.dart';
import 'package:sibagjaapps/models/M_PasienModels.dart';
import 'package:fluent_ui/fluent_ui.dart' as ft;
class MyDataTableSource extends DataTableSource {
  List<ModelPasien> patients;
  late List<ModelPasien> _filteredRows;

  MyDataTableSource(this.patients) {
    _filteredRows = patients;
  }

  @override
  DataRow? getRow(int index) {
    if (index >= _filteredRows.length) return null;
    final patient = _filteredRows[index];
    return DataRow(cells: [
      DataCell(ft.Row(
        children: [
          ChangeNotifierProvider(
            create: (context) => AvatarColorsProviders(patient.namaPasien),
            child: Consumer<AvatarColorsProviders>(
              builder: (context,prv,w) {

                return Container(
                  margin: EdgeInsets.all(8),
                  height: 50,
                  width: 50,

                  decoration: BoxDecoration(shape: BoxShape.circle,
                  color: prv.avatarColor
                  ),
                  child: ft.Center(child: Text(patient.namaPasien!.substring(0,1).toUpperCase() ,style: TextStyle(
                    color: Colors.white,fontWeight: FontWeight.bold
                  ),)),
                );
              }
            ),
          ),
          Text(patient.namaPasien ?? '',style: TextStyle(
            fontWeight: FontWeight.bold
          ),),
        ],
      )),
      DataCell(ft.Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Color(0xff569DAA),
          borderRadius: BorderRadius.circular(8)
        ),
        child: Text(patient.noRMFK ?? '',style: TextStyle(
          color: Colors.white,fontWeight: FontWeight.bold
        ),))),
   
      DataCell(Text(patient.alamat ?? '')),
      DataCell(
        Row(
          children: [
          
            ft.Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    context.pushNamed('detailsPatient',pathParameters : {"data" : patient.noRMFK!});
                    
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xffFF9EAA)
                    ),
                    child: Row(
                      children: [
                        Icon(LineIcons.stethoscope,color: Colors.white,),
                        Text("Rekam Medis",style: TextStyle(
                          color: Colors.white,fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),
                  ),
                );
              }
            )
          ],
        )
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _filteredRows.length;

  @override
  int get selectedRowCount => 0;
}