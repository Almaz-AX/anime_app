import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


import '../../../../core/data/models/release.dart';
import '../../../../core/host.dart';
import '../../../../ui/navigation/branches/main_screen_branch.dart';

class ReleaseCardWidget extends StatelessWidget {
  const ReleaseCardWidget(
      {super.key, required this.release, this.heigth = 224});

  final Release release;
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
                child: SizedBox(
                  height: heigth,
                  width: double.maxFinite,
                  child: Image(
                    image: NetworkImage(
                        '${Host.host}${release.poster.src}'),
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
                  release.genres?.map((genre) => genre.name).join(',')?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelMedium,
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
                context.push(MainScreenPath.detail, extra: release.id);
              },
            ),
          ),
        ],
      ),
    );
  }
}
