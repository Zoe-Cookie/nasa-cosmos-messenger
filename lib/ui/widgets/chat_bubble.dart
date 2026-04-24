import 'package:flutter/material.dart';
import 'package:nasa_cosmos_messenger/data/models/chat_message.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final VoidCallback? onLongPress;

  const ChatBubble({super.key, required this.message, this.onLongPress});

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    final theme = Theme.of(context);

    return GestureDetector(
      onLongPress: onLongPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isUser) ...[const CircleAvatar(child: Icon(Icons.smart_toy)), const SizedBox(width: 8)],

            Flexible(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isUser ? theme.colorScheme.primary : theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(16),
                    topRight: const Radius.circular(16),
                    bottomLeft: Radius.circular(isUser ? 16 : 0),
                    bottomRight: Radius.circular(isUser ? 0 : 16),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.text,
                      style: TextStyle(
                        fontSize: 16,
                        color: isUser ? theme.colorScheme.onPrimary : theme.colorScheme.onSurfaceVariant,
                      ),
                    ),

                    if (message.apod != null) ...[
                      if (message.apod!.mediaType == 'video') ...[
                        if (message.apod!.thumbnailUrl != null) ...[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.network(message.apod!.thumbnailUrl!, fit: BoxFit.cover),
                                const Icon(Icons.play_circle_fill, size: 64, color: Colors.white70),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                        Text(
                          '🎥 點擊觀看影片: ${message.apod!.url}',
                          style: const TextStyle(color: Colors.blueAccent, decoration: TextDecoration.underline),
                        ),
                      ] else ...[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            message.apod!.url,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(child: CircularProgressIndicator());
                            },
                          ),
                        ),
                      ],

                      const SizedBox(height: 12),
                      Text(
                        message.apod!.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(message.apod!.date, style: TextStyle(fontSize: 12, color: theme.colorScheme.primary)),
                      const SizedBox(height: 8),
                      Text(message.apod!.explanation, style: TextStyle(color: theme.colorScheme.onSurfaceVariant)),
                    ],
                  ],
                ),
              ),
            ),

            if (isUser) ...[const SizedBox(width: 8), const CircleAvatar(child: Icon(Icons.person))],
          ],
        ),
      ),
    );
  }
}
