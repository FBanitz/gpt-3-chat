import 'package:flutter/material.dart';
import 'package:gpt_3_chat/screens/chat_screen.dart';
import 'package:gpt_3_chat/styles/colors.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() async {
  Intl.defaultLocale ??= 'fr_FR';
  await initializeDateFormatting(
    Intl.defaultLocale,
    null,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: MaterialColor(AppColors.primary.value, AppColors.swatch),
        primaryColor: AppColors.secondary,
        accentColor: AppColors.accent,
        backgroundColor: AppColors.background,
        scaffoldBackgroundColor: AppColors.background,
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            color: AppColors.primaryText,
          ),
          bodyText2: TextStyle(
            color: AppColors.secondaryText,
          ),
        ),
      ),
      title: 'GPT-3 Chat App',
      home: const ChatScreen(),
    );
  }
}
