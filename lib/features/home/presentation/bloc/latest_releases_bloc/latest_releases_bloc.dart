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
    emit(LastReleasesSuccess(releases: releases));
    add(LatestReleasesScoreGetEvent(releases));
  }

  Future<void> _onLatestReleasesScoreGet(LatestReleasesScoreGetEvent event,
      Emitter<LastReleasesState> emit) async {
    final releasesScore = <ShikimoriAnime?>[];
    for (Release release in event.releases) {
      final releaseScoreOrFailure = await getShikimoriScore(
          ShikimoriParams(releaseName: release.name.english));
      releaseScoreOrFailure.fold((failure) => releasesScore.add(null),
          (score) => releasesScore.add(score));
    }
    emit(LastReleasesSuccess(
        releases: event.releases, releasesScore: releasesScore));
  }
}
