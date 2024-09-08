import 'package:anime_app/features/home/presentation/widgets/home_releases_loader.dart';
import 'package:flutter/material.dart';

class FavoriteLoaderWidget extends StatelessWidget {
  const FavoriteLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
              ),
              itemCount: 4,
              itemBuilder: (
                BuildContext context,
                index,
              ) {
                return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: ReleaseLoaderCard(),
                    );
              });
  }
}