import 'package:flutter/material.dart';

class FabMenuWidget extends StatefulWidget {
  final Function onPressedAdd;
  final Function onPressedSettings;

  const FabMenuWidget(
      {@required this.onPressedAdd, @required this.onPressedSettings});
  @override
  _FabMenuWidgetState createState() => _FabMenuWidgetState();
}

class _FabMenuWidgetState extends State<FabMenuWidget>
    with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  AnimationController _animationController;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;

  final Curve _curve = Curves.easeOut;
  final double _fabHeight = 56;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250))
          ..addListener(() {
            setState(() {});
          });

    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _translateButton = Tween<double>(begin: _fabHeight, end: -14).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 0.75, curve: _curve)));

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _animate() {
    if (_isOpen) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    _isOpen = !_isOpen;
  }

  Widget _add() {
    return Container(
      child: FloatingActionButton(
        heroTag: {'heroTag': 'add'},
        child: Icon(Icons.add),
        onPressed: () {
          widget.onPressedAdd();
          _animate();
        },
      ),
    );
  }

  Widget _settings() {
    return Container(
      child: FloatingActionButton(
          heroTag: {'heroTag': 'settings'},
          child: Icon(Icons.settings),
          onPressed: () {
            widget.onPressedSettings();
            _animate();
          }),
    );
  }

  Widget _tooggle() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: _animate,
        tooltip: 'Menu',
        child: AnimatedIcon(
            icon: AnimatedIcons.menu_close, progress: _animateIcon),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0,
            _translateButton.value * 2,
            0,
          ),
          child: _add(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0,
            _translateButton.value,
            0,
          ),
          child: _settings(),
        ),
        _tooggle(),
      ],
    );
  }
}
