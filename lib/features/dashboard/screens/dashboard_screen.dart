import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:musie/navigation/app_router.dart';
import 'package:musie/features/dashboard/bottom_bar.dart';

@RoutePage()
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      lazyLoad: true,
      routes: const [
        HomeRoute(),
        HomeRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomBar(tabsRouter: tabsRouter),
        );
      },
    );
  }
}
