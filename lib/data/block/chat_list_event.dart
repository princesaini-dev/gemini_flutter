// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:google_gemini_sample/data/model/chat_data_model.dart';

abstract class ChatListEvent {}

class AddChatData extends ChatListEvent {
  final ChatDataModel chat;
  AddChatData({
    required this.chat,
  });
}

class DeleteChatData extends ChatListEvent {
  final ChatDataModel chat;
  DeleteChatData({
    required this.chat,
  });
}

class ClearAllConversations extends ChatListEvent {}
