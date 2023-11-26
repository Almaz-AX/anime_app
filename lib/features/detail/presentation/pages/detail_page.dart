import 'package:anime_app/servi%D1%81es/isar_service/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../injection_container.dart';
import '../bloc/detail_bloc.dart';
import '../widgets/about_title_sliver.dart';
import '../widgets/description_sliver.dart';
import '../widgets/episodes_sliver.dart';
import '../widgets/viewer_episode_sliver.dart';

class DetailPage extends StatelessWidget {
  final int id;
  const DetailPage({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => sl<DetailBloc>()..add(DetailGetTitleEvent(id)),
      child: const Body(),
    ));
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailBloc, DetailState>(
      builder: (context, state) {
        if (state is DetailLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DetailLoadedState) {
          return MultiProvider(
            providers: [
              Provider(
                create: (context) => state.title,
              ),
              ProxyProvider0(
                update: (_,__) => state.watchedEpisodes,
              ),
            ],
            child: const CustomScrollView(
              slivers: [
                ViewerEpisodeSliver(),
                SliverToBoxAdapter(
                    child: SizedBox(
                  height: 35,
                )),
                AboutTitleSliver(),
                SliverToBoxAdapter(
                    child: SizedBox(
                  height: 15,
                )),
                DescriptionSliver(),
                EpisodesSliver(),
              ],
            ),
          );
        } else if (state is DetailErrorState) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center();
        }
      },
    );
  }
}
