import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_gemini_sample/data/model/chat_data_model.dart';
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
  return Align(
    alignment: Alignment.centerRight, // Align the message to the right
    child: IntrinsicWidth(
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        color: Colors.blueAccent,
        child: chatData.messageType == MessageType.text
            ? Text(
                chatData.message,
                style: const TextStyle(color: Colors.white),
              ).paddingAll(12)
            : SizedBox(
                height: 100,
                child: Image.network(chatData.file ?? ''),
              ),
      ).paddingLeft(80),
    ),
  ).paddingAll(12);
}

Widget chatMessageRemoteView(ChatDataModel chatData) {
  return Align(
    alignment: Alignment.centerLeft, // Align the message to the right
    child: IntrinsicWidth(
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        color: Colors.grey.shade100,
        child:
            Text(chatData.message, style: const TextStyle(color: Colors.black))
                .paddingAll(12),
      ).paddingRight(80),
    ),
  ).paddingAll(12);
}

Widget chatMessageLoadingView(ChatDataModel chatData) {
  return Align(
    alignment: Alignment.centerLeft, // Align the message to the right
    child: IntrinsicWidth(
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        color: Colors.grey.shade100,
        child: SizedBox(
          width: 150,
          height: 10,
          child: const LoadingIndicator(
              indicatorType: Indicator.ballPulse,
              colors: [Colors.blue],
              strokeWidth: 1,
              backgroundColor: Colors.transparent,
              pathBackgroundColor: Colors.black).paddingHorizontal(30),
        ).paddingAll(16),
      ).paddingRight(80),
    ),
  ).paddingAll(12);
}
