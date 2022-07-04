import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:milonga/utils/appColors.dart';
import 'package:milonga/info.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.h),
              Image.asset('assets/icons/milonga_text.png'),
              Text(
                'LEARN & DANCE WITH YOUR PHONE',
                style: TextStyle(
                  letterSpacing: 1.5,
                  fontSize: 16.sp,
                  color: primaryTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 60.h),
              InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const InfoPage(),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.asset('assets/icons/milonga.png'),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      'INFO',
                      style: TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 20.sp,
                        color: primaryTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 60.h),
              Row(
                children: [
                  SizedBox(
                      height: 80,
                      width: 80,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.asset('assets/icons/lessons/level_1.png'),
                      )),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '1-12',
                        style: TextStyle(
                          letterSpacing: 1.5,
                          fontSize: 20.sp,
                          color: primaryTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'BASIC',
                        style: TextStyle(
                          letterSpacing: 1.5,
                          fontSize: 20.sp,
                          color: primaryTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Row(
                children: [
                  SizedBox(
                      height: 80,
                      width: 80,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.asset('assets/icons/lessons/level_2.png'),
                      )),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '1-12',
                        style: TextStyle(
                          letterSpacing: 1.5,
                          fontSize: 20.sp,
                          color: primaryTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'INTERMEDIATE',
                        style: TextStyle(
                          letterSpacing: 1.5,
                          fontSize: 20.sp,
                          color: primaryTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Row(
                children: [
                  SizedBox(
                      height: 80,
                      width: 80,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.asset('assets/icons/lessons/level_3.png'),
                      )),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '1-12',
                        style: TextStyle(
                          letterSpacing: 1.5,
                          fontSize: 20.sp,
                          color: primaryTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'ADVANCED',
                        style: TextStyle(
                          letterSpacing: 1.5,
                          fontSize: 20.sp,
                          color: primaryTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  Text(
                    '3  LEVELS - 36  LESSONS',
                    style: TextStyle(
                      letterSpacing: 1.5,
                      fontSize: 16.sp,
                      color: primaryTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '252  MOVES',
                    style: TextStyle(
                      letterSpacing: 1.5,
                      fontSize: 16.sp,
                      color: primaryTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h)
            ],
          ),
        ),
      ),
    );
  }
}
