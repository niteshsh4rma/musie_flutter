import 'package:cocoicons/cocoicons.dart';
import 'package:flutter/material.dart';
import 'package:musie/core/extensions/context_extensions.dart';
import 'package:musie/start/setup.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ArtistsTab extends StatelessWidget {
  const ArtistsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Setup.instance.audioQuery.queryArtists(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            final artists = snapshot.data;
            if (artists?.isNotEmpty == true) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Text(
                          '${artists!.length} ${context.loc.artists}',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final artist = artists[index];
                        return InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Row(
                              children: [
                                QueryArtworkWidget(
                                  artworkHeight: 100,
                                  artworkWidth: 100,
                                  controller: Setup.instance.audioQuery,
                                  id: artist.id,
                                  type: ArtworkType.ARTIST,
                                  keepOldArtwork: true,
                                  artworkBorder: BorderRadius.circular(100),
                                  nullArtworkWidget: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        CocoIconBold.User,
                                        size: 64,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        artist.artist,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: artists.length,
                    ),
                  ),
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
