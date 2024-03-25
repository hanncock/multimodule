// import 'package:ezenagents/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TxtBtn extends StatelessWidget {
  const TxtBtn({
    super.key,
    required this.pressed,
    required this.txt,
    this.width,
    this.padding,
  });
  final void Function() pressed;
  final String txt;
  final double? width;
  final double? padding;
  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      onPressed: pressed,
      style: FilledButton.styleFrom(
        // backgroundColor: lightColorScheme.primary,
        minimumSize: Size(width ?? .3.sw, 40.h),
        maximumSize: Size(width ?? .5.sw, 40.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
      ),
      child: Text(
        txt,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Colors.white),
      ),
    );
  }
}