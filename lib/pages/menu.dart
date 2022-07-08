import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/appColors.dart';
import 'info.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key, this.level = 0}) : super(key: key);
  final int level;

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  PageController? pageController;
  int currentPage = 0;
  Widget menuPage(int level) {
    String levelName = '';
    Color levelColor = levelOneColor;
    switch (level) {
      case 0:
        levelName = 'BASIC';
        levelColor = levelOneColor;
        break;
      case 1:
        levelName = 'INTERMEDIATE';
        levelColor = levelTwoColor;
        break;
      case 2:
        levelName = 'ADVANCED';
        levelColor = levelThreeColor;
        break;
    }
    Widget menuItem(int index) {
      Widget child = Column(
        children: [
          Container(
            height: 100.w,
            width: 100.w,
            decoration: BoxDecoration(
              color: primaryTextColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.w),
                topRight: Radius.circular(5.w),
              ),
            ),
            child: Icon(
              Icons.lock,
              size: 40.w,
              color: Colors.black54,
            ),
          ),
          Container(
            height: 35.h,
            width: 100.w,
            decoration: BoxDecoration(
              color: levelColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5.w),
                bottomRight: Radius.circular(5.w),
              ),
            ),
            child: Center(
              child: Text(
                index.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.sp,
                ),
              ),
            ),
          ),
        ],
      );
      if (levelName == 'BASIC' && index < 4) {
        String thumbnailAssetName =
            "assets/icons/lessons/basic/${index + 1}_icon.png";
        child = SizedBox(
          height: 135.w,
          width: 100.w,
          child: Image.asset(thumbnailAssetName),
        );
      }
      return child;
    }

    return Column(
      children: [
        Text(
          levelName,
          style: TextStyle(fontSize: 20.sp, color: primaryTextColor),
        ),
        SizedBox(height: 15.h),
        Wrap(
          spacing: 15.w,
          runSpacing: 15.h,
          children: List.generate(12, (index) => menuItem(index + 1)),
        )
      ],
    );
  }

  @override
  void initState() {
    pageController = PageController(initialPage: widget.level);
    currentPage = widget.level;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Stack(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20.w),
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(
                      Icons.west,
                      size: 30.w,
                      color: primaryTextColor,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 25.h,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image.asset('assets/icons/milonga_text.png'),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 20.w),
                  height: 25.h,
                  child: InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const InfoPage(),
                      ),
                    ),
                    child: Image.asset('assets/icons/info_active.png'),
                  ),
                ),
              ],
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (pageIndex) {
                  setState(() {
                    currentPage = pageIndex;
                  });
                },
                children: [
                  menuPage(0),
                  menuPage(1),
                  menuPage(2),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    if (currentPage != 0) {
                      pageController!.animateToPage(0,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeIn);
                    }
                  },
                  child: Icon(
                    Icons.circle,
                    color: currentPage == 0 ? Colors.white : Colors.grey,
                    size: 18.w,
                  ),
                ),
                SizedBox(width: 5.w),
                InkWell(
                  onTap: () {
                    if (currentPage != 1) {
                      pageController!.animateToPage(1,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeIn);
                    }
                  },
                  child: Icon(
                    Icons.circle,
                    color: currentPage == 1 ? Colors.white : Colors.grey,
                    size: 18.w,
                  ),
                ),
                SizedBox(width: 5.w),
                InkWell(
                  onTap: () {
                    if (currentPage != 2) {
                      pageController!.animateToPage(2,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeIn);
                    }
                  },
                  child: Icon(
                    Icons.circle,
                    color: currentPage == 2 ? Colors.white : Colors.grey,
                    size: 18.w,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h)
          ],
        ),
      ),
    );
  }
}
