import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesap_makinesi/colors/app_colors.dart';
import 'package:expressions/expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List<dynamic> process = [];
bool firstRun = true;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        color: AppColors.backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: ScreenUtil().screenWidth,
              height: 250.h,
              color: AppColors.backgroundColor,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Text(
                    firstRun ? "0" : process.join(),
                    style:
                        TextStyle(color: AppColors.textColor, fontSize: 55.sp),
                  ),
                ),
              ),
            ),
            Flexible(
              child: Row(
                children: [
                  Flexible(child: widgetFunction("AC")),
                  Flexible(child: widgetFunction("+/-")),
                  Flexible(child: widgetFunction("%")),
                  Flexible(child: widgetFunction("÷", orange: true)),
                ],
              ),
            ),
            Flexible(
              child: Row(
                children: [
                  Flexible(child: widgetFunction("7")),
                  Flexible(child: widgetFunction("8")),
                  Flexible(child: widgetFunction("9")),
                  Flexible(child: widgetFunction("x", orange: true)),
                ],
              ),
            ),
            Flexible(
              child: Row(
                children: [
                  Flexible(child: widgetFunction("4")),
                  Flexible(child: widgetFunction("5")),
                  Flexible(child: widgetFunction("6")),
                  Flexible(child: widgetFunction("—", orange: true)),
                ],
              ),
            ),
            Flexible(
              child: Row(
                children: [
                  Flexible(child: widgetFunction("1")),
                  Flexible(child: widgetFunction("2")),
                  Flexible(child: widgetFunction("3")),
                  Flexible(child: widgetFunction("+", orange: true)),
                ],
              ),
            ),
            Flexible(
              child: Row(
                children: [
                  Flexible(flex: 2, child: widgetFunction("0")),
                  Flexible(child: widgetFunction(",")),
                  Flexible(child: widgetFunction("=", orange: true)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell widgetFunction(String text, {bool? orange}) {
    Color backgroundColor;
    double size;
    if (orange == true) {
      backgroundColor = AppColors.processColor;
      size = 50;
    } else {
      backgroundColor = AppColors.primaryColor;
      size = 35;
    }
    return InkWell(
      onTap: () {
        setState(() {
          if (firstRun == true) {
            firstRun = false;
          }
          if (text == "AC") {
            process.clear();
            firstRun = true;
          } else if (text == "=") {
            evaluateExpression();
          } else if (text == ",") {
            process.add(".");
          } else {
            process.add(text);
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 0.7), color: backgroundColor),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: AppColors.textColor, fontSize: size.sp),
          ),
        ),
      ),
    );
  }

  void evaluateExpression() {
    try {
      String expression = process
          .join()
          .replaceAll('x', '*')
          .replaceAll('÷', '/')
          .replaceAll('—', '-');
      final evaluator = const ExpressionEvaluator();
      final exp = Expression.parse(expression);
      final result = evaluator.eval(exp, {});
      process = [result.toString()];
    } catch (e) {
      process = ["Error"];
    }
  }
}
