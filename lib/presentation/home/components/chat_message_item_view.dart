import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_gemini_sample/data/model/chat_data_model.dart';
import 'package:google_gemini_sample/presentation/utills/extentions.dart';

Widget chatMessageItemView(ChatDataModel chatData) {
  return chatData.senderType == SenderType.user
      ? chatMessageUserView(chatData)
      : chatMessageRemoteView(chatData);
}

Widget chatMessageUserView(ChatDataModel chatData) {
  return Align(
    alignment: Alignment.centerRight, // Align the message to the right
    child: IntrinsicWidth(
      child: Card(
        child: chatData.messageType == MessageType.text
            ? Text(chatData.message).paddingAll(12)
            : SizedBox(
                height: 100,
                child: Image.network(chatData.file ?? ''),
              ),
      ).paddingLeft(60),
    ),
  ).paddingAll(12);
}

Widget chatMessageRemoteView(ChatDataModel chatData) {
  return Align(
    alignment: Alignment.centerLeft, // Align the message to the right
    child: IntrinsicWidth(
      child: Card(
        child: Text(chatData.message).paddingAll(12),
      ).paddingRight(60),
    ),
  ).paddingAll(12);
}
