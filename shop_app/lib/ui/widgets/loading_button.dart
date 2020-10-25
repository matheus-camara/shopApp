import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class LoadingButton extends StatefulWidget {
  final Future Function() onPressed;
  final Future Function() onLongPress;
  final ValueChanged<bool> onHighlightChanged;
  final MouseCursor mouseCursor;
  final ButtonTextTheme textTheme;
  final Color textColor;
  final Color disabledTextColor;
  final Color color;
  final Color disabledColor;
  final Color focusColor;
  final Color hoverColor;
  final Color highlightColor;
  final Color splashColor;
  final Brightness colorBrightness;
  final EdgeInsetsGeometry padding;
  final VisualDensity visualDensity;
  final ShapeBorder shape;
  final Clip clipBehavior;
  final FocusNode focusNode;
  final bool autofocus;
  final MaterialTapTargetSize materialTapTargetSize;
  final Widget child;
  final double height;
  final double minWidth;

  const LoadingButton({
    Key key,
    @required this.onPressed,
    this.onLongPress,
    this.onHighlightChanged,
    this.mouseCursor,
    this.textTheme,
    this.textColor,
    this.disabledTextColor,
    this.color,
    this.disabledColor,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.colorBrightness,
    this.padding,
    this.visualDensity,
    this.shape,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.materialTapTargetSize,
    this.minWidth,
    this.height,
    this.child,
  }) : super(key: key);

  @override
  _LoadingButtonState createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  var _loading = false;

  void onPressed() async {
    setState(() {
      _loading = true;
    });

    await widget.onPressed();

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: _loading ? null : onPressed,
      child: _loading ? CircularProgressIndicator() : widget.child,
      autofocus: widget.autofocus,
      clipBehavior: widget.clipBehavior,
      color: widget.color,
      colorBrightness: widget.colorBrightness,
      disabledColor: widget.disabledColor,
      disabledTextColor: widget.disabledTextColor,
      focusColor: widget.focusColor,
      focusNode: widget.focusNode,
      height: widget.height,
      highlightColor: widget.highlightColor,
      hoverColor: widget.hoverColor,
      key: widget.key,
      materialTapTargetSize: widget.materialTapTargetSize,
      minWidth: widget.minWidth,
      mouseCursor: widget.mouseCursor,
      onHighlightChanged: widget.onHighlightChanged,
      onLongPress: widget.onLongPress,
      padding: widget.padding,
      shape: widget.shape,
      splashColor: widget.splashColor,
      textColor: widget.textColor,
      textTheme: widget.textTheme,
      visualDensity: widget.visualDensity,
    );
  }
}
