import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FlashingButton extends StatefulWidget {
  const FlashingButton(
      {Key? key, required this.onTap, required this.iconPath, this.iconHeight})
      : super(key: key);
  final Function() onTap;
  final String iconPath;
  final double? iconHeight;

  @override
  State<FlashingButton> createState() => _FlashingButtonState();
}

class _FlashingButtonState extends State<FlashingButton> {
  bool flashButton = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          flashButton = true;
        });
        Timer(
          const Duration(milliseconds: 50),
          (() {
            setState(() {
              flashButton = false;
            });
            widget.onTap();
          }),
        );
      },
      child: Container(
        decoration: flashButton
            ? BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    spreadRadius: 0,
                    blurRadius: 20.w,
                    // offset: Offset(
                    //     0, 7), // changes position of shadow
                  ),
                ],
              )
            : null,
        child: Image.asset(widget.iconPath, height: widget.iconHeight ?? 45.h),
      ),
    );
  }
}
