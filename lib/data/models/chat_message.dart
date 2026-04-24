import 'apod_model.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final ApodModel? apod;

  ChatMessage({
    required this.text,
    required this.isUser,
    this.apod,
  });
}