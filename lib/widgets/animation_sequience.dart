import 'package:flutter/material.dart';

class BlankFillGuide extends StatefulWidget {
  final Widget child;

  const BlankFillGuide({Key? key, required this.child}) : super(key: key);

  @override
  _BlankFillGuideState createState() => _BlankFillGuideState();
}

class _BlankFillGuideState extends State<BlankFillGuide>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeInOutAnimation;

  final _guideItems = [
    GuideItem(
      Rect.fromLTRB(50, 100, 250, 150),
      'Enter your name here',
      Icons.person,
    ),
    GuideItem(
      Rect.fromLTRB(50, 200, 250, 250),
      'Enter your email here',
      Icons.email,
    ),
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeInOutAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        widget.child,
        // Add an animated layer on top of the app's UI
        AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget? child) {
            return Opacity(
              opacity: _fadeInOutAnimation.value,
              child: Stack(
                children: [
                  for (final item in _guideItems)
                    Positioned.fromRect(
                      rect: item.rect,
                      child: Material(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(item.icon),
                              const SizedBox(height: 8),
                              Text(item.text),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
        // Add a button to show/hide the guide screen
        Positioned(
          top: 48,
          right: 16,
          child: ElevatedButton(
            onPressed: () {
              if (_controller.isCompleted) {
                _controller.reverse();
              } else {
                _controller.forward();
              }
            },
            child: Text('Show/Hide Guide'),
          ),
        ),
      ],
    );
  }
}

class GuideItem {
  final Rect rect;
  final String text;
  final IconData icon;

  const GuideItem(this.rect, this.text, this.icon);
}
