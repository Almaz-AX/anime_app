import 'package:anime_app/constants/constants.dart';
import 'package:anime_app/features/detail/presentation/blocs/detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final release = BlocProvider.of<DetailBloc>(context).state.release;
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
                  release?.description ?? '',
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
