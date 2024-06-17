import 'package:data_table_2/data_table_2.dart';
import 'package:fluent_ui/fluent_ui.dart' as ft;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:sibagjaapps/controllers/providers/P_AavatarColorsProvider.dart';
import 'package:sibagjaapps/controllers/providers/P_FindPatientsProviders.dart';
import 'package:gap/gap.dart';
import 'package:sibagjaapps/views/rekam_medis/components/parts/mainRekamMedis/DataTables.dart';

import '../../models/M_PasienModels.dart';

class MainRekam extends StatefulWidget {
  const MainRekam({super.key});

  @override
  _MainRekamState createState() => _MainRekamState();
}

class _MainRekamState extends State<MainRekam> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ChangeNotifierProvider(
        create: (context) => FindPatienProvider(),
        child: Consumer<FindPatienProvider>(
          builder: (context, provider, state) {
            return ft.Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 16),
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: ft.AutoSuggestBox<ModelPasien>(
                      placeholder: "Cari Nama Pasien",
                      items: provider.finderName
                          .map<ft.AutoSuggestBoxItem<ModelPasien>>(
                            (users) => ft.AutoSuggestBoxItem<ModelPasien>(
                              value: users,
                              label: users.namaPasien!,
                              onFocusChange: (focused) {
                                if (focused) {}
                              },
                            ),
                          )
                          .toList(),
                      onOverlayVisibilityChanged: (value) {
                        if (value == false) {
                          provider.findWithCase();
                        }
                        print(value);
                      },
                      onChanged: (text, reason) {
                        print(text);
                        print(reason);
                        
                        provider.fetchByName(text);
                      },
                      onSelected: (item) {
                          provider.selectedName(item.label);
                      },
                    ),
                  ),
                 provider.patient.length > 0 ? Expanded(
                    flex: 4,
                    child: Theme(
                      data: ThemeData(
                        cardTheme: CardTheme(
                          color: ft.Color.fromARGB(204, 255, 255, 255),
                          shadowColor: Colors.white,
                        ),
                      ),
                      child: PaginatedDataTable2(
                          showCheckboxColumn : false,
          availableRowsPerPage: const [2, 5, 10, 30, 100],
          horizontalMargin: 20,
          checkboxHorizontalMargin: 12,
          columnSpacing: 0,
          wrapInCard: false,
          renderEmptyRowsInTheEnd: true,
          headingRowColor:
              MaterialStateColor.resolveWith((states) => Colors.grey[200]!),
                  
                        
                        minWidth: 600,
                        columns: [
                          DataColumn(label: Text('Nama')),
                          DataColumn(label: Text('RM')),
                          DataColumn(label: Text('Alamat')),
                          DataColumn(label: Text('Action')),
                        ],
                        source: MyDataTableSource(provider.patient),
                      ),
                    ),
                  ) :
                  Expanded(child: Center(child: ft.Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
              
                      
                      Text("Cari Pasien",style: TextStyle(
                    fontSize: 24,fontWeight: FontWeight.bold,color: Colors.grey
                      ),),
                    ],
                  ),))
                  ,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
