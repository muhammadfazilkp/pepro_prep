import 'package:flutter/material.dart';

class ModelFutureBuilder<T> extends StatelessWidget {
  const ModelFutureBuilder({
    Key? key,
    required this.busy,
    required this.data,
    required this.builder,
    this.error,
    this.loading,
  }) : super(key: key);

  final bool busy;
  final T? data;
  final Widget? error;
  final Widget? loading;
  final ValueWidgetBuilder<T> builder;

  @override
  Widget build(BuildContext context) {
    if (busy) {
      return loading ??
          const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
    } else {
      if (data == null) {
        return error ??
            const Center(
              child: Text(
                'Something went wrong',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            );
      } else {
        return builder(context, data!, null);
      }
    }
  }
}

class ModelFutureListBuilder<T> extends StatelessWidget {
  const ModelFutureListBuilder({
    Key? key,
    required this.busy,
    required this.data,
    required this.builder,
    this.empty,
    this.loading,
  }) : super(key: key);

  final bool busy;
  final List<T> data;
  final Widget? empty;
  final Widget? loading;
  final ValueWidgetBuilder<List<T>> builder;

  @override
  Widget build(BuildContext context) {
    if (busy) {
      return loading ??
          Center(
            // child: Lottie.asset('assets/lottie/pacman-loading.json', width: 180),
            // child: CircularProgressIndicator(
            //   color: Colors.white,
            // ),
          );
    } else {
      if (data.isEmpty) {
        return empty ??
            const Center(
              child: Text(
                'List is empty',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
      } else {
        return builder(context, data, null);
      }
    }
  }
}
