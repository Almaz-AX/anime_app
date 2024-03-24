import 'package:anime_app/core/data/models/anime_title.dart';
import 'package:anime_app/core/domain/usecases/get_random_title.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'random_titles_event.dart';
part 'random_titles_state.dart';

class RandomTitlesBloc extends Bloc<RandomTitlesEvent, RandomTitlesState> {
  final GetRandomTitle getRandomTitle;
  RandomTitlesBloc({required this.getRandomTitle})
      : super(RandomTitlesInitial()) {
    on<RandomTitlesGetEvent>(_onGetRandomTitles);
  }

  void _onGetRandomTitles(RandomTitlesGetEvent event, emit) async {
    final randomTitles = <AnimeTitle>[];
    for (int i = 0; i < 8; i++) {
      final randomTitleOrFailure = await getRandomTitle(NoParams());
      randomTitleOrFailure.fold(
          (failure) => null, (randomTitle) => randomTitles.add(randomTitle));
    }
    emit(RandomTitlesLoaded(randomTitles: randomTitles));
  }
}
