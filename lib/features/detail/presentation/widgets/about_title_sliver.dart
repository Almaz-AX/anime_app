import 'package:anime_app/core/data/models/anime_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutTitleSliver extends StatelessWidget {
  const AboutTitleSliver({super.key});

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
          const Text('Обновлено вчера'),
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
