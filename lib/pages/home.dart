import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:milonga/pages/menu.dart';
import 'package:milonga/utils/appColors.dart';
import 'package:milonga/pages/info.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void didChangeDependencies() {
    precacheImage(const AssetImage('assets/icons/purchaseON.png'), context);
    precacheImage(const AssetImage('assets/icons/shareON.png'), context);
    precacheImage(const AssetImage('assets/icons/creditsON.png'), context);
    precacheImage(const AssetImage('assets/icons/play_active.png'), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image.asset(
                'assets/icons/background_image.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 20.h),
                  Image.asset(
                    'assets/icons/milonga_text.png',
                    height: 60.h,
                  ),
                  SizedBox(height: 10.h),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'LEARN & DANCE WITH YOUR PHONE',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        // letterSpacing: 1.5,
                        fontSize: 18.sp,
                        color: primaryTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const InfoPage(),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 80.w,
                          width: 80.w,
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
                  SizedBox(height: 50.h),
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MenuPage(),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                            height: 80.w,
                            width: 80.w,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Image.asset(
                                  'assets/icons/lessons/level_1.png'),
                            )),
                        SizedBox(width: 10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'BASIC',
                              style: TextStyle(
                                letterSpacing: 1.5,
                                fontSize: 20.sp,
                                color: primaryTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '1-12',
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
                  ),
                  SizedBox(height: 20.h),
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MenuPage(level: 1),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                            height: 80.w,
                            width: 80.w,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Image.asset(
                                  'assets/icons/lessons/level_2.png'),
                            )),
                        SizedBox(width: 10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'INTERMEDIATE',
                              style: TextStyle(
                                letterSpacing: 1.5,
                                fontSize: 20.sp,
                                color: primaryTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '13-24',
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
                  ),
                  SizedBox(height: 20.h),
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MenuPage(level: 2),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                            height: 80.w,
                            width: 80.w,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Image.asset(
                                  'assets/icons/lessons/level_3.png'),
                            )),
                        SizedBox(width: 10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ADVANCED',
                              style: TextStyle(
                                letterSpacing: 1.5,
                                fontSize: 20.sp,
                                color: primaryTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '25-36',
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
                  ),
                  SizedBox(height: 50.h),
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
        ],
      ),
    );
  }
}
