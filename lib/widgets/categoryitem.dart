import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/theme.dart';
import 'dart:ui' as ui;

class CategoryItem extends StatelessWidget {
  String categoryImage;
  bool isRight;
  CategoryItem({required this.categoryImage, required this.isRight, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: isRight ? Alignment.bottomRight : Alignment.bottomLeft,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(24.r),
            child: Image.asset("assets/images/$categoryImage.png")),
        Container(
          margin: isRight
              ? const EdgeInsets.only(bottom: 16, right: 16)
              : EdgeInsets.only(bottom: 16, left: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(64.r),
              color: const Color(0xFFFFFFFF).withOpacity(0.50)),
          child: Directionality(
            textDirection: ui.TextDirection.ltr,
            child: Row(
                mainAxisSize: MainAxisSize.min,
                children: isRight
                    ? [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "view_all".tr(),
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        const CircleAvatar(
                          backgroundColor: MyThemeData.lightColor,
                          radius: 30,
                          child: Icon(Icons.arrow_forward_ios),
                        )
                      ]
                    : [
                        const CircleAvatar(
                          backgroundColor: MyThemeData.lightColor,
                          radius: 30,
                          child: Icon(Icons.arrow_back_ios),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            "view_all".tr(),
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ]),
          ),
        )
      ],
    );
    ;
  }
}
