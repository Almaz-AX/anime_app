import 'package:anime_app/features/detail/presentation/blocs/detail_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutTitleSliver extends StatelessWidget {
  const AboutTitleSliver({super.key});
  String dateFormat(int timestamp) {
    final timeNow = DateTime.now();
    final updatedTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final difference = timeNow.difference(updatedTime);
    if (!difference.isNegative && difference.inDays < 1) {
      return 'сегодня в ${_timeFormat(updatedTime.hour)} : ${_timeFormat(updatedTime.minute)}';
    } else if (!difference.isNegative && difference.inDays < 2) {
      return 'вчера в  ${_timeFormat(updatedTime.hour)} : ${_timeFormat(updatedTime.minute)}';
    } else {
      return '${_timeFormat(updatedTime.day)}.${_timeFormat(updatedTime.month)}.${updatedTime.year} в ${_timeFormat(updatedTime.hour)} : ${_timeFormat(updatedTime.minute)}';
    }
  }

  String _timeFormat(int value) {
    if (value < 10) {
      return '0$value';
    }
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<DetailBloc>(context);
    final title = bloc.state.title;
    final isFavorite =
        context.select((DetailBloc bloc) => bloc.state.isFavorite);
    if (title == null) {
      return Container();
    }

    return SliverToBoxAdapter(
        child: Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    title.names.ru,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
              IconButton(
                  iconSize: 25,
                  onPressed: () =>
                      bloc.add(DetailChangeFavoriteTitleEvent(title.id)),
                  isSelected: isFavorite,
                  selectedIcon: const Icon(Icons.favorite),
                  icon: const Icon(Icons.favorite_border))
            ],
          ),
          Text(
            title.genres.join(', '),
            style: Theme.of(context).textTheme.labelMedium,
          ),
          if (title.updated != null)
            Text('Обновлено ${dateFormat(title.updated!)}'),
          if (title.status?.string != null)
            const SizedBox(
              height: 15,
            ),
          RichText(
              text: TextSpan(
            text: 'Статус:  ',
            style: Theme.of(context).textTheme.labelMedium,
            children: [
              TextSpan(
                  text: title.status!.string,
                  style: Theme.of(context).textTheme.bodyMedium)
            ],
          ))
        ],
      ),
    ));
  }
}
