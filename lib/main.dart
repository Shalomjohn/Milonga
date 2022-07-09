import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:milonga/providers/lessons_manager.dart';
import 'package:milonga/utils/appColors.dart';
import 'package:milonga/pages/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(392, 781),
        builder: (context, child) {
          return ChangeNotifierProvider<LessonsManager>(
            create: (context) => LessonsManager(),
            child: MaterialApp(
              title: 'Dance App',
              theme: ThemeData(
                primarySwatch: Colors.blueGrey,
                scaffoldBackgroundColor: scaffoldColor,
              ),
              home: const MyHomePage(title: 'Dance App'),
            ),
          );
        });
  }
}
