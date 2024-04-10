import 'package:flutter/material.dart';
import 'package:google_gemini_sample/presentation/utills/extentions.dart';

Widget bottomWidgetContainer(double screenWidth, Function(String) onSendClick,
    Function(String) onUploadFileClick) {
  final TextEditingController messageEditController = TextEditingController();
  final myFocusNode = FocusNode();
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        child: TextField(
          style: const TextStyle(color: Colors.black),
          focusNode: myFocusNode,
          onSubmitted: (value) {
            onSendClick(messageEditController.text);
            messageEditController.clear();
            myFocusNode.requestFocus();
          },
          cursorColor: Colors.black,
          controller: messageEditController,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.grey.shade200, width: 0.0),
                  borderRadius: BorderRadius.circular(25.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.grey.shade200, width: 0.0),
                  borderRadius: BorderRadius.circular(25.0)),
              hintText: 'Enter message',
              filled: true,
              fillColor: Colors.grey.shade200,
              suffixIcon: IconButton(
                  onPressed: () {
                    onSendClick(messageEditController.text);
                    messageEditController.clear();
                    myFocusNode.requestFocus();
                  },
                  icon: const Icon(Icons.send_rounded)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0))),
        ).paddingAll(18),
      ),
      // SizedBox(
      //   width: 40,
      //   child: IconButton(
      //       onPressed: () {
      //         onUploadFileClick(messageEditController.text);
      //       },
      //       icon: const Icon(Icons.cloud_upload_outlined)),
      // ),
      // const SizedBox(
      //   width: 18,
      // )
    ],
  ).paddingHorizontal(screenWidth * 0.18);
}
