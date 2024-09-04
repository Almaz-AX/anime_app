// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: depend_on_referenced_packages
import 'package:anime_app/core/data/models/release.dart';
import 'package:anime_app/core/error/failure.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/latest_releases.dart';

part 'latest_releases_event.dart';
part 'latest_releases_state.dart';

class LatestReleasesBloc
    extends Bloc<LatestReleasesEvent, LatestReleasesState> {
  final LatesetReleases getLatestReleases;
  LatestReleasesBloc({
    required this.getLatestReleases,
  }) : super(LastUpdatesInitial()) {
    on<LatestReleasesGetEvent>(
      _onLatestReleasesGet,
    );
  }

  Future<void> _onLatestReleasesGet(LatestReleasesGetEvent event, emit) async {
    final latestReleasesOrFailure =
        await getLatestReleases(const Params(limit: 20));
    latestReleasesOrFailure.fold(
        (failure) => emit(LastUpdatesFailureState(failure: failure)),
        (latestReleases) => emit(LastUpdatesSuccessState(
            releases: latestReleases,
           )));
  }
}
