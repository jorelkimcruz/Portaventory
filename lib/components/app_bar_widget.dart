import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget(
      {Key? key, this.actions, this.title = '', this.overrideBackButton})
      // ignore: avoid_field_initializers_in_const_classes
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0
  final List<Widget>? actions;
  final String title;
  final Widget? overrideBackButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: LayoutBuilder(
        builder: (context, constraints) => title.isEmpty
            ? Column(
                children: [
                  // Image.asset(
                  //   Assets.images.logo.path,
                  //   width: constraints.maxWidth * 0.60,
                  //   fit: BoxFit.contain,
                  // ),
                ],
              )
            : Text(
                title,
              ),
      ),
      leading: overrideBackButton,
      actions: actions,
    );
  }
}
