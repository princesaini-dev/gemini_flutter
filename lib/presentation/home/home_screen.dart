import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:google_gemini_sample/data/block/chat_list_block.dart';
import 'package:google_gemini_sample/data/block/chat_list_event.dart';
import 'package:google_gemini_sample/data/block/chat_list_state.dart';
import 'package:google_gemini_sample/data/model/chat_data_model.dart';
import 'package:google_gemini_sample/presentation/home/components/bottom_view.dart';
import 'package:google_gemini_sample/presentation/home/components/chat_message_item_view.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  final ImagePicker imagePicker = ImagePicker();
  final gemini = Gemini.instance;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final _gemini = Gemini.instance;

  _picImageFromGallery(String message) async {
    final XFile? pickedFile = await widget.imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    final file = File(pickedFile!.path);
    _addNewMessage(
        message, pickedFile.path, SenderType.user, MessageType.image);
    print('QUESTION ::: $message');
    _gemini
        .textAndImage(text: message, images: [file.readAsBytesSync()])
        .then((value) => {
              print('ANSWER ::: ${value?.output}'),
              _addNewMessage(value?.output ?? '', null, SenderType.remote,
                  MessageType.text)
            })
        .catchError((error) => {
              print('ERROR ::: $error'),
              _addNewMessage(
                  error.toString(), null, SenderType.error, MessageType.text)
            });
  }

  _getGeminiResult(String question) async {
    print('QUESTION ::: $question');
    _gemini
        .text(question)
        .then((value) => {
              print('ANSWER ::: ${value?.output}'),
              _addNewMessage(value?.output ?? '', null, SenderType.remote,
                  MessageType.text)
            })
        .catchError((error) => {
              print('ERROR ::: $error'),
              _addNewMessage(
                  error.toString(), null, SenderType.error, MessageType.text)
            });
  }

  _addNewMessage(
      String message, String? file, SenderType type, MessageType messageType) {
    final chatListBlock = BlocProvider.of<ChatListBlock>(context);
    chatListBlock.add(AddChatData(
        chat: ChatDataModel(
            message: message,
            file: file,
            senderType: type,
            messageType: messageType)));
    Timer(const Duration(seconds: 1), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ChatListBlock, ChatListState>(
        builder: (context, state) {
          if (state is ChatListUpdated && state.chatDataList.isNotEmpty) {
            final chatList = state.chatDataList;
            return ListView.builder(
              controller: _scrollController,
              itemBuilder: (context, index) {
                return chatMessageItemView(chatList[index]);
              },
              itemCount: chatList.length,
              shrinkWrap: true,
            );
          } else {
            return const Center(
              child: Text('No Data Found'),
            );
          }
        },
      ),
      bottomNavigationBar: bottomWidgetContainer((message) {
        _addNewMessage(message, null, SenderType.user, MessageType.text);
        _getGeminiResult(message);
      }, (message) {
        _picImageFromGallery(message);
      }),
    ));
  }
}
