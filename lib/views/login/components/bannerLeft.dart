
import 'package:flutter/material.dart';

class BannerLeft extends StatelessWidget {
  const BannerLeft({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
       
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16)),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                    'assets/images/frame-medical-equipment-desk.jpg'))),
        child:Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          bottomLeft: Radius.circular(16)
        ),
        gradient: SweepGradient(
              colors: [Color(0xff4793AF), Colors.white.withOpacity(0.1)],
              stops: [0.25, 0.75],
              center: Alignment(0.9, 1.0),
            )
            
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "MEDICAL RECORD",
                style: TextStyle(
    color: Colors.white,
    fontSize: 32,fontWeight: FontWeight.bold
                ),
              ),
              Text(
                "BAGJA WALUYA"
                ,style:  TextStyle(
    color: Colors.white,
    fontSize: 24,fontWeight: FontWeight.bold
                )
    
              ),
            SizedBox(height: 16,)
            ],
    
          )
        ],
      ),
    )
    
    ,
      ),
    );
  }
}
