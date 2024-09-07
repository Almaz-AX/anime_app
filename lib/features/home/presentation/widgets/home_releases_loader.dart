import 'package:flutter/material.dart';

import '../../../../ui/components/loader_widget.dart';

class HomeReleasesLoader extends StatelessWidget {
  const HomeReleasesLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: LoaderContainer(
              height: 24,
              width: 150,
            )),
        const SizedBox(height: 16),
        SizedBox(
          height: 290,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 2,
            itemBuilder: (context, index) {
              return const ReleaseLoaderCard();
            },
          ),
        ),
      ],
    );
  }
}

class ReleaseLoaderCard extends StatelessWidget {
  const ReleaseLoaderCard({super.key, this.height = 224});
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoaderContainer(height: height, width: double.maxFinite, borderRadius: 10,),
          const SizedBox(
            height: 5,
          ),
          const LoaderContainer(height: 16, width: 100),
          const SizedBox(height: 5),
          const LoaderContainer(height: 16, width: 150),
        ],
      ),
    );
  }
}
