import 'package:flutter/material.dart';

class SkipOrContinueOpening extends StatelessWidget {
  final VoidCallback? onTapSkip;
  final VoidCallback? onTapContinue;
  const SkipOrContinueOpening({
    super.key,
    this.onTapSkip,
    this.onTapContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
                onPressed: onTapContinue,
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).primaryColor.withAlpha(100),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                child: const Text('Смотреть')),
            const SizedBox(
              width: 25,
            ),
            SkipButton(
              onTap: onTapSkip,
            ),
            const SizedBox(
              width: 40,
            ),
          ],
        ),
      ),
    );
  }
}

class SkipButton extends StatefulWidget {
  final VoidCallback? onTap;
  const SkipButton({
    super.key,
    this.onTap,
  });

  @override
  State<SkipButton> createState() => _SkipButtonState();
}

class _SkipButtonState extends State<SkipButton> {
  double width = 0;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1))
        .then((value) => setState(() {
              width = 165;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 40,
        width: 165,
        color: Theme.of(context).primaryColor.withAlpha(100),
        child: Stack(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: AnimatedSize(
                  duration: const Duration(seconds: 3),
                  child: Container(
                    width: width,
                    height: double.infinity,
                    color: Theme.of(context).primaryColor.withGreen(190),
                  ),
                )),
            const Center(child: Text('Пропустить')),
            Material(
              color: Colors.transparent,
              child: InkWell(onTap: widget.onTap, child: Ink()),
            )
          ],
        ),
      ),
    );
  }
}
