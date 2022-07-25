import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:milonga/pages/menu.dart';
import 'package:milonga/utils/appColors.dart';
import 'package:milonga/utils/components.dart';
import 'package:share_plus/share_plus.dart';
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
  bool subscriptionIsMonthly = true;

  // for flashings
  bool flashPurchase = false;
  bool flashShare = false;
  bool flashCredits = false;
  bool flashRestart = false;

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

  void playRestartFunction() {
    setState(() {
      flashRestart = true;
    });
    _controller.seekTo(const Duration(seconds: 0));
    if (_controller.value.isPlaying == false) {
      _controller.play();
    }
    Timer(const Duration(milliseconds: 300), () {
      setState(() {
        flashRestart = false;
      });
    });
  }

  void creditsFunction() {
    setState(() {
      flashCredits = true;
    });
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.w),
          topRight: Radius.circular(10.w),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return creditsWidget();
      },
    ).whenComplete(
      () => setState(() {
        flashCredits = false;
      }),
    );
  }

  void shareFunction() {
    setState(() {
      flashShare = true;
    });
    Share.share(
        'Milonga helps you to learn how to dance using your phone. Download now!\nhttps://example.com',
        subject: 'Introducing Milonga');
    Timer(const Duration(milliseconds: 300), () {
      setState(() {
        flashShare = false;
      });
    });
  }

  void purchaseFunction() {
    setState(() {
      flashPurchase = true;
    });
    showPurchasePopup(context);
    Timer(const Duration(milliseconds: 300), () {
      setState(() {
        flashPurchase = false;
      });
    });
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

  Widget creditsWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.w),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 40.h),
              Text(
                'CREDITS',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                'CREATED and PRODUCED',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 20.sp,
                ),
              ),
              Text(
                'CONCEPT, FILMING, DESING,',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 20.sp,
                ),
              ),
              Text(
                'AUDIO and VIDEO EDITING',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 20.sp,
                ),
              ),
              Text(
                'Henryk Gajewski',
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                'LESSONS & DANCING',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 20.sp,
                ),
              ),
              Text(
                'Arjan Sikking & Marianne van Berlo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                'ORIGINAL MUSIC',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 20.sp,
                ),
              ),
              Text(
                'COMPOSED & PERFORMED',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 20.sp,
                ),
              ),
              Text(
                'Carel Kraayenhof',
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                'FLUTTER APP CODING',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 20.sp,
                ),
              ),
              Text(
                'Remco Tevreden',
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                'iOS PROTOTYPE CODING',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 20.sp,
                ),
              ),
              Text(
                'Marcin Kowalczyk',
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                'LOGO DESIGN',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 20.sp,
                ),
              ),
              Text(
                'Wytske Wits',
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                'INFO VIDEO APPEARANCE',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 20.sp,
                ),
              ),
              Text(
                'Batoul Lakmoush',
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              Text(
                'Wouter Bording',
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                'SPECIAL THANKS',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 20.sp,
                ),
              ),
              Text(
                'Arjan Sikking',
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              Text(
                'Wytske Wits',
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              Text(
                'Marcin Gajewski',
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                'COPYRIGHTS',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 20.sp,
                ),
              ),
              Text(
                '© Henryk Gajewski, Since 2014',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/info_video.mp4')
      ..initialize().then((_) {
        _controller.setLooping(true);
        _controller.setVolume(0);
        _controller.play();
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
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.asset(
                    'assets/icons/sky_background.png',
                    fit: BoxFit.fill,
                  ),
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
                                padding: EdgeInsets.only(left: 20.w, top: 5.h),
                                child: Image.asset('assets/icons/arrowback.png',
                                    height: 35.h)),
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
                              child: isMuted
                                  ? Image.asset('assets/icons/audio.png',
                                      height: 35.h)
                                  : Image.asset('assets/icons/audioON.png',
                                      height: 35.h),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        "INFO",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: primaryTextColor,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => playRestartFunction(),
                            child: Image.asset(
                                flashRestart
                                    ? 'assets/icons/play_inactive.png'
                                    : 'assets/icons/play_active.png',
                                height: 45.h),
                          ),
                          SizedBox(width: 30.w),
                          InkWell(
                            onTap: () => purchaseFunction(),
                            child: Padding(
                              padding: EdgeInsets.all(8.w),
                              child: Image.asset(
                                  flashPurchase
                                      ? 'assets/icons/purchaseON.png'
                                      : 'assets/icons/purchase.png',
                                  height: 45.h),
                            ),
                          ),
                          SizedBox(width: 30.w),
                          InkWell(
                            onTap: () => shareFunction(),
                            child: Padding(
                              padding: EdgeInsets.all(8.w),
                              child: Image.asset(
                                  flashShare
                                      ? 'assets/icons/shareON.png'
                                      : 'assets/icons/share.png',
                                  height: 45.h),
                            ),
                          ),
                          SizedBox(width: 30.w),
                          InkWell(
                            onTap: () => creditsFunction(),
                            child: Image.asset(
                                flashCredits
                                    ? 'assets/icons/creditsON.png'
                                    : 'assets/icons/credits.png',
                                height: 45.h),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
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
                      SizedBox(height: 20.h),
                      Text(
                        'DANCE WITH YOUR PHONE',
                        style: TextStyle(
                          color: primaryTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.sp,
                        ),
                      ),
                      Text(
                        'EVERYWHERE',
                        style: TextStyle(
                          color: primaryTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 50.sp,
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
