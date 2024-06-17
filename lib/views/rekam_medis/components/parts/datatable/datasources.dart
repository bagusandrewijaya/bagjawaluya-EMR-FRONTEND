import 'package:auto_size_text/auto_size_text.dart';
import 'package:fluent_ui/fluent_ui.dart' as ft;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sibagjaapps/models/M_modelsTableRekamMedis.dart';

class UserDataSource extends DataTableSource {
  final List<MDataTableResumeMedis> _users;
  final BuildContext ctx;

  UserDataSource(this._users, this.ctx);

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);

    final user = _users[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Container(
          margin: EdgeInsets.all(3),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: user.type.toString().toUpperCase() == "PKP"
                ? Color(0xff7AB2B2)
                : Color(0xff97BE5A),
          ),
          child: AutoSizeText(
            user.namaPemeriksaan.toString(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )),
        DataCell(Text('${user.penanggungJawab}')),
        DataCell(Text('${user.createdAt}')),
        DataCell(GestureDetector(
          onTap: () {
            if (user.type.toString().toUpperCase() == "PKP") {
              ctx.pushNamed('pengkajianPsikiater', pathParameters: {
                "data": user.noRMFK.toString(),
                "idrequest": user.parentRM.toString()
              });
            } else if (user.type.toString().toUpperCase() == "CTD") {
              ctx.pushNamed('CatatanDokkter', pathParameters: {
                "data": user.noRMFK.toString(),
                "idrequest": user.parentRM.toString(),
                "name": user.namaPasien. toString(),
                "date": user.createdAt.toString().substring(0, 11)
              });
            }
          },
          child: Icon(ft.FluentIcons.pencil_reply),
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _users.length;

  @override
  int get selectedRowCount => 0;
}