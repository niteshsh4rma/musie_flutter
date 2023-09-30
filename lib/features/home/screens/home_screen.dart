import 'package:auto_route/auto_route.dart';
import 'package:cocoicons/cocoicons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musie/navigation/app_router.dart';
import 'package:musie/shared/extensions/context_extensions.dart';
import 'package:musie/features/home/tabs/albums_tab.dart';
import 'package:musie/features/home/tabs/artists_tab.dart';
import 'package:musie/features/home/tabs/songs_tab.dart';
import 'package:musie/start/setup.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              title: Row(
                children: [
                  const Icon(Icons.music_note),
                  const SizedBox(width: 4),
                  Text(
                    context.loc.musie,
                    style: GoogleFonts.pacifico(),
                  ),
                ],
              ),
              pinned: true,
              floating: true,
              actions: [
                PopupMenuButton(
                  icon: const Icon(CocoIconLine.Menu_1),
                  tooltip: context.loc.menu,
                  position: PopupMenuPosition.under,
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        padding: EdgeInsets.zero,
                        child: ListTile(
                          dense: true,
                          leading: const Icon(CocoIconLine.Setting_2),
                          title: Text(context.loc.settings),
                          onTap: () {
                            context.popRoute();
                            context.pushRoute(const SettingsRoute());
                          },
                        ),
                      ),
                    ];
                  },
                ),
              ],
              bottom: TabBar(
                tabs: [
                  // TODO: to be implemented in future
                  // Tab(text: context.loc.suggested),
                  Tab(text: context.loc.songs),
                  Tab(text: context.loc.artists),
                  Tab(text: context.loc.albums),
                ],
              ),
            ),
          ],
          body: FutureBuilder(
            future: Setup.instance.audioQuery.permissionsStatus(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == true) {
                  return const TabBarView(
                    children: [
                      // TODO: to be implemented in future
                      // SuggestedTab(),
                      SongsTab(),
                      ArtistsTab(),
                      AlbumsTab(),
                    ],
                  );
                } else {
                  return Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            CocoIconBold.Shield_vulnerable,
                            size: 72,
                          ),
                          const SizedBox(height: 16),
                          Text(context.loc.noAccess),
                        ],
                      ),
                    ),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
