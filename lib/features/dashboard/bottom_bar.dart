import 'package:auto_route/auto_route.dart';
import 'package:cocoicons/cocoicons.dart';
import 'package:flutter/material.dart';
import 'package:musie/core/extensions/context_extensions.dart';

class BottomBar extends StatelessWidget {
  final TabsRouter tabsRouter;
  const BottomBar({
    super.key,
    required this.tabsRouter,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      height: 64,
      selectedIndex: tabsRouter.activeIndex,
      onDestinationSelected: tabsRouter.setActiveIndex,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      destinations: [
        NavigationDestination(
          icon: const Icon(CocoIconBold.Home),
          label: context.loc.home,
        ),
        NavigationDestination(
          icon: const Icon(CocoIconBold.Setting),
          label: context.loc.settings,
        ),
      ],
    );
  }
}
