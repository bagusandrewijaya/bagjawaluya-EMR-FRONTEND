import 'dart:io';
import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart'; // Import bitsdojo_window package
import 'package:provider/provider.dart';
import 'package:sibagjaapps/controllers/providers/P_HakAkses.dart';
import 'package:sibagjaapps/fluentLocale.dart';

import 'package:sibagjaapps/utils/navigation/main_navigation.dart';
import 'package:window_size/window_size.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); 
runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MyApp(),
    ),
  );

  // Enable desktop window features
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    doWhenWindowReady(() {
      final initialSize =  Size(1250, 720);
      appWindow.minSize = const  Size(1250, 720);
      appWindow.size = initialSize;
      appWindow.alignment = Alignment.center;
      appWindow.title = "Electronic Medical Record";
      appWindow.show();
    });
  }
}

final _appTheme = AppTheme();
class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _appTheme,
    
      builder: (context, child) {
        final appTheme = context.watch<AppTheme>();
        return FluentApp(
          title: 'Bagja Waluya',
          debugShowCheckedModeBanner: false,
          themeMode: appTheme.mode,
          locale: appTheme.locale,
          home: MaterialApp(
              debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: GoogleFonts.poppinsTextTheme()
            ),
            home: FluentApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: AppNavigation.router,
            ),
          ),
        
        );
      }
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => { 
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    // etc.
  };
}