import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:milonga/providers/lessons_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../utils/appColors.dart';

class LessonPage extends StatefulWidget {
  const LessonPage({
    Key? key,
    required this.fileNames,
    required this.appDirPath,
    required this.thumbnailPath,
    required this.isChecked,
    required this.previousLessonFunction,
    required this.nextLessonFunction,
  }) : super(key: key);
  final List<String> fileNames;
  final String appDirPath;
  final String thumbnailPath;
  final bool isChecked;
  final Function() previousLessonFunction;
  final Function() nextLessonFunction;

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  bool isLoaded = false;
  VideoPlayerController? _controller;
  bool isSlowed = false;
  bool isMuted = true;
  bool isChecked = false;
  late String appDirPath;
  int videoSelected = 0;
  String level = '';
  String lessonNumber = '';
  bool showingPlayButton = false;

  Widget roundedContainer(Widget icon, {double? width}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: primaryTextColor, width: width ?? 2.w),
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: EdgeInsets.all(.5.w),
        child: icon,
      ),
    );
  }

  void checkFunction() async {
    var lessonManager = Provider.of<LessonsManager>(context, listen: false);
    if (isChecked) {
      lessonManager.addToLessonsCompleted(widget.thumbnailPath);
    } else {
      lessonManager.removeFromLessonsCompleted(widget.thumbnailPath);
    }
  }

  void onPortraitScreenTouch({bool long = false}) {
    if (showingPlayButton) {
      setState(() {
        showingPlayButton = false;
      });
    } else {
      setState(() {
        showingPlayButton = true;
        _controller!.value.isPlaying
            ? _controller!.pause()
            : _controller!.play();
      });
      Timer(
        Duration(milliseconds: long ? 800 : 300),
        (() => setState(() {
              showingPlayButton = false;
            })),
      );
    }
  }

  void onLandscapeScreenTouch() {
    if (showingPlayButton) {
      setState(() {
        showingPlayButton = false;
      });
    } else {
      setState(() {
        showingPlayButton = true;
      });
      Timer(
        const Duration(seconds: 2),
        (() => setState(() {
              showingPlayButton = false;
            })),
      );
    }
  }

  @override
  void initState() {
    if (isLoaded == false) {
      String fileName = widget.fileNames[0];
      String videoPath = "${widget.appDirPath}/$fileName";
      isChecked = widget.isChecked;
      lessonNumber =
          widget.thumbnailPath.split('/').last.replaceAll('_icon.png', '');
      level = widget.thumbnailPath.split('/')[3].toUpperCase();
      _controller = VideoPlayerController.file(File(videoPath))
        ..initialize().then((_) {
          _controller!.setLooping(true);
          _controller!.setVolume(0);
          _controller!.play();
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });
      isLoaded = true;
      onPortraitScreenTouch(long: true);
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  Widget portraitView() {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Stack(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 5.w),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                isSlowed
                                    ? _controller!.setPlaybackSpeed(1)
                                    : _controller!.setPlaybackSpeed(0.5);
                                isSlowed = isSlowed ? false : true;
                              });
                            },
                            child: Stack(
                              children: [
                                Image.asset("assets/icons/snail_icon.png"),
                                if (isSlowed == false)
                                  Positioned.fill(
                                    child: Container(
                                      color: scaffoldColor.withOpacity(0.7),
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 15.w),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                isMuted = !isMuted;
                              });
                              isMuted
                                  ? _controller!.setVolume(0)
                                  : _controller!.setVolume(1);
                            },
                            child: Icon(
                              isMuted ? Icons.volume_off : Icons.volume_up,
                              size: 40.w,
                              color: primaryTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 10.w),
                          child: InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            child: Icon(
                              Icons.west,
                              size: 35.w,
                              color: primaryTextColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: InkWell(
                            onTap: () => setState(() {
                              isChecked = !isChecked;
                              checkFunction();
                            }),
                            child: Icon(
                              isChecked
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                              size: 35.w,
                              color: primaryTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Text(
                level,
                style: TextStyle(
                  fontSize: 20.sp,
                  color: primaryTextColor,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () => widget.previousLessonFunction(),
                      child: Icon(
                        Icons.west,
                        size: 35.w,
                        color: primaryTextColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Text(
                      lessonNumber,
                      style: TextStyle(
                        fontSize: 25.sp,
                        color: primaryTextColor,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () => widget.nextLessonFunction(),
                      child: Icon(
                        Icons.east,
                        size: 35.w,
                        color: primaryTextColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Center(
                child: _controller!.value.isInitialized
                    ? Stack(
                        children: [
                          AspectRatio(
                            aspectRatio: _controller!.value.aspectRatio,
                            child: VideoPlayer(_controller!),
                          ),
                          Positioned.fill(
                            child: InkWell(
                              onTap: () => onPortraitScreenTouch(),
                              child: showingPlayButton
                                  ? SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Icon(
                                        _controller!.value.isPlaying
                                            ? Icons.play_circle
                                            : Icons.pause_circle,
                                        size: 80.w,
                                        color: primaryTextColor,
                                      ),
                                    )
                                  : Container(),
                            ),
                          )
                        ],
                      )
                    : SizedBox(
                        height: 400.h,
                        width: double.infinity,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
              ),
              SizedBox(height: 20.h),
              Wrap(
                alignment: WrapAlignment.center,
                children: List.generate(
                  7,
                  (index) {
                    int innerIndex = index + 1;
                    return InkWell(
                      onTap: () {
                        String newFilePath =
                            "${widget.appDirPath}/${widget.fileNames[index]}";
                        print(newFilePath);
                        var newFile = File(newFilePath);
                        _controller!.dispose();
                        _controller = VideoPlayerController.file(newFile)
                          ..initialize().then((_) {
                            _controller!.setLooping(true);
                            if (isSlowed) {
                              _controller!.setPlaybackSpeed(0.5);
                            }
                            if (isMuted) {
                              _controller!.setVolume(0);
                            }
                            _controller!.play();
                            setState(() {
                              videoSelected = index;
                            });
                          });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 15.w),
                        child: roundedContainer(
                            Padding(
                              padding: EdgeInsets.all(20.w),
                              child: Text(
                                innerIndex.toString(),
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            width: videoSelected == index ? 4.w : null),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget landscapeView() {
    return Scaffold(
      body: Stack(
        children: [
          VideoPlayer(_controller!),
          Positioned.fill(
            child: InkWell(
              onTap: () => onLandscapeScreenTouch(),
              child: showingPlayButton
                  ? InkWell(
                      onTap: () => setState(() {
                        _controller!.value.isPlaying
                            ? _controller!.pause()
                            : _controller!.play();
                      }),
                      child: Icon(
                        _controller!.value.isPlaying
                            ? Icons.pause_circle
                            : Icons.play_circle,
                        size: 50.w,
                        color: primaryTextColor,
                      ),
                    )
                  : Container(),
            ),
          ),
          showingPlayButton
              ? Container(
                  alignment: Alignment.topRight,
                  color: scaffoldColor.withOpacity(0.6),
                  width: MediaQuery.of(context).size.width / 2.5,
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: List.generate(
                          7,
                          (index) {
                            int innerIndex = index + 1;
                            return InkWell(
                              onTap: () {
                                String newFilePath =
                                    "${widget.appDirPath}/${widget.fileNames[index]}";
                                print(newFilePath);
                                var newFile = File(newFilePath);
                                _controller!.dispose();
                                _controller =
                                    VideoPlayerController.file(newFile)
                                      ..initialize().then((_) {
                                        _controller!.setLooping(true);
                                        if (isSlowed) {
                                          _controller!.setPlaybackSpeed(0.5);
                                        }
                                        if (isMuted) {
                                          _controller!.setVolume(0);
                                        }
                                        _controller!.play();
                                        setState(() {
                                          videoSelected = index;
                                        });
                                      });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 10.w),
                                child: roundedContainer(
                                    Padding(
                                      padding: EdgeInsets.all(8.w),
                                      child: Text(
                                        innerIndex.toString(),
                                        style: TextStyle(
                                          fontSize: 60.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    width:
                                        videoSelected == index ? 3.w : 1.5.w),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 45.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 5.w),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isSlowed
                                      ? _controller!.setPlaybackSpeed(1)
                                      : _controller!.setPlaybackSpeed(0.5);
                                  isSlowed = isSlowed ? false : true;
                                });
                              },
                              child: Stack(
                                children: [
                                  Image.asset("assets/icons/snail_icon.png",
                                      width: 100.h),
                                  if (isSlowed == false)
                                    Positioned.fill(
                                      child: Container(
                                        color: scaffoldColor.withOpacity(0.7),
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 5.w),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isMuted = !isMuted;
                                });
                                isMuted
                                    ? _controller!.setVolume(0)
                                    : _controller!.setVolume(1);
                              },
                              child: Icon(
                                isMuted ? Icons.volume_off : Icons.volume_up,
                                size: 30.w,
                                color: primaryTextColor,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded
        ? OrientationBuilder(builder: (context, orientation) {
            return orientation == Orientation.portrait
                ? portraitView()
                : landscapeView();
          })
        : const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
  }
}
