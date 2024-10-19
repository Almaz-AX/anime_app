import 'package:anime_app/core/data/models/shikimori_anime.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/data/models/release.dart';
import '../../../../core/host.dart';
import '../../../../ui/navigation/branches/main_screen_branch.dart';

class ReleaseCardWidget extends StatelessWidget {
  const ReleaseCardWidget(
      {super.key,
      required this.release,
      this.heigth = 224,
      this.score});

  final Release release;
  final ShikimoriAnime? score;
  final double heigth;

  @override
  Widget build(BuildContext context) {
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
                child: Container(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  height: heigth,
                  width: double.maxFinite,
                  child: Image.network(
                    '${Host.host}${release.poster.src}',
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) {
                      return AnimatedOpacity(
                        opacity: frame == null ? 0 : 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                        child: child,
                      );
                    },
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Text(
                  release.name.main,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Text(
                  release.genres?.map((genre) => genre.name).join(',') ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ],
          ),
          if(score?.score!=null) ScoreWidget(score: score!.score!,),
          Material(
            borderRadius: BorderRadius.circular(10),
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                context.push(MainScreenPath.detail, extra: release.id);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ScoreWidget extends StatelessWidget {
  final double score;
  const ScoreWidget({
    super.key, required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
          color: Colors.amber,
          width: 30,
          height: 30,
          child: Center(
            child: Text(
              score.toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.black),
            ),
          )),
    );
  }
}
