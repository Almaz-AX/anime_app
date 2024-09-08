import 'package:anime_app/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:anime_app/features/home/presentation/widgets/release_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../widgets/favorite_loader_widget.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Избранное',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: BlocProvider(
        create: (context) => sl<FavoritesBloc>()..add(FavoritesChangedEvent()),
        child: const FavoritesWidget(),
      ),
    );
  }
}

class FavoritesWidget extends StatelessWidget {
  const FavoritesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
      switch (state.status) {
        case Status.initial:
          return Container();
        case Status.loading:
          return const FavoriteLoaderWidget();
        case Status.failure:
          return const Center(child: Text('Что-то пошло не так'));
        case Status.loaded:
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
              ),
              itemCount: state.favoriteReleases.length,
              itemBuilder: (
                BuildContext context,
                index,
              ) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ReleaseCardWidget(
                    release: state.favoriteReleases[index],
                  ),
                );
              });
      }
    });
  }
}
