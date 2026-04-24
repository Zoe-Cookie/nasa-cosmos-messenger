import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nasa_cosmos_messenger/logic/cubit/apod_cubit.dart';
import 'package:nasa_cosmos_messenger/logic/cubit/apod_state.dart';
import 'package:nasa_cosmos_messenger/ui/widgets/chat_bubble.dart';

class NovaChatScreen extends StatefulWidget {
  const NovaChatScreen({super.key});

  @override
  State<NovaChatScreen> createState() => _NovaChatScreenState();
}

class _NovaChatScreenState extends State<NovaChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1995, 6, 16),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _textController.text += DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova')),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ApodCubit, ApodState>(
              listener: (context, state) {
                _scrollToBottom();
              },
              builder: (context, state) {
                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: state.messages.length + (state.isTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == state.messages.length && state.isTyping) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Align(alignment: Alignment.centerLeft, child: CircularProgressIndicator()),
                      );
                    }

                    final message = state.messages[index];
                    return ChatBubble(
                      message: message,
                      onLongPress: () {
                        // TODO: 之後要接上 Database
                        debugPrint('長按了訊息！準備存入收藏庫');
                      },
                    );
                  },
                );
              },
            ),
          ),

          const Divider(height: 1),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            color: Theme.of(context).cardColor,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: '輸入或選擇日期...',
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      suffixIcon: IconButton(icon: const Icon(Icons.calendar_month), onPressed: _selectDate),
                    ),
                    onSubmitted: (text) {
                      context.read<ApodCubit>().sendMessage(text);
                      _textController.clear();
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    context.read<ApodCubit>().sendMessage(_textController.text);
                    _textController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
