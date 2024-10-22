// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: depend_on_referenced_packages
import 'package:anime_app/core/data/models/release.dart';
import 'package:anime_app/core/data/models/shikimori_anime.dart';
import 'package:anime_app/core/domain/usecases/get_shikimori_score.dart';
import 'package:anime_app/core/error/failure.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/latest_releases.dart';

part 'latest_releases_event.dart';
part 'latest_releases_state.dart';

class LatestReleasesBloc extends Bloc<LatestReleasesEvent, LastReleasesState> {
  final LatestReleases getLatestReleases;
  final GetShikimoriScore getShikimoriScore;
  LatestReleasesBloc(
      {required this.getLatestReleases, required this.getShikimoriScore})
      : super(LastReleasesInitial()) {
    on<LatestReleasesGetEvent>(
      _onLatestReleasesGet,
    );
    on<LatestReleasesScoreGetEvent>(
      _onLatestReleasesScoreGet,
    );
  }

  Future<void> _onLatestReleasesGet(
      LatestReleasesGetEvent event, Emitter<LastReleasesState> emit) async {
    final latestReleasesOrFailure =
        await getLatestReleases(const Params(limit: 20));
    final releases = <Release>[];
    latestReleasesOrFailure.fold(
        (failure) => emit(LastReleasesFailure(failure: failure)),
        (latestReleases) => releases.addAll(latestReleases));
    emit(LastReleasesSuccess(
        releaseContainers:
            releases.map((e) => ReleaseContainer(release: e)).toList()));
    add(LatestReleasesScoreGetEvent(releases));
  }

  Future<void> _onLatestReleasesScoreGet(LatestReleasesScoreGetEvent event,
      Emitter<LastReleasesState> emit) async {
        // Необходимо сделать несколько запросов для получения рейтинга с Shikimori
        // 1 Запрос по онгоингам текущего сезона
        // 2 запрос по оставшимя тайтлам, которые не нашлись в 1 запросе
        // Так ошибок по 426 коду меньше.
    final releasesScore = <ShikimoriAnime>[];

    final releaseScoreOrFailure = await getShikimoriScore(
        ShikimoriParams(limit: 50, season: 'fall_2024'));
    releaseScoreOrFailure.fold(
        (failure) => null, (scoreList) => releasesScore.addAll(scoreList));
    final releaseContainers = <ReleaseContainer>[];

    if (releasesScore.isNotEmpty) {
      for (Release release in event.releases) {
        final ShikimoriAnime? releaseScore = releasesScore
            .where((element) => element.name == release.name.english)
            .firstOrNull;
        releaseContainers
            .add(ReleaseContainer(release: release, score: releaseScore));

        await Future.delayed(const Duration(milliseconds: 100));
        
        for (int i = 0; i < releaseContainers.length; i ++) {
          if (releaseContainers[i].score == null) {
            final scoreOrFailure = await getShikimoriScore(
                ShikimoriParams(releaseName: releaseContainers[i].release.name.english));
            scoreOrFailure.fold(
                (failure) => null,
                (scoreList) =>
                    releaseContainers[i] = releaseContainers[i].copyWith(score: scoreList.firstOrNull));
          }
        }
      }

      emit(LastReleasesSuccess(releaseContainers: releaseContainers));
    }
  }
}
