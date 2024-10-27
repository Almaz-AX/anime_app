import 'package:anime_app/features/detail/presentation/blocs/detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutTitleSliver extends StatelessWidget {
  const AboutTitleSliver({super.key});
  String dateFormat(DateTime updatedTime) {
    final timeNow = DateTime.now();
    final difference = timeNow.day - updatedTime.day;
    if (difference == 0) {
      return 'сегодня в ${_timeFormat(updatedTime.hour)} : ${_timeFormat(updatedTime.minute)}';
    } else if (difference ==1) {
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
    final release = bloc.state.release;
    final score = context.select((DetailBloc bloc) => bloc.state.score)?.score;
    final isFavorite =
        context.select((DetailBloc bloc) => bloc.state.isFavorite);
    if (release == null) {
      return const SliverToBoxAdapter();
    }

    return SliverToBoxAdapter(
        child: Padding(
      padding: const EdgeInsets.only(left: 16,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            release.name.main,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Stack(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    release.genres?.map((genre) => genre.name).join(', ')?? '',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  if (release.freshAt != null )Text('Обновлено ${dateFormat(release.freshAt!)}'),
              RichText(
                  text: TextSpan(
                text: 'Статус: ',
                style: Theme.of(context).textTheme.labelMedium,
                children: [
                  TextSpan(
                      text: release.isOngoing ? 'Онгоинг' : 'Вышел',
                      style: Theme.of(context).textTheme.bodyMedium)
                ],
              ))
                ],
              ),
                Align( alignment: Alignment.topRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                          iconSize: 25,
                          onPressed: () =>
                              bloc.add(DetailChangeFavoriteTitleEvent(release.id)),
                          isSelected: isFavorite,
                          selectedIcon: const Icon(Icons.favorite),
                          icon: const Icon(Icons.favorite_border)),
                 if (score!=null)Padding(
                   padding: const EdgeInsets.symmetric(horizontal:10.0),
                   child: Row( mainAxisSize: MainAxisSize.min,
                     children: [
                       const Icon(Icons.star,),
                       const SizedBox(width: 5,),
                       Text(score.toString())
                     ],
                   ),
                 )
              ],
            ))
            ],
          ),
          
        ],
      ),
    ));
  }
}
