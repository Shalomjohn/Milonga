import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:milonga/pages/lesson.dart';
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
    int initialPage =
        pagesMap.keys.toList().indexOf(widget.lessonThumbnailPath);
    pageController = PageController(initialPage: initialPage);
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
            return PageView(
              controller: pageController,
              children: pagesMap.keys
                  .where((element) =>
                      lessonsManager.lessonsDownloaded.contains(element))
                  .map((e) => LessonPage(
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
