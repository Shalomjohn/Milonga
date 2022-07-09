import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:milonga/pages/lesson.dart';
import 'package:milonga/providers/downloads.dart';
import 'package:milonga/utils/file_downloader.dart';
import 'package:milonga/utils/thumbnail_maps.dart';
import 'package:path_provider/path_provider.dart';

import '../utils/appColors.dart';
import 'info.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key, this.level = 0}) : super(key: key);
  final int level;

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  Map<String, bool> isClickedMap = {};
  Map<String, double> downloadingMap = {};
  Map<String, String> vidToPathMap = {};
  Map<String, int> thumbnailToVideosGottenMap = {};
  PageController? pageController;
  int currentPage = 0;
  Directory? appDir;

  Widget childWithThumbnail(int index, Color levelColor, String levelName) {
    String thumbnailAssetName =
        "assets/icons/lessons/${levelName.toLowerCase()}/${index}_icon.png";
    if (isClickedMap.keys.contains(thumbnailAssetName) == false) {
      isClickedMap[thumbnailAssetName] = false;
      downloadingMap[thumbnailAssetName] = 0;
      thumbnailToVideosGottenMap[thumbnailAssetName] = 0;
    }
    return InkWell(
      onTap: () async {
        if (downloadingMap[thumbnailAssetName] == 1) {
          setState(() {
            isClickedMap[thumbnailAssetName] = true;
          });
          Timer(
            const Duration(milliseconds: 200),
            () {
              setState(() {
                isClickedMap[thumbnailAssetName] = false;
              });
              List<Map<String, String>> thumbnailVideosMap =
                  lessonThumbnailToURL[thumbnailAssetName]!;
              List<String> fileNames = [];
              for (var element in thumbnailVideosMap) {
                fileNames.add(element['fileName']!);
              }
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => LessonPage(
                      fileNames: fileNames, appDirPath: appDir!.path),
                ),
              );
            },
          );
        } else {
          setState(() {
            downloadingMap[thumbnailAssetName] = 0.0000001;
          });
          void downloadProgress(int sent, int total) {
            double result = (sent / total);
            setState(() {
              downloadingMap[thumbnailAssetName] = result;
            });
            print("$sent $total");
          }

          Future downloadLevelVideos(String url, String fileName) async {
            Dio dio = Dio();
            CancelToken cancelToken = CancelToken();
            appDir = await getApplicationDocumentsDirectory();
            String fullPath = "${appDir!.path}/$fileName";
            print('full path $fullPath');
            await downloadFile(dio, url, fullPath, downloadProgress);
          }

          List<Map<String, String>> urlList =
              lessonThumbnailToURL[thumbnailAssetName]!;
          for (var element in urlList) {
            await downloadLevelVideos(element['url']!, element['fileName']!);
            thumbnailToVideosGottenMap[thumbnailAssetName] =
                thumbnailToVideosGottenMap[thumbnailAssetName]! + 1;
          }
        }
      },
      child: SizedBox(
        height: 135.w,
        width: 100.w,
        child: Stack(
          children: [
            Image.asset(thumbnailAssetName),
            isClickedMap[thumbnailAssetName]!
                ? Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.w),
                        color: levelColor.withOpacity(
                            isClickedMap[thumbnailAssetName]! ? 0.5 : 0),
                      ),
                      child: Icon(
                        Icons.done,
                        color: Colors.white,
                        size: 40.w,
                      ),
                    ),
                  )
                : Container(),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.w),
                  color: levelColor.withOpacity(
                      thumbnailToVideosGottenMap[thumbnailAssetName] != 7
                          ? 0.5
                          : 0),
                ),
              ),
            ),
            if (downloadingMap[thumbnailAssetName] != 0 &&
                thumbnailToVideosGottenMap[thumbnailAssetName] != 7)
              Positioned.fill(
                top: 100.h,
                child: Container(
                    color: primaryColor,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(bottom: 5.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Fetched (${thumbnailToVideosGottenMap[thumbnailAssetName]!}/7)',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: LinearProgressIndicator(
                              minHeight: 10.h,
                              color: primaryTextColor,
                              backgroundColor: primaryColor,
                              value: downloadingMap[thumbnailAssetName]!,
                            ),
                          ),
                        )
                      ],
                    )),
              ),
          ],
        ),
      ),
    );
  }

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
      if (levelName == 'BASIC' && index < 4 && index != 1) {
        child = childWithThumbnail(index, levelColor, levelName);
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
