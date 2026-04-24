import 'package:nasa_cosmos_messenger/data/models/chat_message.dart';

class ApodState {
  final List<ChatMessage> messages;
  final bool isTyping; //看 Nova 是不是正在打字，以控制提示輸出

  ApodState({
    required this.messages,
    this.isTyping = false,
  });

  ApodState copyWith({
    List<ChatMessage>? messages,
    bool? isTyping,
  }) {
    return ApodState(
      messages: messages ?? this.messages,
      isTyping: isTyping ?? this.isTyping,
    );
  }
}