import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/data/models/release.dart';
import '../../../../core/host.dart';
import '../../../../injection_container.dart';
import '../../../../ui/navigation/branches/search_page_branch.dart';
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
        final title = state.release;
        return SliverToBoxAdapter(
            child: Column(
          children: [
            const TitleWidget(text: 'Рандомный тайтл'),
            ReleaseWidget(
              release: title,
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
            final titleList = state.releases;
            final title = titleList[index];
            return ReleaseWidget(
              release: title,
              height: 570,
            );
          }, childCount: state.releases.length),
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

class ReleaseWidget extends StatelessWidget {
  final double height;
  final double? width;
  const ReleaseWidget({
    super.key,
    required this.release,
    this.height = 570,
    this.width,
  });

  final Release release;

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
                  height: height - 0.165 * height,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image:
                              NetworkImage('${Host.host}${release.poster.src}'),
                          fit: BoxFit.fitWidth)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text('${release.name.main}  ${release.ageRating.label}',
                      maxLines: 2,
                      style: Theme.of(context).textTheme.titleSmall),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: 'Сезон: ',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(color: Colors.white)),
                      TextSpan(
                          text:
                              '${release.year} ${release.season.description?.toLowerCase()}',
                          style: Theme.of(context).textTheme.labelMedium),
                      TextSpan(
                          text: '\t\tТип: ',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(color: Colors.white)),
                      TextSpan(
                          text:
                              '${release.type.description} (${release.episodesTotal} эп.)',
                          style: Theme.of(context).textTheme.labelMedium),
                    ]),
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
                  context.push(SearchScreenPath.detail, extra: release.id);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
