// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'last_updates_bloc.dart';

sealed class LastUpdatesState extends Equatable {
  const LastUpdatesState();

  @override
  List<Object> get props => [];
}

final class LastUpdatesInitial extends LastUpdatesState {}

final class LastUpdatesSuccessState extends LastUpdatesState {
  final TitleUpdates titleUpdates;
  final List<AnimeTitle> titles;
  final bool pageIsEmtpy;
  const LastUpdatesSuccessState(
      {required this.titleUpdates,
      required this.titles,
      required this.pageIsEmtpy});
  @override
  List<Object> get props => [titleUpdates, titles, pageIsEmtpy];

  LastUpdatesSuccessState copyWith({
    TitleUpdates? titleUpdates,
    List<AnimeTitle>? titles,
    bool? pageIsEmtpy,
  }) {
    return LastUpdatesSuccessState(
      titleUpdates: titleUpdates ?? this.titleUpdates,
      titles: titles ?? this.titles,
      pageIsEmtpy: pageIsEmtpy ?? this.pageIsEmtpy,
    );
  }
}

final class LastUpdatesFailureState extends LastUpdatesState {
  final String message;
  const LastUpdatesFailureState({
    required this.message,
  });
}
