import 'package:anime_app/features/home/presentation/bloc/latest_releases_bloc/latest_releases_bloc.dart';
import 'package:anime_app/features/home/presentation/widgets/release_card_widget.dart';
import 'package:anime_app/features/widgets/error_widgets/failure_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LatesetReleases extends StatelessWidget {
  const LatesetReleases({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LatestReleasesBloc, LatestReleasesState>(
      builder: (context, state) {
        if (state is LastUpdatesInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is LastUpdatesFailureState) {
          return FailureWidget(failure: state.failure);
        }
        if (state is LastUpdatesSuccessState) {
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
                    final release = state.releases[index];
                    return Stack(
                      children: [
                        ReleaseCardWidget(release: release),
                      ],
                    );
                  },
                ),
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
