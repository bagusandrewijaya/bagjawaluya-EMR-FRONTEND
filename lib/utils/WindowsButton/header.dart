import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sibagjaapps/utils/WindowsButton/windowsbutton.dart';

class HeadersWindows extends StatefulWidget {
  const HeadersWindows({super.key});

  @override
  State<HeadersWindows> createState() => _HeadersWindowsState();
}

class _HeadersWindowsState extends State<HeadersWindows> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if(!kIsWeb) 
          WindowTitleBarBox(
            child: Row(
              children: [Expanded(child: MoveWindow()), const WindowButtons()],
            ),
          )
        ]);
  }
}