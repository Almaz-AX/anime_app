import 'package:anime_app/features/home/presentation/bloc/last_updates_bloc/last_updates_bloc.dart';
import 'package:anime_app/features/home/presentation/widgets/title_card_widget.dart';
import 'package:anime_app/features/widgets/error_widgets/failure_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                height: 290,
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
                    return TitleCardWidget(title: title);
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
