import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;

  const CustomAppBar({
    required this.title,
    this.actions,
    this.showBackButton = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      automaticallyImplyLeading: showBackButton,
      actions: actions,
      elevation: 0,
      shape: Border(
        bottom: BorderSide(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}