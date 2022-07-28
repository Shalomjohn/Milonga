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
        minTextAdapt: true,
        designSize: const Size(414, 869),
        builder: (context, child) {
          return ChangeNotifierProvider<LessonsManager>(
            create: (context) => LessonsManager(),
            child: MaterialApp(
              title: 'Milonga',
              theme: ThemeData(
                fontFamily: "Campton",
                primarySwatch: Colors.blueGrey,
                scaffoldBackgroundColor: scaffoldColor,
              ),
              home: const MyHomePage(title: 'Milonga'),
            ),
          );
        });
  }
}
