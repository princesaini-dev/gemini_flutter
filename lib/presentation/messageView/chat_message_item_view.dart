import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_gemini_sample/data/model/chat_data_model.dart';
import 'package:google_gemini_sample/presentation/resources/assets_manager.dart';
import 'package:google_gemini_sample/presentation/utills/extentions.dart';
import 'package:loading_indicator/loading_indicator.dart';

Widget chatMessageItemView(ChatDataModel chatData) {
  return chatData.senderType == SenderType.user
      ? chatMessageUserView(chatData)
      : chatData.messageType == MessageType.loading
          ? chatMessageLoadingView(chatData)
          : chatMessageRemoteView(chatData);
}

Widget chatMessageUserView(ChatDataModel chatData) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
          height: 32,
          width: 32,
          child: Image.asset(AssetsManager.imageUserProfile)),
      Flexible(
        child: Text(
          chatData.message,
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ).paddingLeft(16).paddingTop(8),
      ),
    ],
  ).paddingBottom(18);
}

Widget chatMessageRemoteView(ChatDataModel chatData) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
          height: 34,
          width: 34,
          child: Image.asset(AssetsManager.imageLogoAI)),
      Flexible(
        child: Text(
          chatData.message,
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ).paddingLeft(16).paddingTop(5),
      ),
    ],
  ).paddingBottom(18);
}

Widget chatMessageLoadingView(ChatDataModel chatData) {
  return SizedBox(
    width: 150,
    height: 10,
    child: const LoadingIndicator(
            indicatorType: Indicator.ballPulse,
            colors: [Colors.blue],
            strokeWidth: 1,
            backgroundColor: Colors.transparent,
            pathBackgroundColor: Colors.black)
        .paddingHorizontal(30),
  ).paddingAll(16).paddingRight(80).paddingAll(12);
}
