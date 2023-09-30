import 'package:auto_route/auto_route.dart';
import 'package:musie/features/settings/screens/settings_screen.dart';
import 'package:musie/navigation/route_paths.dart';
import 'package:musie/features/dashboard/screens/dashboard_screen.dart';
import 'package:musie/features/home/screens/home_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        CupertinoRoute(
          page: DashboardRoute.page,
          path: RoutePaths.dashboard,
          initial: true,
          children: [
            CupertinoRoute(
              page: HomeRoute.page,
              path: RoutePaths.home,
            ),
            CupertinoRoute(
              page: SettingsRoute.page,
              path: RoutePaths.settings,
            ),
          ],
        ),
      ];
}
