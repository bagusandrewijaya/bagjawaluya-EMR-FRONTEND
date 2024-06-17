import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sibagjaapps/controllers/apiservices/S_AuthLoginApiService.dart';
import 'package:sibagjaapps/controllers/providers/P_AuthLoginProviders.dart';
import 'package:sibagjaapps/utils/WindowsButton/header.dart';
import 'package:sibagjaapps/views/login/components/bannerLeft.dart';
import 'package:sibagjaapps/views/login/components/rightContent.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginScreens extends StatefulWidget {
  const LoginScreens({Key? key}) : super(key: key);

  @override
  State<LoginScreens> createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthLoginProviders>(
      create: (context) => AuthLoginProviders(),
      child: Consumer<AuthLoginProviders>(
        builder: (context, provider, _) {
          return BlurryModalProgressHUD(
            inAsyncCall: provider.loading,
            progressIndicator: SpinKitFadingCircle(
              color: Color(0xff4793AF),
              size: 90.0,
            ),
            child: Scaffold(
              body: Column(
                children: [
                   HeadersWindows(), 
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 128, vertical: 64),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0.3,
                              blurRadius: 5,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            BannerLeft(),
                           FormContent(provider: provider,),
                         
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
