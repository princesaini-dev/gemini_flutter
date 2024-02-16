// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:google_gemini_sample/data/model/chat_data_model.dart';

abstract class ChatListState {
  List<ChatDataModel> chatDataList;
  ChatListState({
    required this.chatDataList,
  });
}

class ChatListInitial extends ChatListState {
  ChatListInitial({required super.chatDataList});
}

class ChatListUpdated extends ChatListState {
  ChatListUpdated({required super.chatDataList});
}
