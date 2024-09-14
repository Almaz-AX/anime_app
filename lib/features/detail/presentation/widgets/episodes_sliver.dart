// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:anime_app/features/detail/presentation/blocs/detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'episode_card.dart';

class EpisodesSliver extends StatelessWidget {
  const EpisodesSliver({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final release = BlocProvider.of<DetailBloc>(context).state.release;
    final episodes = release?.episodes;
    if (episodes == null) {
      return const SliverToBoxAdapter();
    }
    return SliverList.builder(
      itemBuilder: (context, index) {
        return EpisodeCard(
          index: index,
        );
      },
      itemCount: episodes.length,
    );
  }
}

