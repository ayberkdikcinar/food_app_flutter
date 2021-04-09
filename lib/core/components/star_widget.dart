import 'package:flutter/material.dart';

class StarWidget extends StatefulWidget {
  StarWidget({Key? key, this.initState, required this.onStarTap}) : super(key: key);

  final Function(bool val) onStarTap;
  final initState;
  @override
  _StarWidgetState createState() => _StarWidgetState();
}

class _StarWidgetState extends State<StarWidget> {
  bool star_state = false;
  @override
  void initState() {
    if (widget.initState == true) {
      star_state = true;
    } else {
      star_state = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: star_state == false
            ? Icon(Icons.star_border)
            : Icon(
                Icons.star_rounded,
                color: Theme.of(context).hoverColor,
              ),
        onPressed: () {
          widget.onStarTap(star_state);
          setState(() {
            star_state = !star_state;
          });
        });
  }
}

///It keeps it's own state, thanks to that, when star tapped, only it's state changes,not the whole screen's.
