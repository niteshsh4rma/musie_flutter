import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:on_audio_query/on_audio_query.dart';

extension SongSortTypeExtension on SongSortType {
  String displayName() => name.toLowerCase().replaceAll('_', ' ').capitalize;
}
