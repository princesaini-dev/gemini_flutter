import 'package:flutter/material.dart';
import 'package:google_gemini_sample/presentation/utills/extentions.dart';

Widget bottomWidgetContainer(
    Function(String) onSendClick, Function(String) onUploadFileClick) {
  final TextEditingController messageEditController = TextEditingController();
  final myFocusNode = FocusNode();
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        child: Stack(
          children: [
            TextField(
              focusNode: myFocusNode,
              onSubmitted: (value) {
                onSendClick(messageEditController.text);
                messageEditController.clear();
                myFocusNode.requestFocus();
              },
              controller: messageEditController,
              decoration: InputDecoration(
                  hintText: 'Enter message',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12))),
            ),
            Positioned(
              right: 12,
              top: 0,
              bottom: 0,
              child: IconButton(
                  onPressed: () {
                    onSendClick(messageEditController.text);
                    messageEditController.clear();
                    myFocusNode.requestFocus();
                  },
                  icon: const Icon(Icons.send_rounded)),
            )
          ],
        ).paddingAll(18),
      ),
      SizedBox(
        width: 40,
        child: IconButton(
            onPressed: () {
              onUploadFileClick(messageEditController.text);
            },
            icon: const Icon(Icons.cloud_upload_outlined)),
      ),
      const SizedBox(
        width: 18,
      )
    ],
  );
}
