import 'package:anime_app/features/home/presentation/bloc/latest_releases_bloc/latest_releases_bloc.dart';
import 'package:anime_app/features/home/presentation/widgets/release_card_widget.dart';
import 'package:anime_app/features/widgets/error_widgets/failure_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_releases_loader.dart';

class LatesetReleases extends StatelessWidget {
  const LatesetReleases({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LatestReleasesBloc, LastReleasesState>(
      builder: (context, state) {
        switch (state) {
          case LastReleasesInitial _:
            return const HomeReleasesLoader();
          case LastReleasesFailure _:
            return FailureWidget(failure: state.failure);
          case LastReleasesSuccess _:
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Последние обновления',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 290,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.releases.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          ReleaseCardWidget(
                            release: state.releases[index],
                            score: state.releasesScore.isNotEmpty? state.releasesScore[index]:null,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
        }
      },
    );
  }
}
