import 'package:flutter/material.dart';

class ContinueSlider extends StatefulWidget {
  const ContinueSlider({
    super.key,
    required this.width
  });


  final double width;

  @override
  State<ContinueSlider> createState() => _ContinueSliderState();
}

class _ContinueSliderState extends State<ContinueSlider> {
  double width = 0;
  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(milliseconds: 50),
        () => setState(() {
              width = widget.width;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
          color: Colors.grey,
          height: 5,
          child: Row(
            children: [
              AnimatedSize(
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 1500),
                child: Container(
                  color: Theme.of(context).primaryColor,
                  width: width,
                ),
              ),
            ],
          ),
        );
  }
}
