import 'package:flutter/material.dart';
import 'package:gpt_3_chat/extensions/widget.dart';
import 'package:gpt_3_chat/styles/colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
    this.landscape = false,
  }) : super(key: key);
  final bool landscape;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        const DrawerHeader(
          decoration: BoxDecoration(
            color: AppColors.secondary,
          ),
          child: Text('Drawer Header'),
        ),
        ListTile(
          leading: const Icon(Icons.chat),
          iconColor: AppColors.primary,
          title: const Text(
            'Chat',
            style: TextStyle(
              color: AppColors.primary,
            ),
          ),
          onTap: () {
            if (landscape) { Navigator.pop(context);}
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          iconColor: AppColors.primary,
          title: const Text(
            'Settings',
            style: TextStyle(
              color: AppColors.primary,
            ),
          ),
          onTap: () {
            if (landscape) {Navigator.pop(context);}
          },
        ),
      ],
    ).widgetBackground(
      AppColors.secondaryBackground,
    );
  }
}