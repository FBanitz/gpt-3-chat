import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gpt_3_chat/styles/colors.dart';
import 'package:gpt_3_chat/widgets/drawer.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    Key? key,
    required this.body,
  }) : super(key: key);

  final Widget body;

  @override
  Widget build(BuildContext context) {
    bool islandscape =
        MediaQuery.of(context).orientation == Orientation.landscape &&
            MediaQuery.of(context).size.width > 725;
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: !islandscape
          ? const Drawer(
              child: AppDrawer(landscape: false),
            )
          : null,
      appBar: AppBar(
        leading: !islandscape
            ? Builder(
                builder: (context) => IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: AppColors.primary,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              )
            : null,
        title: const Text(
          'GPT-3 Chat App',
          style: TextStyle(
            color: AppColors.primary,
          ),
        ),
        backgroundColor: AppColors.secondary,
      ),
      body: Row(
        children: [
          if (islandscape)
            SizedBox(
              width: <double>[(MediaQuery.of(context).size.width * 0.2), 300]
                  .reduce(min),
              child: const AppDrawer(landscape: true),
            ),
          Expanded(
            child: body,
          ),
        ],
      ),
    );
  }
}
