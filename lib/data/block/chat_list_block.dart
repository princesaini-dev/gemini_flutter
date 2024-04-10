import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:google_gemini_sample/data/block/chat_list_event.dart';
import 'package:google_gemini_sample/data/block/chat_list_state.dart';

class ChatListBlock extends Bloc<ChatListEvent, ChatListState> {
  ChatListBlock() : super(ChatListInitial(chatDataList: [])) {
    on<AddChatData>(_addChatDataItem);
    on<DeleteChatData>(_deleteChatDataItem);
    on<ClearAllConversations>(_clearAllConversations);
  }

  void _addChatDataItem(AddChatData event, Emitter<ChatListState> emit) {
    state.chatDataList.add(event.chat);
    emit(ChatListUpdated(chatDataList: state.chatDataList));
  }

  FutureOr<void> _deleteChatDataItem(DeleteChatData event, Emitter<ChatListState> emit) {
    state.chatDataList.remove(event.chat);
    emit(ChatListUpdated(chatDataList: state.chatDataList));
  }

  FutureOr<void> _clearAllConversations(ClearAllConversations event, Emitter<ChatListState> emit) {
    state.chatDataList.clear();
    emit(ChatListUpdated(chatDataList: state.chatDataList));
  }
}
