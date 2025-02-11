import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/resources/images.dart';

class LoaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      child: SizedBox(
        width: context.width(),
        height: context.height(),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4, tileMode: TileMode.repeated),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
            ),
            child: Image.asset(
              ic_loading_gif,
              fit: BoxFit.contain,
              height: 80,
              width: 80,
            ).center(),
          ),
        ),
      ),
    );
  }
}
