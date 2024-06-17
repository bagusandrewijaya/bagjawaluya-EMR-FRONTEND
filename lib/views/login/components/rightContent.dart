
import 'package:flutter/material.dart';
import 'package:sibagjaapps/controllers/providers/P_AuthLoginProviders.dart';

class FormContent extends StatelessWidget {
  AuthLoginProviders provider;
   FormContent({
    super.key,
    required this.provider
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
                   color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16)),
            ),
                     
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 218, 218, 218).withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.height * 0.5,
          child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: provider.username,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0), // Adjust padding here
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: provider.password,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0), // Adjust padding here
                      ),
                    ),
                  SizedBox(height: 32),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: GestureDetector(
              onTap: ()async {
                  provider.login(context);
              },
              child: Container(
                  
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xff4793AF)
                  ),
              child: Align(
                alignment: Alignment.center,
                child: Text("MASUK",style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,fontWeight: FontWeight.bold
                ),),
              ),
              ),
                  )
                  ),
                ],
              )
        )
        
              ],
            ),
          ),
        );
  }
}