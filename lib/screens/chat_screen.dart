import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gpt_3_chat/controllers/conversation_controller.dart';
import 'package:gpt_3_chat/extensions/widget.dart';
import 'package:gpt_3_chat/models/user.dart';
import 'package:gpt_3_chat/widgets/app_scaffold.dart';
import 'package:intl/intl.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:gpt_3_chat/styles/colors.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final scrollController = ScrollController();
  final _messageController = TextEditingController();
  final _conversationController = ConversationController();

  Future<void> _sendMessage() async {
    callback() {
      setState(() {});
      Future.delayed(
        const Duration(milliseconds: 300),
        () {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        },
      );
    }

    await _conversationController.sendMessage(
      _messageController.text,
      callback: callback,
    );
    callback();
    _messageController.clear();
  }

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          Container(
            color: AppColors.secondaryBackground,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('Token used: '),
                  const Text('prompt: '),
                  Text(
                    '${_conversationController.usage['prompt_tockens']}',
                    style: const TextStyle(
                      color: AppColors.accent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(' / completion: '),
                  Text(
                    '${_conversationController.usage['completion_tokens']}',
                    style: const TextStyle(
                      color: AppColors.accent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(' / total: '),
                  Text(
                    '${_conversationController.usage['total_tockens']}',
                    style: const TextStyle(
                      color: AppColors.accent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: _conversationController.conversation.length,
              dragStartBehavior: DragStartBehavior.down,
              itemBuilder: (context, index) {
                final message = _conversationController.conversation[index];
                final isMessageFromUser = message.sender.role == UserRole.user;
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(isMessageFromUser ? 32 : 16, 0,
                        isMessageFromUser ? 16 : 32, 0),
                    child: Column(
                      crossAxisAlignment: isMessageFromUser
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        if (!message.waiting)
                          Text(
                            DateFormat.jm(Intl.defaultLocale)
                                .format(message.timestamp),
                            style: const TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          textDirection: isMessageFromUser
                              ? ui.TextDirection.rtl
                              : ui.TextDirection.ltr,
                          children: [
                            if (message.sender.image != null)
                              CircleAvatar(
                                  radius: 25,
                                  child: Image.asset(
                                    message.sender.image!,
                                    filterQuality: FilterQuality.medium,
                                    fit: BoxFit.cover,
                                  )).widgetPadding(
                                const EdgeInsets.only(right: 10),
                              ),
                            Expanded(
                              child: Align(
                                alignment: isMessageFromUser
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: message.waiting
                                    ? SizedBox(
                                        width: 50,
                                        child: JumpingDotsProgressIndicator(
                                          fontSize: 20,
                                          numberOfDots: 3,
                                          color: AppColors.primary,
                                        ),
                                      )
                                    : SelectableText(
                                        message.text,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: AppColors.primary,
                                        ),
                                      )
                                        .widgetPadding(
                                          const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                        )
                                        .widgetBorder(
                                          const Border(
                                            bottom: BorderSide(
                                              color: AppColors.accent,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 20,
                    ),
                    enabled: !_conversationController.waiting,
                    controller: _messageController,
                    textInputAction: TextInputAction.send,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onSubmitted: (_) => _sendMessage(),
                    decoration: const InputDecoration(
                      hintText: 'Enter a message',
                      hintStyle: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 20,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.secondaryText,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    cursorColor: AppColors.primary,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: _conversationController.waiting
                        ? AppColors.secondaryText
                        : AppColors.primary,
                  ),
                  onPressed: () {
                    _sendMessage();
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
