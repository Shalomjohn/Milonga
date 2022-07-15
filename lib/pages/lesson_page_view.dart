import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:milonga/pages/lesson.dart';
import 'package:milonga/utils/components.dart';
import 'package:milonga/utils/thumbnail_maps.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../providers/lessons_manager.dart';

class LessonPageView extends StatefulWidget {
  const LessonPageView({Key? key, required this.lessonThumbnailPath})
      : super(key: key);
  final String lessonThumbnailPath;

  @override
  State<LessonPageView> createState() => _LessonPageViewState();
}

class _LessonPageViewState extends State<LessonPageView> {
  int currentPage = 0;
  List<Widget> children = [];
  late PageController pageController;
  String level = '';
  String lessonNumber = '';
  bool pageLoaded = false;
  String appDirPath = '';

  Map<String, List<String>> pagesMap = {};

  void setupPage() async {
    var appDir = await getApplicationDocumentsDirectory();
    appDirPath = appDir.path;
    lessonNumber =
        widget.lessonThumbnailPath.split('/').last.replaceAll('_icon.png', '');
    level = widget.lessonThumbnailPath.split('/')[3].toUpperCase();
    print(lessonThumbnailToURL[level.toLowerCase()]!.keys);
    for (var element in lessonThumbnailToURL[level.toLowerCase()]!.keys) {
      List<Map<String, String>> thumbnailVideosMap =
          lessonThumbnailToURL[level.toLowerCase()]![element]!;
      List<String> fileNames = [];
      for (var element in thumbnailVideosMap) {
        fileNames.add(element['fileName']!);
      }
      pagesMap[element] = fileNames;
    }
    currentPage = pagesMap.keys.toList().indexOf(widget.lessonThumbnailPath);
    pageController = PageController(initialPage: currentPage);
    pageLoaded = true;
    setState(() {});
  }

  @override
  void initState() {
    setupPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return pageLoaded
        ? Consumer<LessonsManager>(builder: (context, lessonsManager, child) {
            List<String> lessonsDownloaded = pagesMap.keys
                .where((element) =>
                    lessonsManager.lessonsDownloaded.contains(element))
                .toList();

            void gotoNextLesson() {
              if (currentPage != lessonsDownloaded.length - 1) {
                pageController.animateToPage(
                  currentPage + 1,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                );
              } else {
                customScaffoldMessage(
                    context, 'You have reached the last lesson');
              }
            }

            void gotoPreviousLesson() {
              if (currentPage != 0) {
                pageController.animateToPage(
                  currentPage - 1,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                );
              } else {
                customScaffoldMessage(
                    context, 'You have reached the first lesson');
              }
            }

            return PageView(
              onPageChanged: (value) => currentPage = value,
              controller: pageController,
              children: lessonsDownloaded
                  .map((e) => LessonPage(
                        nextLessonFunction: gotoNextLesson,
                        previousLessonFunction: gotoPreviousLesson,
                        fileNames: pagesMap[e]!,
                        appDirPath: appDirPath,
                        thumbnailPath: e,
                        isChecked: lessonsManager.lessonsCompleted.contains(e),
                      ))
                  .toList(),
            );
          })
        : const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
