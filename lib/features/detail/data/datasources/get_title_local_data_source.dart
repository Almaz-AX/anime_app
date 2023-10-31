import '../../../../core/data/models/anime_title.dart';

abstract class GetTitleLocalDataSource {
  Future<AnimeTitle> getTitle(int id);
}