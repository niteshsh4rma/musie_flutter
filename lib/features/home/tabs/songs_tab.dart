import 'package:auto_route/auto_route.dart';
import 'package:cocoicons/cocoicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musie/services/audio_player_service.dart';
import 'package:musie/shared/domain/providers/song_sort_type_provider.dart';
import 'package:musie/shared/extensions/context_extensions.dart';
import 'package:musie/shared/extensions/duration_extensions.dart';
import 'package:musie/shared/extensions/song_sort_type_extensions.dart';
import 'package:musie/start/setup.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongsTab extends ConsumerWidget {
  const SongsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songSortType = ref.watch(songSortTypeProvider);
    return FutureBuilder(
        future: Setup.instance.audioQuery.querySongs(
          sortType: songSortType,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            final songs = snapshot.data;
            if (songs?.isNotEmpty == true) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    child: Row(
                      children: [
                        Text(
                          '${songs!.length} ${context.loc.songs}',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const Spacer(),
                        PopupMenuButton(
                          position: PopupMenuPosition.under,
                          tooltip: context.loc.filterSongs,
                          icon: const Icon(CocoIconBold.Filter),
                          itemBuilder: (context) => SongSortType.values
                              .map(
                                (e) => PopupMenuItem(
                                  padding: EdgeInsets.zero,
                                  child: RadioListTile<SongSortType>(
                                    value: e,
                                    title: Text(e.displayName()),
                                    groupValue: songSortType,
                                    onChanged: (type) {
                                      ref
                                          .read(songSortTypeProvider.notifier)
                                          .setSongSortType(type!);
                                      context.popRoute();
                                    },
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 0,
                    thickness: 2,
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final song = songs[index];
                        return InkWell(
                          onTap: () {
                            if (song.uri != null) {
                              AudioPlayerService.instance.player
                                ..setAudioSource(
                                  AudioSource.uri(Uri.parse(song.uri!)),
                                )
                                ..play();
                            }
                          },
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
                                  id: song.id,
                                  type: ArtworkType.AUDIO,
                                  keepOldArtwork: true,
                                  artworkBorder: BorderRadius.circular(16),
                                  nullArtworkWidget: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.music_note,
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
                                        song.displayNameWOExt,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        '${song.album ?? '<${context.loc.unknown}>'} | ${Duration(milliseconds: song.duration ?? 0).toHoursMinutesSeconds()}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: Colors.grey,
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
                      itemCount: songs.length,
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
