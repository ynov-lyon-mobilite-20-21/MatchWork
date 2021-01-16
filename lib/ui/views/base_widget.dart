import 'package:flutter/material.dart';
import 'package:match_work/core/viewmodels/base_model.dart';
import 'package:provider/provider.dart';

class BaseWidget<T extends BaseModel> extends StatefulWidget {
  final Widget Function(BuildContext, T, Widget) builder;
  final T model;
  final Widget child;
  final Function(T) onModelReady;

  BaseWidget(
      {Key key,
      @required this.builder,
      this.model,
      this.child,
      this.onModelReady})
      : super(key: key);

  @override
  _BaseWidgetState<T> createState() => _BaseWidgetState<T>();
}

class _BaseWidgetState<T extends BaseModel> extends State<BaseWidget<T>> {
  T model;

  @override
  void initState() {
    model = widget.model;
    if (widget.onModelReady != null) widget.onModelReady(model);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    model.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: model,
      child: Consumer<T>(
        child: widget.child,
        builder: widget.builder,
      ),
    );
  }
}
