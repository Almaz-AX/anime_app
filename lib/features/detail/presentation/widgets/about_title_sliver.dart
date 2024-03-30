import 'package:anime_app/core/data/models/anime_title.dart';
import 'package:flutter/material.dart';
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
    final title = context.read<AnimeTitle>();
    return SliverToBoxAdapter(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.names.ru,
            style: Theme.of(context).textTheme.titleMedium,
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
