import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sibagjaapps/utils/WindowsButton/header.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({
    required this.navigationShell,
    Key? key,
  }) : super(key: key);

  final StatefulNavigationShell navigationShell;

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  bool isSidebarMinimized = true; // Flag to track sidebar state

  void toggleSidebar() {
    // setState(() {
    //   isSidebarMinimized = !isSidebarMinimized;
    // });
  }

  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        return ContainerTrue(context);
      }),
    );
  }

  Container ContainerTrue(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/v870-tang-36.jpg'),
              fit: BoxFit.fill)),
      child: Row(
        children: [
          // Sidebar
          AnimatedContainer(
            duration: Duration(milliseconds: 100),
            width: isSidebarMinimized
                ? 60
                : MediaQuery.of(context).size.width * 0.1,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(color: Colors.grey, blurRadius: 1, spreadRadius: 0.01)
              ],
              borderRadius: BorderRadius.circular(16),
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: toggleSidebar,
                  icon: Icon(LineIcons.leaf),
                ),
                Container(
                  padding: EdgeInsets.only(top: 8),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                        GestureDetector(
                            onTap: () {
                              context.pushNamed('Home');
                            },
                            child: Icon(LineIcons.home)),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                            onTap: () {
                              context.pushNamed('rekamMedis');
                            },
                            child: Icon(LineIcons.stethoscope)),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                            onTap: () {
                              context.pushNamed("keuangan");
                            },
                            child: Icon(LineIcons.wallet)),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                            onTap: () {
                              context.pushNamed("Patients");
                            },
                            child: Icon(LineIcons.userFriends)),
                    ],
                  ),
                )
              ],
            ),
          ),

          // Main content
          Expanded(
            child: Column(
              children: [
                HeadersWindows(),
                Expanded(
                  child: widget.navigationShell,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
