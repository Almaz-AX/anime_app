import 'package:anime_app/features/home/presentation/bloc/last_updates_bloc/last_updates_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/constants.dart';
import '../../../../assets/assets.dart';
import '../../../../core/data/local/DAO/watched_episode_dao.dart';
import '../../../../injection_container.dart';
import '../bloc/underseen_episodes_bloc/underseen_episodes_bloc.dart';
import '../widgets/last_updates_widget.dart';
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
                sl<LastUpdatesBloc>()..add(const LastUpdatesLoadPageEvent()),
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
        LastUpdates(),
        _RandomTitlesList(),
      ],
    );
  }
}

class _RandomTitlesList extends StatelessWidget {
  const _RandomTitlesList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Random titles',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) => Container(
                height: 228,
                width: 168,
                padding: const EdgeInsets.only(right: 20),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 228,
                          width: 168,
                          padding: const EdgeInsets.only(right: 20),
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Episode_Name',
                          maxLines: 2,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(
                          'Action Demons',
                          maxLines: 1,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                    InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
