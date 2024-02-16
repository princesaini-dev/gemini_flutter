import 'package:bloc/bloc.dart';
import 'package:google_gemini_sample/data/block/chat_list_event.dart';
import 'package:google_gemini_sample/data/block/chat_list_state.dart';

class ChatListBlock extends Bloc<ChatListEvent, ChatListState> {
  ChatListBlock() : super(ChatListInitial(chatDataList: [])) {
    on<AddChatData>(_addChatDataItem);
  }

  void _addChatDataItem(AddChatData event, Emitter<ChatListState> emit) {
    state.chatDataList.add(event.chat);
    emit(ChatListUpdated(chatDataList: state.chatDataList));
  }
}
