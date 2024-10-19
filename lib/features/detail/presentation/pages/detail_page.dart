import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../blocs/detail_bloc.dart';
import '../widgets/about_title_sliver.dart';
import '../widgets/description_sliver.dart';
import '../widgets/detail_loader_widget.dart';
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
        switch (state.status) {
          case Status.initial:
            return const Center();
          case Status.loading:
            return const DetailLoaderWidget();
          case Status.failure:
            return Center(
              child: Text(state.message),
            );
          case Status.loaded:
            return const CustomScrollView(
              slivers: [
                ViewerEpisodeSliver(),
                SliverToBoxAdapter(
                    child: SizedBox(
                  height: 15,
                )),
                AboutTitleSliver(),
                SliverToBoxAdapter(
                    child: SizedBox(
                  height: 15,
                )),
                DescriptionSliver(),
                // SliverToBoxAdapter(
                //   child: DetailTabView(),
                // ),
                EpisodesSliver(),
              ],
            );
        }
      },
    );
  }
}

class DetailTabView extends StatelessWidget {
  const DetailTabView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(tabs: [
              Tab(child: Text('Эпизоды')),
              Tab(child: Text('Описание')),
              Tab(child: Text('Связанное')),
            ]),
            SizedBox(
              height: 30,
              child: TabBarView(children: [
                    Text('Эпизоды'),
                    DescriptionSliver(),
                    Text('Связанное')
                  ]),
            ),
          ],
        ));
  }
}
