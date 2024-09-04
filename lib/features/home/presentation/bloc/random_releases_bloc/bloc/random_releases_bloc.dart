import 'package:anime_app/core/data/models/release.dart';
import 'package:anime_app/core/domain/usecases/get_random_title.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'random_releases_event.dart';
part 'random_releases_state.dart';

class RandomReleasesBloc
    extends Bloc<RandomReleasesEvent, RandomReleasesState> {
  final GetRandomReleases getRandomTitle;
  RandomReleasesBloc({required this.getRandomTitle})
      : super(RandomTitlesInitial()) {
    on<RandomTitlesGetEvent>(_onGetRandomTitles);
  }

  void _onGetRandomTitles(RandomTitlesGetEvent event, emit) async {
    final randomReleasesOrFailure =
        await getRandomTitle(const RandomParams(limit: 8));
    randomReleasesOrFailure.fold(
        (failure) => null,
        (randomReleases) =>
            emit(RandomTitlesLoaded(randomReleases: randomReleases)));

    ;
  }
}
