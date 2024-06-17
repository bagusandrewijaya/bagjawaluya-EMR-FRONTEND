
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LastActivity extends StatelessWidget {
  const LastActivity({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
              padding: EdgeInsets.all(8),
       decoration: BoxDecoration(
          color: const Color.fromARGB(146, 255, 255, 255),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, 20),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
           children: [
        
            Text("Aktifitas Perubahan Data",style: TextStyle(
              fontWeight: FontWeight.bold,fontSize: 21
            ),),
            Gap(8),
             Expanded(
               child: ListView.builder(
                 itemCount: 32,
                 itemBuilder: (context, index) {
                   return Container(
                  
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: AutoSizeText("Pemeriksaan Abc D",style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),),
                            ),
                            
                           
                            
                          ],
                        ),
                        Divider(),
                      ],
                    ),
                   );
                 },
               ),
             ),
           ],
         ),
      )
    );
  }
}
