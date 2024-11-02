import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesap_makinesi/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(411.42857142857144, 866.2857142857143));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: HomePage()),
    );
  }
}
