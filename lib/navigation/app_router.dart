import 'package:auto_route/auto_route.dart';
import 'package:musie/navigation/route_paths.dart';
import 'package:musie/features/dashboard/screens/dashboard_screen.dart';
import 'package:musie/features/home/screens/home_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: DashboardRoute.page,
          initial: true,
          path: RoutePaths.dashboard,
          children: [
            AutoRoute(
              page: HomeRoute.page,
              path: RoutePaths.home,
            )
          ],
        ),
      ];
}
