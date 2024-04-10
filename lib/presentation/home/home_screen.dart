import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:google_gemini_sample/data/block/chat_list_block.dart';
import 'package:google_gemini_sample/data/block/chat_list_event.dart';
import 'package:google_gemini_sample/data/block/chat_list_state.dart';
import 'package:google_gemini_sample/data/model/chat_data_model.dart';
import 'package:google_gemini_sample/presentation/base/base_stateful_widget.dart';
import 'package:google_gemini_sample/presentation/home/bottomBar/bottom_view.dart';
import 'package:google_gemini_sample/presentation/home/emptyView/enpty_Data_view.dart';
import 'package:google_gemini_sample/presentation/home/slider/slider_view.dart';
import 'package:google_gemini_sample/presentation/messageView/chat_message_item_view.dart';
import 'package:google_gemini_sample/presentation/utills/app_conponents.dart';
import 'package:google_gemini_sample/presentation/utills/extentions.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends BaseStatefulWidget {
  HomeScreen({super.key});
  final ImagePicker imagePicker = ImagePicker();
  @override
  BaseStatefulWidgetState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseStatefulWidgetState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<SliderDrawerState> _sliderDrawerKey =
      GlobalKey<SliderDrawerState>();
  final _gemini = Gemini.instance;
  String _conversationString = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SliderDrawer(
        key: _sliderDrawerKey,
        appBar: const SliderAppBar(
            appBarColor: Colors.white,
            title: Text('Chat with AI',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700))),
        slider: SliderView(
          onItemClick: (title) {
            _sliderDrawerKey.currentState!.closeSlider();
            switch (title) {
              case 'New Chat':
                _startNewChat();
                break;
              default:
            }
          },
        ),
        child: BlocBuilder<ChatListBlock, ChatListState>(
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
              ).paddingHorizontal(getScreenWidth(context) * 0.2);
            } else {
              return const EmptyDataView();
            }
          },
        ),
      ).paddingHorizontal(10),
      bottomNavigationBar: bottomWidgetContainer(getScreenWidth(context),(message) {
        _addNewMessage(message, null, SenderType.user, MessageType.text);
        _getGeminiResult(message);
      }, (message) {
        _picImageFromGallery(message);
      }),
    ));
  }

  _startNewChat() {
    _conversationString = '';
    final chatListBlock = BlocProvider.of<ChatListBlock>(context);
    chatListBlock.add(ClearAllConversations());
  }

  _picImageFromGallery(String message) async {
    final XFile? pickedFile = await widget.imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    final file = File(pickedFile!.path);
    _addNewMessage(
        message, pickedFile.path, SenderType.user, MessageType.image);
    'QUESTION ::: $message'.printMessage();
    _gemini
        .textAndImage(text: message, images: [file.readAsBytesSync()])
        .then((value) => {
              'ANSWER ::: ${value?.output}'.printMessage(),
              _addNewMessage(value?.output ?? '', null, SenderType.remote,
                  MessageType.text)
            })
        .catchError((error) => {
              'ERROR ::: $error'.printMessage,
              _addNewMessage(
                  error.toString(), null, SenderType.error, MessageType.text)
            });
  }

  _getGeminiResult(String question) async {
    'QUESTION ::: $question'.printMessage();
    _conversationString += 'User: $question\n';
    _showTyping();
    _gemini.chat([
      Content(
          parts: [Parts(text: _conversationString + question)], role: 'user')
    ]).then((value) {
      'ANSWER ::: ${value?.output}'.printMessage();
      _hideTyping();
      _conversationString += 'Gemini: ${value?.output}\n';
      _addNewMessage(
          value?.output ?? '', null, SenderType.remote, MessageType.text);
    }).onError((error, stackTrace) {
      _hideTyping();
      'ERROR ::: $error'.printMessage();
      _addNewMessage(
          error.toString(), null, SenderType.error, MessageType.text);
    });
  }

  _showTyping() {
    _addNewMessage('', null, SenderType.remote, MessageType.loading);
  }

  _hideTyping() {
    final chatListBlock = BlocProvider.of<ChatListBlock>(context);
    var lastChatDataModel = chatListBlock.state.chatDataList.last;
    if (lastChatDataModel.messageType == MessageType.loading) {
      chatListBlock.add(DeleteChatData(chat: lastChatDataModel));
    }
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
}
