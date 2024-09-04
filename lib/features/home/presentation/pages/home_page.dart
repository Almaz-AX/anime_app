import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../assets.dart';
import '../bloc/latest_releases_bloc/latest_releases_bloc.dart';
import '../../../../constants/constants.dart';
import '../../../../core/data/local/DAO/watched_episode_dao.dart';
import '../../../../injection_container.dart';
import '../bloc/random_releases_bloc/bloc/random_releases_bloc.dart';
import '../bloc/underseen_episodes_bloc/underseen_episodes_bloc.dart';
import '../widgets/latest_releases_widget.dart';
import '../widgets/random_releases.dart';
import '../widgets/underseen_episodes_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            SizedBox(
                height: 44,
                child: Image(
                    image: AssetImage(
                  ImagesAsset.userAvatar,
                ))),
            Text(
              '${Constants.hello}Kotevw',
            ),
          ],
        ),
        elevation: 0,
        actions: [
          IconButton(
            splashRadius: 15,
            padding: EdgeInsets.zero,
            onPressed: () {
              sl<WatchedEpisodesDAO>().deleteWatchedEpisodes();
            },
            icon: Image.asset(
              IconAseet.alarmBell,
              color: const Color(0xFF2EAEBE),
            ),
          ),
        ],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                sl<UnderseenEpisodesBloc>()..add(UnderseenEpisodesGetEvent()),
          ),
          BlocProvider(
            create: (context) =>
                sl<LatestReleasesBloc>()..add(const LatestReleasesGetEvent()),
          ),
          BlocProvider(
            create: (context) =>
                sl<RandomReleasesBloc>()..add(RandomTitlesGetEvent()),
          ),
        ],
        child: const _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        UnderseenEpisodes(),
        LatesetReleases(),
        RandomReleases(),
      ],
    );
  }
}
