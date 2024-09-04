// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'detail_bloc.dart';

enum Status { initial, loading, loaded, failure }

class DetailState extends Equatable {
  final Status status;
  final Release? release;
  final List<WatchedEpisode> watchedEpisodes;
  final bool isFavorite;
  final String message;

  const DetailState(
      {required this.status,
      this.release,
      this.watchedEpisodes = const <WatchedEpisode>[],
      this.isFavorite = false,
      this.message = 'ok'});

  @override
  List<Object?> get props => [status, release, watchedEpisodes, isFavorite];

  DetailState copyWith({
    Status? status,
    Release? title,
    List<WatchedEpisode>? watchedEpisodes,
    bool? isFavorite,
    String? message,
  }) {
    return DetailState(
      status: status ?? this.status,
      release: title ?? this.release,
      watchedEpisodes: watchedEpisodes ?? this.watchedEpisodes,
      isFavorite: isFavorite ?? this.isFavorite,
      message: message ?? this.message,
    );
  }
}
