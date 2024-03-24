import 'package:anime_app/features/home/presentation/widgets/title_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/random_titles_bloc/bloc/random_titles_bloc.dart';

class RandomTitles extends StatelessWidget {
  const RandomTitles();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RandomTitlesBloc, RandomTitlesState>(
      builder: (context, state) {
        if (state is RandomTitlesLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Случайные тайтлы',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 290,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.randomTitles.length,
                    itemBuilder: (context, index) => TitleCardWidget(
                          title: state.randomTitles[index],
                        )),
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
