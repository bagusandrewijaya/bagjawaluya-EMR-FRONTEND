
import 'package:flutter/material.dart';

class HeaderTitleGradient extends StatelessWidget {
 final String text;
   HeaderTitleGradient({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
                                          padding: EdgeInsets.all(8),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(21),
                                            gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Colors.blue.withOpacity(0.8), // Warna gradient di sebelah kiri
                                          Colors.transparent, // Warna transparan di sebelah kanan
                                        ],
                                            ),
                                          ),
                                          child: Text(text,style: TextStyle(
                                            color: Colors.white
                                          ),),
                                        );
  }
}