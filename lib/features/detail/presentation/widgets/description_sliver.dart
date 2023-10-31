import 'package:anime_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/data/models/anime_title.dart';

class DescriptionSliver extends StatefulWidget {
  const DescriptionSliver({
    super.key,
  });

  @override
  State<DescriptionSliver> createState() => _DescriptionSliverState();
}

class _DescriptionSliverState extends State<DescriptionSliver> {
  bool _isExpanded = false;
  double? _size = 50;
  void onTap() {
    setState(() {
      _size = _isExpanded ? 50 : null;
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final title = context.read<AnimeTitle>();
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            AnimatedSize(
              alignment: Alignment.topCenter,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              child: SizedBox(
                height: _size,
                child: Text(
                  textAlign: TextAlign.justify,
                  title.description ?? '',
                  style: Theme.of(context).textTheme.bodyLarge,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
            Align(
                alignment: Alignment.topRight,
                child: TextButton(
                    onPressed: onTap,
                    child: _isExpanded
                        ? const Text(Constants.hide)
                        : const Text(Constants.more)))
          ],
        ),
      ),
    );
  }
}
