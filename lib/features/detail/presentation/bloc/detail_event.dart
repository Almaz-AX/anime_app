// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object> get props => [];
}

class DetailGetTitleEvent extends DetailEvent {
  final int id;
  const DetailGetTitleEvent(
    this.id,
  );

  @override
  List<Object> get props => [id];
}