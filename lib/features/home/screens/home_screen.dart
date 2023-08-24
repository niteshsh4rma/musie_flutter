import 'package:auto_route/auto_route.dart';
import 'package:cocoicons/cocoicons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musie/core/extensions/context_extensions.dart';
import 'package:musie/features/home/tabs/albums_tab.dart';
import 'package:musie/features/home/tabs/artists_tab.dart';
import 'package:musie/features/home/tabs/songs_tab.dart';
import 'package:musie/features/home/tabs/suggested_tab.dart';
import 'package:musie/start/setup.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
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
                IconButton(
                  tooltip: context.loc.search,
                  onPressed: () {},
                  icon: const Icon(CocoIconLine.Search),
                )
              ],
              bottom: TabBar(
                isScrollable: true,
                tabs: [
                  Tab(text: context.loc.suggested),
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
                      SuggestedTab(),
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
