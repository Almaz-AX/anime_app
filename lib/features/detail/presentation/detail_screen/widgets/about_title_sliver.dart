import 'package:anime_app/core/data/models/anime_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AboutTitleSliver extends StatelessWidget {
  const AboutTitleSliver({super.key});

  @override
  Widget build(BuildContext context) {
    final title = context.read<AnimeTitle>();
    return SliverToBoxAdapter(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title.names.ru,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title.genres.join(', '),
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ],
    ));
  }
}
