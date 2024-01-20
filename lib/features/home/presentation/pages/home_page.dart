import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../constants/constants.dart';
import '../../../../assets/assets.dart';
import '../../../../core/data/local/DAO/watched_episode_dao.dart';
import '../../../../core/data/models/anime_title.dart';
import '../../../../injection_container.dart';
import '../bloc/home_bloc.dart';
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
      body: BlocProvider(
        create: (context) =>
            sl<HomeBloc>()..add(HomeGetUnderSeenEpisodesEvent()),
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
        _TopInThisMonth(),
        _RandomTitlesList(),
      ],
    );
  }
}

class _TopInThisMonth extends StatelessWidget {
  const _TopInThisMonth();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top 10 this month',
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
