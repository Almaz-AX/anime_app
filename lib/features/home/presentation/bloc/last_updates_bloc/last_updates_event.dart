// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'last_updates_bloc.dart';

sealed class LastUpdatesEvent extends Equatable {
  const LastUpdatesEvent();

  @override
  List<Object> get props => [];
}

final class LastUpdatesLoadPageEvent extends LastUpdatesEvent {
  final int currenPage;
  final List<AnimeTitle> titles;
  const LastUpdatesLoadPageEvent({
    this.currenPage = 0,
    this.titles = const <AnimeTitle>[],
  });
  @override
  List<Object> get props => [currenPage, titles];
}
