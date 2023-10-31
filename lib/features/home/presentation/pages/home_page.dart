import 'package:anime_app/features/search/data/repositories/rest_api_repository.dart';
import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';
import '../../../../assets/assets.dart';

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
              RestAPIService().getTitle(9000);
            },
            icon: Image.asset(
              IconAseet.alarmBell,
              color: const Color(0xFF2EAEBE),
            ),
          ),
        ],
      ),
      body: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        _Unwatched(),
        _TopInThisMonth(),
        _RandomTitlesList(),
      ],
    );
  }
}

class _Unwatched extends StatelessWidget {
  const _Unwatched();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Continue watching',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 232,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) => Container(
                height: 210,
                width: 260,
                padding: const EdgeInsets.only(right: 20),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 160,
                          width: 260,
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
                          '4 Season 1, Epizode 1',
                          maxLines: 1,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 160,
                      child: InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Text('24 min',
                              style: Theme.of(context).textTheme.bodyMedium),
                          const Expanded(
                            child: SizedBox(
                              height: 10,
                            ),
                          ),
                          MaterialButton(
                            shape: const CircleBorder(),
                            minWidth: 0,
                            onPressed: () {},
                            child: const ImageIcon(
                              AssetImage(IconAseet.cancel),
                            ),
                          ),
                        ],
                      ),
                    )
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
