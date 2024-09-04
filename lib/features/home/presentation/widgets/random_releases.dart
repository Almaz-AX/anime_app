import 'package:anime_app/features/home/presentation/widgets/release_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/random_releases_bloc/bloc/random_releases_bloc.dart';

class RandomReleases extends StatelessWidget {
  const RandomReleases({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RandomReleasesBloc, RandomReleasesState>(
      builder: (context, state) {
        if (state is RandomTitlesLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Случайные тайтлы',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 290,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.randomReleases.length,
                    itemBuilder: (context, index) => ReleaseCardWidget(
                          release: state.randomReleases[index],
                        )),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
