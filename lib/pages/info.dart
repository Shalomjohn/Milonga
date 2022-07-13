import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:milonga/pages/menu.dart';
import 'package:milonga/utils/appColors.dart';
import 'package:milonga/utils/social_share.dart';
import 'package:video_player/video_player.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late VideoPlayerController _controller;
  bool isMuted = true;
  bool showingPlayButton = false;

  void onPortraitScreenTouch({bool long = false}) {
    if (showingPlayButton) {
      setState(() {
        showingPlayButton = false;
      });
    } else {
      setState(() {
        showingPlayButton = true;
        _controller.value.isPlaying ? _controller.pause() : _controller.play();
      });
      Timer(
        Duration(milliseconds: long ? 800 : 300),
        (() => setState(() {
              showingPlayButton = false;
            })),
      );
    }
  }

  Widget roundedContainer(Widget icon) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: primaryTextColor, width: 2.w),
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: EdgeInsets.all(.5.w),
        child: icon,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/test_video.mp4')
      ..initialize().then((_) {
        _controller.setLooping(true);
        _controller.setVolume(0);
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    onPortraitScreenTouch(long: true);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/icons/sky_background.png',
                  fit: BoxFit.fill,
                ),
              ),
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      Stack(
                        children: [
                          InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 20.w),
                              child: Icon(
                                Icons.west,
                                size: 30.w,
                                color: primaryTextColor,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 35.h,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child:
                                  Image.asset('assets/icons/milonga_text.png'),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 15.w),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isMuted = !isMuted;
                                });
                                isMuted
                                    ? _controller.setVolume(0)
                                    : _controller.setVolume(1);
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
                      SizedBox(height: 15.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return IntrinsicHeight(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 30.w, vertical: 40.h),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Image.asset(
                                              'assets/icons/milonga.png',
                                              height: 70.w),
                                          SizedBox(height: 20.h),
                                          Text(
                                            'Subscribe to Milonga to gain access to all lessons and videos. Subscription is on a monthly basis and will cost \$X',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 18.sp),
                                          ),
                                          SizedBox(height: 20.h),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 20.h),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20.w),
                                                gradient: const LinearGradient(
                                                    colors: [
                                                      primaryTextColor,
                                                      primaryColor,
                                                      primaryTextColor
                                                    ],
                                                    begin: Alignment.bottomLeft,
                                                    end: Alignment.topRight),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 80.w,
                                                    vertical: 15.w),
                                                child: Text(
                                                  'Subscribe',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18.sp),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.w),
                              child: Icon(
                                Icons.add_shopping_cart,
                                color: primaryTextColor,
                                size: 45.w,
                              ),
                            ),
                          ),
                          SizedBox(width: 30.w),
                          InkWell(
                            onTap: () => showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return IntrinsicHeight(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 30.w, vertical: 40.h),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Share to:',
                                              style: TextStyle(fontSize: 18.sp),
                                            ),
                                          ),
                                          SizedBox(height: 20.h),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () => share(
                                                      SocialMedia.facebook),
                                                  child: Icon(
                                                    Icons.facebook,
                                                    size: 50.w,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => share(
                                                      SocialMedia.twitter),
                                                  child: Icon(
                                                    FontAwesomeIcons.twitter,
                                                    size: 50.w,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => share(
                                                      SocialMedia.whatsapp),
                                                  child: Icon(
                                                    Icons.whatsapp,
                                                    size: 50.w,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () =>
                                                      share(SocialMedia.email),
                                                  child: Icon(
                                                    Icons.email,
                                                    size: 50.w,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ])
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.w),
                              child: Icon(
                                Icons.share,
                                color: primaryTextColor,
                                size: 45.w,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      _controller.value.isInitialized
                          ? Stack(
                              children: [
                                AspectRatio(
                                  aspectRatio: _controller.value.aspectRatio,
                                  child: VideoPlayer(_controller),
                                ),
                                Positioned.fill(
                                  child: InkWell(
                                    onTap: () => onPortraitScreenTouch(),
                                    child: showingPlayButton
                                        ? SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: Icon(
                                              _controller.value.isPlaying
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
                          : Container(height: 300.h),
                      SizedBox(height: 15.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _controller.seekTo(const Duration(seconds: 0));
                            },
                            child: roundedContainer(
                              Icon(
                                Icons.play_arrow,
                                color: primaryTextColor,
                                size: 50.w,
                              ),
                            ),
                          ),
                          SizedBox(width: 40.w),
                          Icon(
                            Icons.copyright,
                            color: primaryTextColor,
                            size: 65.w,
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        'LEARN AND DANCE WITH YOUR PHONE',
                        style: TextStyle(
                          color: primaryTextColor,
                          fontSize: 18.sp,
                        ),
                      ),
                      Text(
                        'EVERYWHERE',
                        style: TextStyle(
                          color: primaryTextColor,
                          fontSize: 25.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const MenuPage()
        ],
      ),
    );
  }
}
