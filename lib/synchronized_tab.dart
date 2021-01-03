import 'package:flutter/material.dart';

class TabSynchronized extends StatefulWidget {
  @required
  final ScrollController scrollController;
  @required
  final List<double> listOffset;
  @required
  final Widget child;
  @required
  final int currentIndex;
  @required
  final bool isActivated;

  const TabSynchronized(
      {Key key,
      this.scrollController,
      this.listOffset,
      this.child,
      this.currentIndex,
      this.isActivated})
      : super(key: key);
  @override
  TabSynchronizedState createState() => TabSynchronizedState();
}

class TabSynchronizedState extends State<TabSynchronized> {
  double width = 0;
  void activate() {
    setState(() {
      width = 5;
    });
  }

  void deactivate() {
    setState(() {
      width = 0;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isActivated == true) {
      setState(() {
        width = 5;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Colors.blue, width: width))),
        height: 50,
        child: InkWell(
          child: widget.child,
          onTap: () {
            widget.scrollController.animateTo(
              widget.listOffset[widget.currentIndex],
              duration: Duration(seconds: 1),
              curve: Curves.ease,
            );
          },
        ),
      ),
    );
  }
}
