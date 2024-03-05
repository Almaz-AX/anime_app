import 'package:anime_app/core/error/failure.dart';
import 'package:flutter/material.dart';

class FailureWidget extends StatelessWidget {
  const FailureWidget({super.key, required this.failure});
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case NetworkInternetConnectionFailure:
        return 'Нет соединения с интренетом';
      case NetworkNotFoundFailure:
        return 'Неправильный запрос';
      case NetworkUnauthorizedFailure:
        return 'Для выполнения запроса необходимо авторизоваться';
      default:
        return 'Что-то пошло не так';
    }
  }

  final Failure failure;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(_mapFailureToMessage(failure)));
  }
}
