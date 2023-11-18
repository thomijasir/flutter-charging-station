import 'package:flutter/material.dart';
import 'package:sizer_pro/sizer.dart';
import 'package:flutter_charging_station/consts.dart';
import 'package:flutter_charging_station/models/bottom_nav.dart';

dynamic listMenu = List.generate(
    bottomNavIcons.length,
    (index) => GestureDetector(
          onTap: () {
            debugPrint("HELLO YES MAMEN");
          },
          child: Container(
            padding: const EdgeInsets.all(4),
            child: Icon(
              bottomNavIcons[index],
              color: index == 0 ? white : grey,
              size: 8.w,
            ),
          ),
        ));

class MenuComp extends StatelessWidget {
  const MenuComp({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: Padding(
        padding: EdgeInsets.only(bottom: 4.w, left: 4.w, right: 4.w),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.w),
          decoration: BoxDecoration(
              color: black, borderRadius: BorderRadius.circular(8.w)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: listMenu,
          ),
        ),
      ),
    );
  }
}
