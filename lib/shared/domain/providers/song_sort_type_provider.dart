import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musie/shared/constants/global_constants.dart';
import 'package:musie/shared/data/local/storage_service.dart';
import 'package:musie/shared/domain/providers/sharedpreferences_storage_service_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';

final songSortTypeProvider =
    StateNotifierProvider<SongSortTypeNotifier, SongSortType>(
  (ref) {
    final storage = ref.watch(storageServiceProvider);
    return SongSortTypeNotifier(storage);
  },
);

class SongSortTypeNotifier extends StateNotifier<SongSortType> {
  final StorageService storageService;

  SongSortTypeNotifier(this.storageService) : super(SongSortType.TITLE) {
    loadCurrentSortType();
  }

  void loadCurrentSortType() async {
    final songSortType =
        await storageService.get(GlobalConstants.sortSortTypeKey);
    final value =
        SongSortType.values.byName('${songSortType ?? SongSortType.TITLE}');
    storageService.set(GlobalConstants.sortSortTypeKey, value.name);
    state = value;
  }

  void setSongSortType(SongSortType sortType) async {
    storageService.set(GlobalConstants.sortSortTypeKey, sortType.name);
    state = sortType;
  }
}
