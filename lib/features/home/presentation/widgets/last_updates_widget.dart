import 'package:anime_app/features/home/presentation/bloc/last_updates_bloc/last_updates_bloc.dart';
import 'package:anime_app/features/widgets/error_widgets/failure_widget.dart';
import 'package:anime_app/ui/navigation/branches/main_screen_branch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/host.dart';

class LastUpdates extends StatelessWidget {
  const LastUpdates({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LastUpdatesBloc, LastUpdatesState>(
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
                height: 310,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.titles.length,
                  itemBuilder: (context, index) {
                    if (index > state.titles.length - 2 && !state.pageIsEmtpy) {
                      context.read<LastUpdatesBloc>().add(
                          LastUpdatesLoadPageEvent(
                              currenPage:
                                  state.titleUpdates.pagination.currentPage,
                              titles: state.titles));
                    }
                    final title = state.titles[index];
                    return Container(
                      width: 200,
                      padding: const EdgeInsets.only(left: 10),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 224,
                                  width: double.maxFinite,
                                  child: Image(
                                    image: NetworkImage(
                                        '${Host.host}${title.posters.small.url}'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                child: Text(
                                  title.names.ru,
                                  maxLines: 2,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                child: Text(
                                  title.genres.join(','),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ),
                            ],
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                context.push(MainScreenPath.detail,
                                    extra: title.id);
                              },
                            ),
                          ),
                        ],
                      ),
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
