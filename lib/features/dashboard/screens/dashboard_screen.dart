import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:musie/navigation/app_router.dart';

@RoutePage()
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Implement Tab Bar in Future
    return AutoTabsRouter(
      lazyLoad: true,
      routes: const [
        HomeRoute(),
        SettingsRoute(),
      ],
      builder: (context, child) {
        // final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          // bottomNavigationBar: BottomBar(tabsRouter: tabsRouter),
        );
      },
    );
  }
}
