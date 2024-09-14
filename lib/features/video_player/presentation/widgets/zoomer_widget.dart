import 'dart:async';

import 'package:flutter/material.dart';

class ZoomerWidget extends StatefulWidget {
  final double minScale;
  final double maxScale;
  final Widget child;
  const ZoomerWidget({
    super.key,
    required this.child,
    required this.minScale,
    required this.maxScale,
  });

  @override
  State<ZoomerWidget> createState() => _ZoomerWidgetState();
}

class _ZoomerWidgetState extends State<ZoomerWidget> {
   final TransformationController _transformationController =
      TransformationController();
  int scale = 100;
  Timer? timer;
  bool showScale = false;

  void changeScale(double scaleInDouble) {
    scale = (scaleInDouble * 100).toInt();
    showScale = true;
    timer?.cancel();
    setState(() {});
    timer = Timer(
        const Duration(seconds: 1),
        () => setState(
              () => showScale = false,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InteractiveViewer(
          transformationController: _transformationController,
          onInteractionUpdate: (details) {
             changeScale(_transformationController.value.getMaxScaleOnAxis());
          },
            minScale: widget.minScale,
            maxScale: widget.maxScale,
            clipBehavior: Clip.none,
            child: widget.child),
        if (showScale)
          Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('$scale  %', style: TextStyle(color: Theme.of(context).primaryColor),),
              ))
      ],
    );
  }
}
