import 'package:isar/isar.dart';

part 'watched_title.g.dart';

@collection
class WatchedTitle {
  final Id id;
  List<int> watchedEpisodes;
  WatchedTitle({required this.id, required this.watchedEpisodes}) {
  }
}
