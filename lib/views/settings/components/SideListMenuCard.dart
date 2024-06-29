
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sibagjaapps/models/M_ListButton.dart';
import 'package:fluent_ui/fluent_ui.dart' as ft;
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
          ),
            GestureDetector(
            onTap: () {
                setState(() {
              widget.tapindex(4);
                });
            },
            child: Container(
              color: Color.fromARGB(255, 54, 89, 203),
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              child: Center(child: Text("Buat Tagihan Manual",style: TextStyle(
                color: Colors.white,fontWeight: FontWeight.bold
              ),)),
            ),
          )

        ],
      ),
    );
  }
}