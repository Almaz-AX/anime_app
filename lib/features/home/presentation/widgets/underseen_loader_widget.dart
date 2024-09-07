import 'package:flutter/material.dart';

import '../../../../ui/components/loader_widget.dart';

class UnerseenLoaderWiget extends StatelessWidget {
  const UnerseenLoaderWiget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
            padding: EdgeInsets.only(left: 16, bottom: 16),
            child: LoaderContainer(
              height: 26,
              width: 200,
            )),
        SizedBox(
          height: 232,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 16),
            scrollDirection: Axis.horizontal,
            itemCount: 2,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.only(right: 8),
                width: 260,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LoaderContainer(height: 160, width: 260, borderRadius: 10,),
                    SizedBox(height: 8,width: 40,),
                    LoaderContainer(height: 36, width: 150),
                    SizedBox(height: 8,width: 20,),
                    LoaderContainer(height: 16, width: 100),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
