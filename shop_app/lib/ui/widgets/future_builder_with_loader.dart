import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FutureBuilderWithLoader<T> extends StatelessWidget {
  final Future future;
  final bool needScaffold;
  final Widget Function(BuildContext, T) builder;
  final T initialData;

  const FutureBuilderWithLoader(
      {Key key,
      this.future,
      this.builder,
      this.initialData,
      this.needScaffold = false})
      : super(key: key);

  Widget buildFutureBuilder() => FutureBuilder<T>(
      initialData: initialData,
      future: future,
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Center(child: CircularProgressIndicator())
              : builder.call(context, snapshot.data));

  @override
  Widget build(BuildContext context) {
    return needScaffold
        ? Scaffold(
            body: buildFutureBuilder(),
          )
        : buildFutureBuilder();
  }
}
