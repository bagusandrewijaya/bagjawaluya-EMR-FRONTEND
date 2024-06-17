import 'package:flutter/material.dart';

class RefreshButton extends StatefulWidget {

  final Function() fetchData;

  RefreshButton({required this.fetchData});

  @override
  _RefreshButtonState createState() => _RefreshButtonState();
}

class _RefreshButtonState extends State<RefreshButton> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isTapped = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isTapped = false;
        });
        widget.fetchData();
      },
      onTapCancel: () {
        setState(() {
          _isTapped = false;
        });
      },
      child: AnimatedScale(
        scale: _isTapped ? 1.2 : 1.0,
        duration: Duration(milliseconds: 200),
        child: Container(
          width: 50,
          height: 40,
          child: Icon(
            Icons.refresh,
            size: 30,
          ),
        ),
      ),
    );
  }
}
