import 'package:flutter/material.dart';
import 'package:google_gemini_sample/presentation/resources/animation_manager.dart';
import 'package:google_gemini_sample/presentation/utills/app_conponents.dart';
import 'package:google_gemini_sample/presentation/utills/style/gradient_text.dart';
import 'package:lottie/lottie.dart';

class EmptyDataView extends StatelessWidget {
  const EmptyDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: getScreenHeight(context) * 0.5,
            child: Lottie.asset(AnimationManager.emptyDataAnimation),
          ),
          GradientText(
            'No Data Found',
            gradient: LinearGradient(colors: [
              Colors.grey.shade400,
              Colors.grey.shade600,
              Colors.grey.shade400,
              Colors.grey.shade600,
            ]),
            style: const TextStyle(
                color: Colors.blue, fontWeight: FontWeight.w800, fontSize: 18),
          )
        ],
      ),
    );
  }
}
