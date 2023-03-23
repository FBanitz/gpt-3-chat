import 'package:flutter/material.dart';
import 'package:gpt_3_chat/main.dart';
import 'package:gpt_3_chat/styles/colors.dart';
import 'package:gpt_3_chat/widgets/app_scaffold.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController tokenController = TextEditingController();
    tokenController.text = token;

    void saveToken(String value) {
      setState(() {
        token = value;
        tokenController.clear();
      });
    }

    return AppScaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              TextField(
                onSubmitted: saveToken,
                controller: tokenController,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  focusColor: Colors.grey,
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: AppColors.primary,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: AppColors.primary,
                    ),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: AppColors.primary,
                    ),
                  ),
                  hintStyle: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 20,
                  ),
                  labelStyle: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 20,
                  ),
                  labelText: 'Token',
                  hintText: 'Enter your OpenAI API token',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.check),
                    onPressed: () => saveToken(tokenController.text),
                  ),
                ),
              ),
              if (token.isNotEmpty)
                Text(
                  'Token: $token',
                ),
            ],
          ),
        ),
      ),
    );
  }
}
