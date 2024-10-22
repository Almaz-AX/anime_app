import 'package:anime_app/core/data/models/release.dart';
import 'package:anime_app/core/domain/usecases/get_random_title.dart';
import 'package:anime_app/core/domain/usecases/get_shikimori_score.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/data/models/shikimori_anime.dart';

part 'random_releases_event.dart';
part 'random_releases_state.dart';

class RandomReleasesBloc
    extends Bloc<RandomReleasesEvent, RandomReleasesState> {
  final GetRandomReleases getRandomTitle;
  final GetShikimoriScore getShikimoriScore;
  RandomReleasesBloc(
      {required this.getRandomTitle, required this.getShikimoriScore})
      : super(RandomReleasesInitial()) {
    on<RandomReleasesGetEvent>(_onGetRandomTitles);

    on<RandomReleasesScoreGetEvent>(_onGetRandomTitlesScore);
  }

  Future<void> _onGetRandomTitles(RandomReleasesGetEvent event, emit) async {
    final randomReleases = <Release>[];
    final randomReleasesOrFailure =
        await getRandomTitle(const RandomParams(limit: 8));
    randomReleasesOrFailure.fold(
        (failure) => null,
        (releases) => randomReleases.addAll(releases));
    emit(RandomReleasesLoaded(randomReleases: randomReleases));
    add(RandomReleasesScoreGetEvent(releases: randomReleases));
  }

  Future<void> _onGetRandomTitlesScore(RandomReleasesScoreGetEvent event,
      Emitter<RandomReleasesState> emit) async {
    await Future.delayed(const Duration(milliseconds: 6000));
    final releasesScore = <ShikimoriAnime?>[];
    for (Release release in event.releases) {
      final releaseScoreOrFailure = await getShikimoriScore(
          ShikimoriParams(releaseName: release.name.english));
      releaseScoreOrFailure.fold((failure) => releasesScore.add(null),
          (scoreList) => releasesScore.add(scoreList.first));
    }
    emit(
      RandomReleasesLoaded(
          randomReleases: event.releases, releasesScore: releasesScore),
    );
  }
}
