// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatDataModel {
  final String message;
  final String? file;
  final SenderType senderType;
  final MessageType messageType;
  ChatDataModel(
      {required this.message,
      required this.file,
      required this.senderType,
      required this.messageType});
}

enum SenderType { user, remote, error }

enum MessageType { text, image, loading }
