import 'package:anime_app/core/data/models/anime_title.dart';
import 'package:anime_app/ui/navigation/branches/search_page_branch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/host.dart';
import '../../../../injection_container.dart';
import '../bloc/search_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SearchBloc>()..add(RandomTitleEvent()),
      child: const CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          SearchForm(),
          SearchTitleBody(),
        ],
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}

class SearchForm extends StatelessWidget {
  const SearchForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      title: TextFormField(
        onChanged: (value) {
          context.read<SearchBloc>().add(SearchTitlesEvent(query: value));
        },
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        decoration: const InputDecoration(
            icon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
            hintText: 'Поиск'),
      ),
    );
  }
}

class SearchTitleBody extends StatelessWidget {
  const SearchTitleBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      if (state is SearchInitialState) {
        return const SliverToBoxAdapter();
      } else if (state is SearchRandomTitleState) {
        final title = state.title;
        return SliverToBoxAdapter(
            child: Column(
          children: [
            const TitleWidget(text: 'Рандомный тайтл'),
            TitleCardWidget(
              title: title,
            ),
          ],
        ));
      } else if (state is SearchLoadingState) {
        return const SliverToBoxAdapter(
          child: Column(
            children: [
              TitleWidget(text: 'Поиск'),
              Center(child: CircularProgressIndicator()),
            ],
          ),
        );
      } else if (state is SearchLoadedState) {
        return SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            final titleList = state.titles;
            final title = titleList[index];
            context
                .read<SearchBloc>()
                .add(SearchTitlesNextPageEvent(index, state.searchTitles));
            return TitleCardWidget(
              title: title,
              height: 530,
            );
          }, childCount: state.titles.length),
        );
      } else if (state is SearchErrorState) {
        return SliverToBoxAdapter(
          child: Text(state.message),
        );
      } else {
        return const SliverToBoxAdapter();
      }
    });
  }
}

class TitleCardWidget extends StatelessWidget {
  final double height;
  final double? width;
  const TitleCardWidget({
    super.key,
    required this.title,
    this.height = 530,
    this.width,
  });

  final AnimeTitle title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: height - 0.155 * height,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(
                              '${Host.host}${title.posters.medium.url}'),
                          fit: BoxFit.fill)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(title.names.ru,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.titleSmall),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(
                    title.genres.join(', '),
                    style: Theme.of(context).textTheme.labelMedium,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            Material(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
              child: InkWell(
                highlightColor: const Color(0xFF2EAEBE).withOpacity(0.2),
                radius: 5,
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  context.push(SearchScreenPath.detail, extra: title.id);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
