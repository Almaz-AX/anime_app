import 'package:anime_app/ui/components/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailLoaderWidget extends StatelessWidget {
  const DetailLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        SafeArea(child: LoaderContainer(height: 200, width: double.infinity)),
        SizedBox(
          height: 15,
        ),
        AboutTitleLoader(),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: LoaderContainer(height: 80, width: double.infinity),
        ),
        SizedBox(
          height: 16,
        ),
        EpisodeLoader(),
        EpisodeLoader()
      ],
    );
  }
}

class AboutTitleLoader extends StatelessWidget {
  const AboutTitleLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 16, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 4,
              ),
              Expanded(
                  flex: 10, child: LoaderContainer(height: 77, width: 100)),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          LoaderContainer(height: 16, width: 200),
          SizedBox(
            height: 5,
          ),
          LoaderContainer(height: 16, width: 200),
        ],
      ),
    );
  }
}

class EpisodeLoader extends StatelessWidget {
  const EpisodeLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoaderContainer(height: 130, width: 200),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoaderContainer(height: 18, width: 80),
                SizedBox(
                  height: 10,
                ),
                LoaderContainer(height: 32, width: double.infinity),
                SizedBox(
                  height: 5,
                ),
                LoaderContainer(height: 13, width: 120)
              ],
            ),
          )
        ],
      ),
    );
  }
}
